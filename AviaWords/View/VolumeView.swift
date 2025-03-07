import AVFAudio
import SwiftUI

struct VolumeView: View {
    @Binding var viewState: ViewState
    let images: Images
    @Binding var isSoundOff: Bool
    
    @State private var audioPlayer: AVAudioPlayer?
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
                    Image(systemName: "xmark")
                        .foregroundStyle(.white)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.trailing)
                        .onTapGesture {
                            viewState = .menu
                        }
                }
                .padding(
                    .top,
                    orientationManager.isLandscape ? UIScreen.main.bounds.height * 0.08 : UIScreen.main.bounds.width * 0.08
                )
                
                Spacer()
                
                Button {
                    toggleSound()
                } label: {
                    if isSoundOff {
                        RemoteImage(url: images.soundOffBtn)
                            .scaledToFit()
                            .frame(
                                width: orientationManager.isLandscape ? UIScreen.main.bounds.height * 0.75 : UIScreen.main.bounds.width * 0.75
                            )
                    } else {
                        RemoteImage(url: images.soundOnBtn)
                            .scaledToFit()
                            .frame(
                                width: orientationManager.isLandscape ? UIScreen.main.bounds.height * 0.75 : UIScreen.main.bounds.width * 0.75
                            )
                    }
                }
                
                Spacer()
            }
        }
        .onAppear {
            setupAudio()
        }
    }
    
    // init player
    private func setupAudio() {
        guard let url = Bundle.main.url(forResource: "background_music", withExtension: "mp3") else {
            print("Music file not found")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1 // loop
            audioPlayer?.prepareToPlay()
        } catch {
            print("Error initializing audio player: \(error.localizedDescription)")
        }
    }
    
    // turn on/off volume
    private func toggleSound() {
        guard let audioPlayer = audioPlayer else { return }
        
        if isSoundOff {
            audioPlayer.play()
        } else {
            audioPlayer.pause()
        }
        isSoundOff.toggle()
    }
}
