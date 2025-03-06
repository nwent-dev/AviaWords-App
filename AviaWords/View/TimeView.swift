import SwiftUI

struct TimeView: View {
    @Binding var viewState: ViewState
    let images: Images
    @Binding var time: Int
    @State private var selectedIndex: Int = 0
    var imagesOfTime: [String] {
        return [images.min, images.min3, images.min5]
    }
    
    var body: some View {
        ZStack {
            if OrientationManager().isLandscape {
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
                .padding(.top, UIScreen.main.bounds.width*0.08)
                
                Spacer()
                
                HStack {
                    Button {
                        if selectedIndex > 0 {
                            selectedIndex -= 1
                            switch selectedIndex {
                            case 1:
                                time = 1*60
                            case 2:
                                time = 2*60
                            case 3:
                                time = 3*60
                            default:
                                print("makaka")
                            }
                        }
                    } label: {
                        Image(systemName: "arrow.left")
                            .foregroundStyle(.white)
                            .font(.title)
                    }
                    
                    RemoteImage(url: imagesOfTime[selectedIndex])
                        .scaledToFit()
                        .frame(width: OrientationManager().isLandscape ? UIScreen.main.bounds.height*0.6 : UIScreen.main.bounds.width*0.6)
                        .id(selectedIndex)
                    
                    Button {
                        if selectedIndex < imagesOfTime.count - 1 {
                            selectedIndex += 1
                            switch selectedIndex {
                            case 1:
                                time = 1*60
                            case 2:
                                time = 2*60
                            case 3:
                                time = 3*60
                            default:
                                print("makaka")
                            }
                        }
                    } label: {
                        Image(systemName: "arrow.right")
                            .foregroundStyle(.white)
                            .font(.title)
                    }
                }
                
                Spacer()
            }
        }
    }
}
