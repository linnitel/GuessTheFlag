//
//  ContentView.swift
//  GuesTheFlag
//
//  Created by Julia Martcenko on 21/01/2025.
//

import SwiftUI

struct ContentView: View {
	@State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
	@State private var correctAnswer = Int.random(in: 0...2)

	@State private var showingScore = false
	@State private var activeAlert: ActiveAlert = .firstAlert
	@State private var scoreTitle = ""

	@State private var score = 0
	@State private var roundCounter = 1

    var body: some View {
		ZStack {
			LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
				.ignoresSafeArea()
			VStack {
				Text("Guess the flag")
					.header()
				Spacer()
				VStack(spacing: 30) {
					VStack {
						Text("Tap the flag of")
							.foregroundStyle(.white)
							.font(.subheadline.weight(.heavy))
						Text(countries[correctAnswer])
							.foregroundStyle(.white)
							.font(.largeTitle.weight(.semibold))
					}

					ForEach (0..<3) { number in
						Button {
							flagTapped(number)
						} label: {
							FlagImage(name: countries[number])
						}

					}
				}
				Spacer()
				Spacer()
				Text("Score: \(score)")
					.foregroundStyle(.white)
					.font(.title.bold())
				Spacer()
			}
		}
		.alert("Game over", isPresented: $showingScore) {
			Button("New game", action: restart)
		} message: {
			Text("Your score is \(score)")
		}
    }

	func flagTapped(_ number: Int) {
		if number == correctAnswer {
			score += 1
		}
		if roundCounter < 8 {
			roundCounter += 1
			newRound()

		} else {
			activeAlert = .thirdAlert
			showingScore = true
		}
	}

	func restart() {
		countries.shuffle()
		correctAnswer = Int.random(in: 0...2)
		showingScore = false
		score = 0
		roundCounter = 1
	}

	func newRound() {
		countries.shuffle()
		correctAnswer = Int.random(in: 0...2)
	}

	enum ActiveAlert {
		case firstAlert
		case secondAlert
		case thirdAlert
	}
}

struct FlagImage: View {
	var name: String

	var body: some View {
		Image("\(name)")
			.clipShape(.capsule)
			.shadow(radius: 5)

	}
}

struct Header: ViewModifier {

	func body(content: Content) -> some View {
		content
			.font(.headline)
			.foregroundColor(.white)
			.padding()
			.background(Color.blue)
	}
}

extension View {
	func header() -> some View {
		modifier(Header())
	}
}

#Preview {
    ContentView()
}
