import SwiftUI

struct OnboardingView : View {
    @ObservedObject var navigation = Navigation.shared
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("onboarding_image")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 250)
            
            Spacer()
            
            VStack(spacing: 21) {
                Text("UniiBest - Explore the World of Football")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 24, weight: .black))
                    .foregroundStyle(.white)
                
                Text("Stay connected with everything football — from your favorite leagues to match highlights, all in one place.")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 20))
                    .foregroundStyle(.white)
                
                Button(action: {
                    navigation.navigate(to: .home)
                }) {
                    Text("START")
                        .foregroundStyle(Color("111111"))
                        .font(.system(size: 24, weight: .heavy))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color("FFE71D"))
                        )
                }
            }
            .padding(32)
            .background(Color("147B45"))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    OnboardingView()
}

