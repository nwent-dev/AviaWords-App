import SwiftUI

struct LevelView: View {
    @Binding var viewState: ViewState
    let images: Images
    @Binding var selectedLevel: Int

    var body: some View {
        ZStack {
            if OrientationManager().isLandscape {
                RemoteImage(url: images.bgAnything)
                    .scaledToFill()
                    .ignoresSafeArea()
            } else {
                RemoteImage(url: images.bgAnything)
                    .scaledToFill()
                    .ignoresSafeArea()
            }
        }
    }
}
