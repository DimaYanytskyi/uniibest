import SwiftUI

struct MatchItemView: View {
    @ObservedObject var navigation = Navigation.shared
    let match: Match
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Group: \(match.group?.groupName ?? "-")")
                .foregroundStyle(.white)
                .font(.system(size: 20, weight: .heavy))
            
            HStack(alignment: .center, spacing: 40) {
                VStack(alignment: .center, spacing: 10) {
                    AsyncImage(url: URL(string: match.team1?.teamIconUrl ?? "")) { phase in
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
                    .frame(width: 80, height: 80)
                    
                    Text(match.team1?.shortName ?? "-")
                        .foregroundStyle(.white)
                        .font(.system(size: 20, weight: .heavy))
                        .lineLimit(1)
                    
                    Text(String(match.matchResults?.first?.pointsTeam1 ?? 0))
                        .foregroundStyle(Color("FFE71D"))
                        .font(.system(size: 20, weight: .heavy))
                }
                
                VStack {
                    Spacer()
                    
                    Text("-")
                        .foregroundStyle(Color("FFE71D"))
                        .font(.system(size: 20, weight: .heavy))
                }
                
                VStack(alignment: .center, spacing: 10) {
                    AsyncImage(url: URL(string: match.team2?.teamIconUrl ?? "")) { phase in
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
                    .frame(width: 80, height: 80)
                    
                    Text(match.team2?.shortName ?? "-")
                        .foregroundStyle(.white)
                        .font(.system(size: 20, weight: .heavy))
                        .lineLimit(1)
                    
                    Text(String(match.matchResults?.first?.pointsTeam2 ?? 0))
                        .foregroundStyle(Color("FFE71D"))
                        .font(.system(size: 20, weight: .heavy))
                }
            }
            
            Text(match.matchResults?.first?.resultDescription ?? "-")
                .foregroundStyle(.white)
                .font(.system(size: 20, weight: .heavy))
                .multilineTextAlignment(.center)
        }
        .padding(13)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 4)
                .fill(Color("147B45"))
        )
    }
}
