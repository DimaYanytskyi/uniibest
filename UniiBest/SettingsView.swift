import SwiftUI
import StoreKit
import WebKit

struct SettingsView : View {
    @ObservedObject var navigation = Navigation.shared
    
    @State private var openPolicy: Bool = false
    private var webViewURL: URL? = URL(string: "https://sites.google.com/view/uniibest-yourfootballhelper/privacy-policy")
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 16) {
                Image(systemName: "chevron.left")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(RoundedRectangle(cornerRadius: 28)
                        .fill(.white.opacity(0.45)))
                    .onTapGesture {
                        navigation.navigateBack()
                    }
                
                Text("Settings")
                    .foregroundStyle(.white)
                    .font(.system(size: 24, weight: .heavy))
                
                Spacer()
            }
            .padding()
            .background(Color("147B45"))
            
            ScrollView {
                VStack(spacing: 16) {
                    HStack {
                        Text("Notifications")
                            .foregroundStyle(.white)
                            .font(.system(size: 16, weight: .heavy))
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.white)
                            .frame(width: 14, height: 14)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color("147B45"))
                    )
                    .onTapGesture {
                        navigation.navigate(to: .notifications)
                    }
                    
                    HStack {
                        Text("Rate App")
                            .foregroundStyle(.white)
                            .font(.system(size: 16, weight: .heavy))
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.white)
                            .frame(width: 14, height: 14)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color("147B45"))
                    )
                    .onTapGesture {
                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                            SKStoreReviewController.requestReview(in: windowScene)
                        }
                    }
                    
                    HStack {
                        Text("Privacy Policy")
                            .foregroundStyle(.white)
                            .font(.system(size: 16, weight: .heavy))
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.white)
                            .frame(width: 14, height: 14)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color("147B45"))
                    )
                    .onTapGesture {
                        openPolicy = true
                    }
                    
                    HStack {
                        Text("Support")
                            .foregroundStyle(.white)
                            .font(.system(size: 16, weight: .heavy))
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.white)
                            .frame(width: 14, height: 14)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color("147B45"))
                    )
                    .onTapGesture {
                        navigation.navigate(to: .contactUs)
                    }
                }
                .padding()
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .sheet(isPresented: $openPolicy) {
            if let url = webViewURL {
                PolicyWebView(url: url)
            }
        }
    }
}

struct PolicyWebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if uiView.url != url {
            uiView.load(URLRequest(url: url))
        }
    }
}

#Preview {
    SettingsView()
}

