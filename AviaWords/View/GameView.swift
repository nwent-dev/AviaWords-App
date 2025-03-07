import SwiftUI

struct CrosswordWord {
    let word: String
    let startRow: Int
    let startCol: Int
    let isHorizontal: Bool
    let isHidden: Bool 
}

struct CrosswordCell: Identifiable {
    let id = UUID()
    var letter: String
    var isEditable: Bool
    var correctLetter: String? = nil
    var imageName: String? = nil
}


struct Crossword {
    var grid: [[CrosswordCell]]
    var gridSize: Int

    init(words: [CrosswordWord], images: [(row: Int, col: Int, image: String)], gridSize: Int) {
        self.gridSize = gridSize
        self.grid = Array(repeating: Array(repeating: CrosswordCell(letter: "", isEditable: false, correctLetter: nil, imageName: nil), count: gridSize), count: gridSize)
        
        for word in words {
            let letters = Array(word.word)
            for i in 0..<letters.count {
                let row = word.isHorizontal ? word.startRow : word.startRow + i
                let col = word.isHorizontal ? word.startCol + i : word.startCol
                
                let isEditable = word.isHidden
                let letter = word.isHidden ? "" : String(letters[i])
                
                grid[row][col] = CrosswordCell(letter: letter, isEditable: isEditable, correctLetter: String(letters[i]), imageName: nil)
            }
        }
        
        for image in images {
            grid[image.row][image.col] = CrosswordCell(letter: "", isEditable: false, correctLetter: nil, imageName: image.image)
        }
    }
}

struct CrosswordView: View {
    let level: Int
    @State private var crossword: Crossword
    let images: Images
    @Binding var isGameWon: Bool
    @StateObject var orientationManager = OrientationManager()

    init(level: Int, images: Images, isGameWon: Binding<Bool>) {
        self.level = level
        self.images = images
        self._crossword = State(initialValue: CrosswordView.getCrossword(for: level, images: images))
        self._isGameWon = isGameWon
    }

