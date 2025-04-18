import SwiftUI

struct NotificationsView : View {
    @ObservedObject var navigation = Navigation.shared
    
    var body : some View {
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
                
                Text("Notifications")
                    .foregroundStyle(.white)
                    .font(.system(size: 24, weight: .heavy))
                
                Spacer()
            }
            .padding()
            .background(Color("147B45"))
            
            Spacer()
            
            Text("You don't have any notifications yet.")
                .foregroundStyle(.white)
                .font(.system(size: 16))
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
