import SwiftUI
import WebKit

enum ViewState {
    case menu, game, level, time, volume, info
}

struct MainView: View {
    @StateObject private var imageService = ImageService()
    @State private var isConnectedToInternet = true
    @State private var viewState: ViewState = .menu
    @State private var time: Int = 60
    @State private var selectedLevel: Int = 1
    @State private var isSoundOff: Bool = true
    
    init() {
        checkInternetConnection()
    }
    
    var body: some View {
        ZStack {
            if !isConnectedToInternet {
                VStack {
                    Text("No internet connection. Please check your network and try again.")
                        .multilineTextAlignment(.center)
                        .padding()
                    Button("Retry") {
                        checkInternetConnection()
                        imageService.fetchImages()
                    }
                }
            } else if let images = imageService.imageResponse?.images {
                switch viewState {
                case .menu:
                    MenuView(viewState: $viewState, images: images)
                case .game:
                    GameView(viewState: $viewState, images: images, timeRemaining: $time, selectedLevel: $selectedLevel)
                case .level:
                    LevelView(viewState: $viewState, images: images, selectedLevel: $selectedLevel)
                case .time:
                    TimeView(viewState: $viewState, images: images, time: $time)
                case .volume:
                    VolumeView(viewState: $viewState, images: images, isSoundOff: $isSoundOff)
                case .info:
                    InfoView(viewState: $viewState, images: images)
                }
            } else if imageService.isLoading {
                VStack {
                    ProgressView("Loading...")
                        .padding()
                    Text("Please wait")
                }
            } else {
                WebView(url: URL(string: "https://aviawords.fun")!)
            }
        }
        .onAppear {
            if imageService.imageResponse == nil && !imageService.isLoading {
                checkInternetConnection()
                imageService.fetchImages()
            }
        }
    }
    
    private func checkInternetConnection() {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "InternetConnectionMonitor")
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                isConnectedToInternet = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
}
