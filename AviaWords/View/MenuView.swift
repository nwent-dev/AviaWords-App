import SwiftUI

struct MenuView: View {
    @Binding var viewState: ViewState
    let images: Images

    var body: some View {
        ZStack {
            if OrientationManager().isLandscape {
                RemoteImage(url: images.bgMenuLand)
                    .scaledToFill()
                    .ignoresSafeArea()
            } else {
                RemoteImage(url: images.bgMenu)
                    .scaledToFill()
                    .ignoresSafeArea()
            }

            VStack {
                MenuButton(image: images.startBtn, viewState: $viewState, destination: .game)
                MenuButton(image: images.levelBtn, viewState: $viewState, destination: .level)
                MenuButton(image: images.timeBtn, viewState: $viewState, destination: .time)
                MenuButton(image: images.volumeBtn, viewState: $viewState, destination: .volume)
                MenuButton(image: images.infoBtn, viewState: $viewState, destination: .info)
            }
        }
    }
}

struct MenuButton: View {
    let image: String
    @Binding var viewState: ViewState
    let destination: ViewState

    var body: some View {
        RemoteImage(url: image)
            .scaledToFit()
            .frame(width: OrientationManager().isLandscape ? UIScreen.main.bounds.height * 0.6 : UIScreen.main.bounds.width * 0.6)
            .onTapGesture {
                withAnimation {
                    viewState = destination
                }
            }
    }
}
