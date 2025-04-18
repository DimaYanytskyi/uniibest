import SwiftUI

struct TeamItemView : View {
    @ObservedObject var favoriteManager = FavoriteManager.shared
    
    let team: Team
    
    var body: some View {
        VStack(spacing: 22) {
            AsyncImage(url: URL(string: team.teamIconUrl ?? "")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                    
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                    
                case .failure(_):
                    Image("default_club")
                        .resizable()
                        .scaledToFit()
                    
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 115, height: 115)
            
            HStack {
                Text(team.shortName ?? "-")
                    .foregroundStyle(.white)
                    .font(.system(size: 20, weight: .heavy))
                    .lineLimit(1)
                
                Spacer()
                
                Image(systemName: favoriteManager.isFavorite(teamId: team.teamId ?? -1) ? "heart.fill" : "heart")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(RoundedRectangle(cornerRadius: 28)
                        .fill(.white.opacity(0.45)))
                    .onTapGesture {
                        favoriteManager.toggleFavorite(team: team)
                    }
            }
        }
        .padding(18)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 4)
                .fill(Color("147B45"))
        )
    }
}
