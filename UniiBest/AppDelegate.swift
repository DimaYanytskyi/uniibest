import SwiftUI
import OneSignalFramework
import FirebaseCore

@UIApplicationMain
class AppDelegate: NSObject, UIApplicationDelegate {
    
    var window: UIWindow?
    var orientationLock: UIInterfaceOrientationMask = .all
    var ext_id: String = UUID().uuidString
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return orientationLock
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        OneSignal.initialize("fd4b5bdf-1eee-4891-b405-3f34ae955b97", withLaunchOptions: launchOptions)
        OneSignal.Notifications.requestPermission({ accepted in
          }, fallbackToSettings: false)
        if (UserDefaults.standard.string(forKey: "ext_id") ?? "").isEmpty {
            UserDefaults.standard.set(ext_id, forKey: "ext_id")
            OneSignal.login(ext_id)
        }
        
        let window = UIWindow()
        window.rootViewController = UIHostingController(rootView: ContentView())
        self.window = window
        window.makeKeyAndVisible()
        
        return true
    }
}

