//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Development on 23/8/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var countries = ["Estonia", "France", "Germany", "Ireland",
    "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var showGameOver = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    
   
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue,.black]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

           
            VStack(spacing: 5){
                Text("Guess the Flag")
                   .font(.largeTitle.weight(.bold))
                   .foregroundColor(.white)
                
                Text("Tap the flag of")
                      .foregroundColor(.white)

                VStack(spacing: 20) {
                 
                  Text(countries[correctAnswer])
                        .foregroundColor(.white)
                    
                    ForEach(0..<3) { number in
                      Button {
                          flagTapped(number)
                      } label: {
                      
                          Image(countries[number])
                          .renderingMode(.original)
                      }
                    }
                }
               
            }.onChange(of: score) { newValue in
                print("Name changed to \(newValue)!")
                if(score < 0) {
                    showGameOver = true
                    score = 0
                    showingScore = false
                }
            }
            
        }.alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
          } message: {
            Text("Your score is \(score)")
          }
          .alert(scoreTitle, isPresented: $showGameOver) {
              Button("Ok", action:{})
            } message: {
              Text("Game over. Bye..")
            }
        

        
    }
    
    func askQuestion() {
      countries.shuffle()
      correctAnswer = Int.random(in: 0...2)
    }
    
    
    func flagTapped(_ number: Int) {
      if number == correctAnswer {
        scoreTitle = "Correct"
        score += 1
          
      } else {
        score -= 1
        scoreTitle = "Wrong"
          
      }
      showingScore = true
    }
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
