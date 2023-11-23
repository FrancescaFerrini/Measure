import SwiftUI
import CoreMotion



struct LevelView: View {
    
    let motionManager = CMMotionManager()
    let queue = OperationQueue()
    @State private var pitch: Double = 0.0
    @State private var roll: Double = 0.0
    @State private var yaw: Double = 0.0
    @State private var orientation = UIDeviceOrientation.portrait
    
    var body: some View {
        
        VStack {
            HStack(alignment: .center) {
                VStack{
                    Spacer()
                    Rectangle()
                        .frame(width: 50, height: 5)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                }.padding(.trailing)
                VStack{
                    if orientation.isPortrait{
                        Text("\(roll, specifier: "%.f")°").font(.system(size: 70, weight: .light, design: .default))
                            
                    }
                    else if orientation.isLandscape{
                        Text("\(pitch, specifier: "%.f")°").font(.system(size: 70, weight: .light, design: .default))
                            
                    }
                    else if orientation.isFlat{
                        Text("\(roll, specifier: "%.f")°").font(.system(size: 70, weight: .light, design: .default))
                            
                        
                        
                        
                    }
                } .frame(maxWidth: .infinity)
                VStack{
                    Spacer()
                    Rectangle()
                        .frame(width: 50, height: 5)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                }.padding(.leading)
            }
            
        }
        .background(orientation.isLandscape ? updateBackgroundColorLandscape() : updateBackgroundColorPortrait())
        .rotationEffect(rotationAngle(for: orientation))
        .onRotate { newOrientation in
            
            orientation = newOrientation
            
        }
        .onAppear {
            initializeMotionManager()
            
            
            
        }
        .onDisappear {
            stopMotionUpdates()
        }
    }
    
    func initializeMotionManager() {
        if motionManager.isGyroAvailable {
            motionManager.deviceMotionUpdateInterval = 0.3
            motionManager.startDeviceMotionUpdates(using: .xMagneticNorthZVertical, to: queue) { deviceManager, error in
                if let attitude = deviceManager?.attitude {
                    let pitchValue = attitude.pitch * (180 / Double.pi)
                    let rollValue = attitude.roll * (180 / Double.pi)
                    
                    
                    DispatchQueue.main.async {
                        self.pitch = pitchValue
                        self.roll = rollValue
                        
                    }
                }
            }
        }
    }
    func updateBackgroundColorPortrait() -> Color {
        if (self.roll == 0.0 || self.roll < 0.5) && (self.roll == -0.0 || self.roll > -0.5){
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
            return Color.green
        }
        else {return Color.red}
    }
    
    func updateBackgroundColorLandscape() -> Color {
        if (self.pitch == 0.0 || self.pitch < 0.5) && (self.pitch == -0.0 || self.pitch > -0.5){
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
            return Color.green
        }
        else {return Color.red}
    }
    
    
    func stopMotionUpdates() {
        motionManager.stopDeviceMotionUpdates()
    }
    
    private func rotationAngle(for orientation: UIDeviceOrientation) -> Angle {
        switch orientation {
        case .portrait:
            return .degrees(0)
        case .landscapeLeft:
            return .degrees(0)
        case .landscapeRight:
            return .degrees(0)
        default:
            return .degrees(0)
        }
    }
}

struct LevelView_Previews: PreviewProvider {
    static var previews: some View {
        LevelView()
    }
}

struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void
    
    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}


extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}
