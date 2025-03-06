import SwiftUI

struct LevelView: View {
    @Binding var viewState: ViewState
    let images: Images
    @Binding var selectedLevel: Int
    @State private var isGameWon: Bool = false
    @StateObject var orientationManager = OrientationManager()

    var body: some View {
        ZStack {
            // MARK: - Horizontal MODE

            if orientationManager.isLandscape {
                RemoteImage(url: images.bgAnythingLand)
                    .scaledToFill()
                    .ignoresSafeArea()

                HStack {
                    Spacer()

                    CrosswordView2(level: $selectedLevel, images: images, isGameWon: $isGameWon)
                        .allowsHitTesting(false)

                    Spacer()

                    VStack {
                        HStack {
                            Spacer()
                            Image(systemName: "xmark")
                                .foregroundStyle(.white)
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.trailing)
                                .onTapGesture {
                                    withAnimation {
                                        viewState = .menu
                                    }
                                }
                        }
                        .padding(.top, UIScreen.main.bounds.width * 0.08)

                        Spacer()

                        HStack {
                            Spacer()

                            Button {
                                if selectedLevel > 0 {
                                    selectedLevel -= 1
                                }
                            } label: {
                                Image(systemName: "arrow.left")
                                    .foregroundStyle(.white)
                                    .font(.title)
                            }

                            Spacer()

                            Button {
                                if selectedLevel < 3 {
                                    selectedLevel += 1
                                }
                            } label: {
                                Image(systemName: "arrow.right")
                                    .foregroundStyle(.white)
                                    .font(.title)
                            }

                            Spacer()
                        }
                        
                        Button {
                            withAnimation {
                                viewState = .game
                            }
                        } label: {
                            RemoteImage(url: images.startBtn)
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.height * 0.3)
                        }

                        Spacer()
                    }
                }

                // MARK: - Vertical MODE
            } else {
                RemoteImage(url: images.bgAnything)
                    .scaledToFill()
                    .ignoresSafeArea()

                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "xmark")
                            .foregroundStyle(.white)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.trailing)
                            .onTapGesture {
                                withAnimation {
                                    viewState = .menu
                                }
                            }
                    }
                    .padding(.top, UIScreen.main.bounds.width * 0.08)

                    Spacer()

                    CrosswordView2(level: $selectedLevel, images: images, isGameWon: $isGameWon)
                        .allowsHitTesting(false)

                    HStack {
                        Spacer()

                        Button {
                            if selectedLevel > 0 {
                                selectedLevel -= 1
                            }
                        } label: {
                            Image(systemName: "arrow.left")
                                .foregroundStyle(.white)
                                .font(.title)
                        }

                        Spacer()

                        Button {
                            if selectedLevel < 3 {
                                selectedLevel += 1
                            }
                        } label: {
                            Image(systemName: "arrow.right")
                                .foregroundStyle(.white)
                                .font(.title)
                        }

                        Spacer()
                    }
                    
                    Button {
                        withAnimation {
                            viewState = .game
                        }
                    } label: {
                        RemoteImage(url: images.startBtn)
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width * 0.5)
                    }

                    Spacer()
                }
            }
        }
    }
}

struct CrosswordView2: View {
    @Binding var level: Int // 📌 Теперь это @Binding
    let images: Images
    @Binding var isGameWon: Bool

    var crossword: Crossword { // 📌 Теперь кроссворд обновляется при изменении уровня
        CrosswordView2.getCrossword(for: level, images: images)
    }

    static func getCrossword(for level: Int, images: Images) -> Crossword {
        switch level {
        case 1:
            return Crossword(
                words: [
                    CrosswordWord(word: "AIRFIELD", startRow: 2, startCol: 1, isHorizontal: true, isHidden: true),
                    CrosswordWord(word: "IR", startRow: 3, startCol: 1, isHorizontal: false, isHidden: true),
                    CrosswordWord(word: "P", startRow: 1, startCol: 5, isHorizontal: true, isHidden: true),
                    CrosswordWord(word: "LOT", startRow: 3, startCol: 5, isHorizontal: false, isHidden: true),
                    CrosswordWord(word: "P", startRow: 1, startCol: 7, isHorizontal: true, isHidden: true),
                    CrosswordWord(word: "ANE", startRow: 3, startCol: 7, isHorizontal: false, isHidden: true),
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
                    CrosswordWord(word: "AEROPLANE", startRow: 3, startCol: 3, isHorizontal: true, isHidden: true),
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
                         (row: 0, col: 10, image: images.wing)],
                gridSize: 12
            )
        case 3:
            return Crossword(
                words: [
                    CrosswordWord(word: "ILLUMINATOR", startRow: 5, startCol: 1, isHorizontal: true, isHidden: true),
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
                    (row: 9, col: 3, image: images.lane),
                    (row: 9, col: 3, image: images.lane),
                    (row: 1, col: 6, image: images.engine),
                    (row: 3, col: 5, image: images.nose),
                    (row: 2, col: 8, image: images.seat),
                    (row: 7, col: 8, image: images.fuel),
                    (row: 8, col: 12, image: images.flap),
                    (row: 4, col: 11, image: images.ramp),
                ],
                gridSize: 13
            )
        default:
            return Crossword(words: [], images: [(row: 0, col: 0, image: "")], gridSize: 5)
        }
    }

    var body: some View {
        let screenSize = OrientationManager().isLandscape ? UIScreen.main.bounds.height * 0.95 : UIScreen.main.bounds.width * 0.95
        let cellSize = screenSize / CGFloat(crossword.gridSize)

        ZStack {
            VStack(spacing: 0) {
                ForEach(0..<crossword.grid.count, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<crossword.grid[row].count, id: \.self) { col in
                            let cellBinding = Binding(
                                get: { crossword.grid[row][col] },
                                set: { _ in }
                            )
                            CellView(cell: cellBinding, cellSize: cellSize, checkCompletion: checkCompletion)
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
