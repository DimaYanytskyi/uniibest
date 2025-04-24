import SwiftUI
import FirebaseRemoteConfig

struct LoadingView : View {
    @ObservedObject var navigation = Navigation.shared
    
    @State private var animate = false
    @State private var strt: String? = nil
    @State private var pon: String? = nil
    @State private var hill: Bool? = nil
    @State private var some2 = false
    
    var body: some View {
        ZStack {
            ZStack {
                ForEach(0..<3) { index in
                    Circle()
                        .stroke(lineWidth: 4)
                        .foregroundColor(Color.green.opacity(Double(3 - index) / 3))
                        .frame(width: CGFloat(180 + index * 30), height: CGFloat(180 + index * 30))
                        .rotationEffect(.degrees(animate ? 360 : 0))
                        .animation(.easeInOut(duration: 2).repeatForever(autoreverses: false), value: animate)
                }
            }
            
            Image("ball")
                .resizable()
                .scaledToFit()
                .frame(width: 135, height: 135)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            OrientationLock.set(.portrait)
            animate = true
            
            strt = UserDefaults.standard.string(forKey: "iock") ?? ""
            some2 = !UserDefaults.standard.bool(forKey: "dfyt")
            
            if some2 {
                DispatchQueue.main.async {
                    let remoteConfig = RemoteConfig.remoteConfig()
                    let settings = RemoteConfigSettings()
                    settings.minimumFetchInterval = 3600
                    remoteConfig.configSettings = settings
                    
                    remoteConfig.fetchAndActivate { status, error in
                        if let error = error {
                            pon = ""
                            hill = false
                            print(error)
                        } else {
                            pon = remoteConfig["footballFeature"].stringValue
                            hill = remoteConfig["footballFlagFeature"].boolValue
                            
                            if hill! {
                                let uuid = UserDefaults.standard.string(forKey: "ext_id") ?? ""
                                let uuid_str = "?ext_id=" + uuid
                                let lksj = pon! + uuid_str
                                
                                UserDefaults.standard.set(lksj, forKey: "iock")
                                navigation.navigate(to: .main(lksj))
                            } else {
                                navigation.navigate(to: .onboarding)
                            }
                        }
                    }
                }
            } else {
                if strt!.isEmpty {
                    navigation.navigate(to: .onboarding)
                } else {
                    navigation.navigate(to: .main(strt!))
                }
            }
        }
    }
}

#Preview {
    LoadingView()
}
