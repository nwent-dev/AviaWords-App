import AVFAudio
import SwiftUI

struct VolumeView: View {
    @Binding var viewState: ViewState
    let images: Images
    @Binding var isSoundOff: Bool
    
    @State private var audioPlayer: AVAudioPlayer?
    
    var body: some View {
        ZStack {
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
                            viewState = .menu
                        }
                }
                .padding(.top, UIScreen.main.bounds.width * 0.08)
                
                Spacer()
                
                Button {
                    toggleSound()
                } label: {
                    RemoteImage(url: isSoundOff ? images.soundOffBtn : images.soundOnBtn)
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width * 0.75)
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