    static func getCrossword(for level: Int, images: Images) -> Crossword {
        
        switch level {
        case 1:
            return Crossword(
                words: [
                    CrosswordWord(word: "AIRFIELD", startRow: 2, startCol: 1, isHorizontal: true, isHidden: false),
                    CrosswordWord(word: "IR", startRow: 3, startCol: 1, isHorizontal: false, isHidden: true),
                    CrosswordWord(word: "P", startRow: 1, startCol: 5, isHorizontal: true, isHidden: true),
                    CrosswordWord(word: "LOT", startRow: 3, startCol: 5, isHorizontal: false, isHidden: true),
                    CrosswordWord(word: "P", startRow: 1, startCol: 7, isHorizontal: true, isHidden: true),
                    CrosswordWord(word: "ANE", startRow: 3, startCol: 7, isHorizontal: false, isHidden: true)
                ],
                images: [(row: 2, col: 0, image: images.airfield),
                         (row: 1, col: 1, image: images.air),
                         (row: 0, col: 5, image: images.pilot),
                         (row: 0, col: 7, image: images.plane)],
                gridSize: 9
            )
        case 2:
            return Crossword(
                words: [
                    CrosswordWord(word: "AEROPLANE", startRow: 3, startCol: 3, isHorizontal: true, isHidden: false),
                    CrosswordWord(word: "CH", startRow: 1, startCol: 3, isHorizontal: false, isHidden: true),
                    CrosswordWord(word: "SSIS", startRow: 4, startCol: 3, isHorizontal: false, isHidden: true),
                    CrosswordWord(word: "TA", startRow: 6, startCol: 1, isHorizontal: true, isHidden: true),
                    CrosswordWord(word: "L", startRow: 6, startCol: 4, isHorizontal: true, isHidden: true),
                    CrosswordWord(word: "L", startRow: 2, startCol: 8, isHorizontal: false, isHidden: true),
                    CrosswordWord(word: "LUMINAT", startRow: 4, startCol: 8, isHorizontal: false, isHidden: true),
                    CrosswordWord(word: "OR", startRow: 10, startCol: 9, isHorizontal: true, isHidden: true),
                    CrosswordWord(word: "WI", startRow: 1, startCol: 10, isHorizontal: false, isHidden: true),
                    CrosswordWord(word: "G", startRow: 4, startCol: 10, isHorizontal: false, isHidden: true),
                ],
                images: [(row: 0, col: 3, image: images.chassis),
                         (row: 3, col: 2, image: images.aeroplane),
                         (row: 6, col: 0, image: images.tail),
                         (row: 1, col: 8, image: images.illuminator),
                         (row: 0, col: 10, image: images.wing),],
                gridSize: 12
            )
        case 3:
            return Crossword(
                words: [
                    CrosswordWord(word: "ILLUMINATOR", startRow: 5, startCol: 1, isHorizontal: true, isHidden: false),
                    CrosswordWord(word: "WHEE", startRow: 1, startCol: 2, isHorizontal: false, isHidden: true),
                    CrosswordWord(word: "ANE", startRow: 6, startCol: 3, isHorizontal: false, isHidden: true),
                    CrosswordWord(word: "ENG", startRow: 2, startCol: 6, isHorizontal: false, isHidden: true),
                    CrosswordWord(word: "NE", startRow: 6, startCol: 6, isHorizontal: false, isHidden: true),
                    CrosswordWord(word: "OSE", startRow: 3, startCol: 7, isHorizontal: true, isHidden: true),
                    CrosswordWord(word: "E", startRow: 4, startCol: 8, isHorizontal: true, isHidden: true),
                    CrosswordWord(word: "T", startRow: 6, startCol: 8, isHorizontal: true, isHidden: true),
                    CrosswordWord(word: "AMP", startRow: 6, startCol: 11, isHorizontal: false, isHidden: true),
                    CrosswordWord(word: "AMP", startRow: 8, startCol: 8, isHorizontal: true, isHidden: true),
                    CrosswordWord(word: "UEL", startRow: 9, startCol: 8, isHorizontal: false, isHidden: true),
                ],
                images: [
                        (row: 5, col: 0, image: images.illuminator),
                        (row: 0, col: 2, image: images.wheel),
                        ],
                gridSize: 12
            )
        default:
            return Crossword(words: [],images: [(row: 0, col: 0, image: "")], gridSize: 5)
        }
    }

    var body: some View {
        let screenSize = orientationManager.isLandscape ? UIScreen.main.bounds.height * 0.95 : UIScreen.main.bounds.width * 0.95
        let cellSize = screenSize / CGFloat(crossword.gridSize)

        ZStack {
            VStack(spacing: 0) {
                ForEach(0..<crossword.grid.count, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<crossword.grid[row].count, id: \.self) { col in
                            CellView(cell: $crossword.grid[row][col], cellSize: cellSize, checkCompletion: checkCompletion)
                        }
                    }
                }
            }
            .frame(width: screenSize, height: screenSize)
        }
        .animation(.easeInOut, value: isGameWon)
    }

    func checkCompletion() {
        for row in crossword.grid {
            for cell in row {
                if cell.isEditable, cell.letter != cell.correctLetter {
                    return
                }
            }
        }
        isGameWon = true
    }
}


struct CellView: View {
    @Binding var cell: CrosswordCell
    let cellSize: CGFloat
    let checkCompletion: () -> Void

    var body: some View {
        if let imageName = cell.imageName {
            RemoteImage(url: imageName)
                .scaledToFit()
                .frame(width: cellSize, height: cellSize)
        } else {
            TextField("", text: Binding(
                get: { cell.letter },
                set: { newValue in
                    if cell.isEditable {
                        let uppercased = String(newValue.prefix(1)).uppercased()
                        cell.letter = uppercased
                        checkCompletion()
                    }
                }
            ))
            .foregroundStyle(cell.letter == cell.correctLetter ? Color.white : (cell.isEditable ? Color.red : Color.clear))
            .font(.title)
            .fontWeight(.bold)
            .frame(width: cellSize, height: cellSize)
            .border(cell.letter == cell.correctLetter ? Color.red : (cell.isEditable ? Color.red : Color.clear.opacity(0.3)), width: 2)
            .multilineTextAlignment(.center)
            .disabled(!cell.isEditable)
            .background(cell.letter == cell.correctLetter ? Color.black : (cell.isEditable ? Color.black : Color.clear))
        }
    }
}

