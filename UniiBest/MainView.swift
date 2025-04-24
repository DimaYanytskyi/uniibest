import SwiftUI
@preconcurrency import WebKit

struct MainView: UIViewRepresentable {
    @ObservedObject var navigation = Navigation.shared
    @State var visible: Bool = false
    @State var item: String
    @State var second: String?
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: MainView
        var second: String
        
        init(parent: MainView) {
            self.parent = parent
            self.second = parent.item
        }
        
        @available(iOS 15, *)
        func webView(
            _ webView: WKWebView,
            requestMediaCapturePermissionFor origin: WKSecurityOrigin,
            initiatedByFrame frame: WKFrameInfo,
            type: WKMediaCaptureType,
            decisionHandler: @escaping (WKPermissionDecision) -> Void
        ) {
            decisionHandler(.grant)
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
            if let httpResponse = navigationResponse.response as? HTTPURLResponse{
                if httpResponse.statusCode == 404 && !UserDefaults.standard.bool(forKey: "dfyt") {
                    DispatchQueue.main.async {
                        self.parent.visible = false
                        UserDefaults.standard.set(true, forKey: "dfyt")
                        UserDefaults.standard.set("", forKey: "iock")
                        self.parent.navigation.navigate(to: .onboarding)
                    }
                    decisionHandler(.cancel)
                    return
                } else if httpResponse.statusCode == 200 && !UserDefaults.standard.bool(forKey: "some") {
                    if let finalUrl = webView.url {
                        self.parent.visible = true
                        UserDefaults.standard.set(finalUrl.absoluteString, forKey: "iock")
                        UserDefaults.standard.set(true, forKey: "some")
                        UserDefaults.standard.set(true, forKey: "dfyt")
                    }
                } else {
                    if UserDefaults.standard.bool(forKey: "some") {
                        self.parent.visible = true
                    }
                }
            }
            decisionHandler(.allow)
        }
        
        func webView(
            _ webView: WKWebView,
            decidePolicyFor navigationAction: WKNavigationAction,
            decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
        ) {
            if let url = navigationAction.request.url {
                self.parent.second = url.absoluteString
            }
            decisionHandler(.allow)
        }

    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = false
        let swipeLeft = UISwipeGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleSwipe(_:)))
        swipeLeft.direction = .left
        webView.addGestureRecognizer(swipeLeft)
           
        let swipeRight = UISwipeGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleSwipe(_:)))
        swipeRight.direction = .right
        webView.addGestureRecognizer(swipeRight)
        webView.isHidden = true
        if let url = URL(string: item) {
            webView.load(URLRequest(url: url))
        } else {
            navigation.navigate(to: .onboarding)
        }
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.isHidden = !visible
    }
    
    func loadURL(_ urlString: String) {
        self.second = urlString
    }
}

extension MainView.Coordinator {
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        guard let webView = gesture.view as? WKWebView else { return }
        switch gesture.direction {
        case .left:
            if webView.canGoForward {
                webView.goForward()
            }
        case .right: 
            if webView.canGoBack {
                webView.goBack()
            }
        default:
            break
        }
    }
}
