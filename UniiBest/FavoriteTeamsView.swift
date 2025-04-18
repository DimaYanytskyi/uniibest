import SwiftUI

struct FavoriteTeamsView: View {
    @ObservedObject var navigation = Navigation.shared
    @ObservedObject var favoriteManager = FavoriteManager.shared
    
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
                
                Text("Favorite Teams")
                    .foregroundStyle(.white)
                    .font(.system(size: 24, weight: .heavy))
                
                Spacer()
                
                Image(systemName: "gearshape")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(RoundedRectangle(cornerRadius: 28)
                        .fill(.white.opacity(0.45)))
                    .onTapGesture {
                        navigation.navigate(to: .settings)
                    }
                
            }
            .padding()
            .background(Color("147B45"))
            
            ScrollView {
                if favoriteManager.favoriteTeams.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "star.slash.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.white.opacity(0.6))
                        
                        Text("No favorite teams yet.")
                            .font(.headline)
                            .foregroundStyle(.white.opacity(0.7))
                        
                        Text("Tap the heart icon on a team to add it to your favorites.")
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.5))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 24)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.top, 60)
                } else {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 18) {
                        ForEach(favoriteManager.favoriteTeams, id: \.teamId) { team in
                            TeamItemView(team: team)
                        }
                    }
                    .padding(16)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
