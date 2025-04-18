import SwiftUI

struct UpcomingMatchesDetailsView: View {
    @ObservedObject var navigation = Navigation.shared
    @StateObject var upcomingMatchesService = UpcomingMatchesService()
    
    let league: League
    let team: Team
    
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
                
                Text("Upcoming Matches")
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
            
            VStack(alignment: .leading, spacing: 7) {
                Text(league.leagueName ?? "-")
                    .foregroundStyle(.white)
                    .font(.system(size: 20, weight: .heavy))
                    .frame(maxWidth: .infinity)
                
                Text(team.teamName ?? "-")
                    .foregroundStyle(.white)
                    .font(.system(size: 20, weight: .heavy))
                    .frame(maxWidth: .infinity)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.black.opacity(0.6))
            
            ScrollView {
                VStack(spacing: 18) {
                    if upcomingMatchesService.noMatchFound {
                        Text("No upcoming matches found for this team.")
                            .font(.system(size: 20, weight: .heavy))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.top, 40)
                    } else {
                        UpcomingItemView(match: upcomingMatchesService.match)
                    }
                }
                .padding(16)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            upcomingMatchesService.fetchUpcomingMatches(leagueId: league.leagueId ?? 0, teamId: team.teamId ?? 0)
        }
    }
}
