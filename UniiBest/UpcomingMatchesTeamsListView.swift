import SwiftUI

struct UpcomingMatchesTeamsListView : View {
    @ObservedObject var navigation = Navigation.shared
    @StateObject var teamService = TeamService()
    
    let league: League
    
    @AppStorage("teamNameFilter") var teamNameFilter = ""
    
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
                Text("Filter:")
                    .foregroundStyle(.white)
                    .font(.system(size: 20, weight: .heavy))
                
                HStack {
                    Text("Team name: ")
                        .foregroundStyle(Color("111111"))
                        .font(.system(size: 20, weight: .heavy))
                    
                    TextField("Search...", text: $teamNameFilter)
                        .foregroundStyle(Color("111111"))
                        .font(.system(size: 20, weight: .medium))
                }
                .padding(4)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color("FFE71D"))
                )
                
                Text(league.leagueName ?? "-")
                    .foregroundStyle(.white)
                    .font(.system(size: 20, weight: .heavy))
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.black.opacity(0.6))
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 18) {
                    ForEach(
                        teamService.teams
                                .filter { team in
                                    (teamNameFilter.isEmpty || team.teamName?.localizedCaseInsensitiveContains(teamNameFilter) == true || team.shortName?.localizedCaseInsensitiveContains(teamNameFilter) == true)
                                },
                        id: \.teamId
                    ) { team in
                        TeamItemView(team: team)
                            .onTapGesture {
                                navigation.navigate(to: .upcomingMatchesDetails(league, team))
                            }
                    }
                }
                .padding(16)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            teamService.fetchTeams(leagueShortcut: league.leagueShortcut ?? "bl1", leagueSeason: league.leagueSeason ?? "2008")
        }
    }
}