struct GameView: View {
    @State var isGameWon: Bool = false // Is game won
    @Binding var viewState: ViewState  // Current View State
    let images: Images                 // All images
    @Binding var timeRemaining: Int    // Start time in seconds
    @Binding var selectedLevel: Int    // Current level
    @State private var timerRunning: Bool = true
    @StateObject var orientationManager = OrientationManager()

    var body: some View {
        ZStack {
            // MARK: - Landscape MODE
            if orientationManager.isLandscape {
                
                // Background Image
                RemoteImage(url: images.bgGameLand)
                    .ignoresSafeArea()
                    .scaledToFill()
                
                HStack {
                    Spacer()
                    
                    // Crossword
                    VStack {
                        CrosswordView(level: selectedLevel, images: images, isGameWon: $isGameWon)
                    }
                    
                    Spacer()
                    
                    VStack {
                        HStack {
                            // Timer
                            Text("⏳ \(formatTime(seconds: timeRemaining))")
                                .font(.title2)
                                .foregroundStyle(timeRemaining <= 10 ? .red : .white)
                                .padding(.trailing)
                            
                            // Close button (xmark)
                            Button {
                                withAnimation {
                                    viewState = .menu
                                }
                            } label: {
                                Image(systemName: "xmark")
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                            }
                            .padding(.trailing)
                        }
                        
                        // Show round
                        VStack {
                            ForEach(Array("ROUND \(selectedLevel)"), id: \.self) { letter in
                                Text(String(letter))
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                            }
                        }
                    }
                }
            // MARK: - Vertical MODE
            } else {
                RemoteImage(url: images.bgGame)
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Spacer()
                        
                        // Close button
                        Button {
                            withAnimation {
                                viewState = .menu
                            }
                        } label: {
                            Image(systemName: "xmark")
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                        }
                        .padding(.trailing)
                    }
                    .padding(.top, UIScreen.main.bounds.height * 0.07)
                    
                    // Show round
                    Text("ROUND \(selectedLevel)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)

                    // Show timer
                    HStack {
                        Spacer()
                        
                        Text("⏳ \(formatTime(seconds: timeRemaining))")
                            .font(.title2)
                            .foregroundStyle(timeRemaining <= 10 ? .red : .white) // Красный, если мало времени
                            .padding(.trailing)
                    }
                    
                    Spacer()
                    
                    // Crossword
                    CrosswordView(level: selectedLevel, images: images, isGameWon: $isGameWon)
                    
                    Spacer()
                }
            }
            
            // Show win card
            if isGameWon {
                RemoteImage(url: images.winCard)
                    .scaledToFit()
                    .frame(width: orientationManager.isLandscape ? UIScreen.main.bounds.height * 0.9 : UIScreen.main.bounds.width * 0.9)
            }
            
            // Show lose card
            if timeRemaining <= 0 {
                RemoteImage(url: images.loseCard)
                    .scaledToFit()
                    .frame(width: orientationManager.isLandscape ? UIScreen.main.bounds.height * 0.9 : UIScreen.main.bounds.width * 0.9)
            }
        }
        .onAppear {
            startCountdown()
        }
        .onChange(of: isGameWon) { newValue in
            if newValue {
                timerRunning = false
            }
        }
    }
    
    func formatTime(seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    func startCountdown() {
        timerRunning = true
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if timeRemaining > 0 && timerRunning {
                timeRemaining -= 1
            } else {
                timer.invalidate()
            }
        }
    }
}
