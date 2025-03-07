import SwiftUI

struct InfoView: View {
    @Binding var viewState: ViewState
    let images: Images
    @StateObject var orientationManager = OrientationManager()
    
    var body: some View {
        ZStack {
            if orientationManager.isLandscape {
                RemoteImage(url: images.bgAnythingLand)
                    .scaledToFill()
                    .ignoresSafeArea()
            } else {
                RemoteImage(url: images.bgAnything)
                    .scaledToFill()
                    .ignoresSafeArea()
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        viewState = .menu
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.white)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding()
                    }
                }
                .padding(
                    .top,
                    orientationManager.isLandscape ? UIScreen.main.bounds.height * 0.08 : UIScreen.main.bounds.width * 0.08
                )
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 12) {
                    ScrollView {
                        Text("ℹ How to Play")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("1. Select a level using the '←' and '→' buttons.")
                        Text("2. Fill in the empty squares with the correct letters.")
                        Text("3. Correct letters will be highlighted.")
                        Text("4. Complete the crossword before the timer runs out.")
                        Text("5. If all words are correct, you win!")
                        
                        Text("⏳ Timer")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top, 10)
                        
                        Text("- The countdown starts as soon as the level begins.")
                        Text("- If time reaches zero, the game ends.")
                        Text("- Solving the crossword before time runs out stops the timer.")
                        
                        Text("⚙ Controls")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top, 10)
                        
                        Text("- 'X' button: Return to the menu.")
                        Text("- '←' and '→' buttons: Switch levels.")
                        Text("- Tap on a square to enter a letter.")
                        
                        Text("🏆 Goal")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top, 10)
                        
                        Text("Solve all the words before time runs out. The faster you solve it, the better your score!")
                        
                        Text("🎉 Good luck!")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top, 10)
                    }
                    .foregroundColor(.white)
                    .padding()
                }
                
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}
