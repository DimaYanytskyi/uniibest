import SwiftUI

struct LoadingView : View {
    @ObservedObject var navigation = Navigation.shared
    @State private var animate = false
    
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
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                navigation.navigate(to: .onboarding)
            }
        }
    }
}

#Preview {
    LoadingView()
}
