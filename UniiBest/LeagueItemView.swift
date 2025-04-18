import SwiftUI

struct LeagueItemView: View {
    @ObservedObject var navigation = Navigation.shared
    
    let league: League
    
    var body: some View {
        HStack {
            Text(league.leagueName ?? "-")
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
    }
}
