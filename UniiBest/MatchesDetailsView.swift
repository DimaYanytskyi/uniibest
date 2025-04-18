import SwiftUI

struct MatchesDetailsView: View {
    @ObservedObject var navigation = Navigation.shared
    @StateObject var matchService = MatchService()
    
    let league: League
    
    @AppStorage("team1Filter") var team1Filter = ""
    @AppStorage("team2Filter") var team2Filter = ""
    
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
                
                Text("Matches")
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
                    Text("Team1: ")
                        .foregroundStyle(Color("111111"))
                        .font(.system(size: 20, weight: .heavy))
                    
                    TextField("Search...", text: $team1Filter)
                        .foregroundStyle(Color("111111"))
                        .font(.system(size: 20, weight: .medium))
                }
                .padding(4)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color("FFE71D"))
                )
                
                HStack {
                    Text("Team2: ")
                        .foregroundStyle(Color("111111"))
                        .font(.system(size: 20, weight: .heavy))
                    
                    TextField("Search...", text: $team2Filter)
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
                VStack(spacing: 18) {
                    ForEach(
                        matchService.matches
                                .filter { match in
                                    (team1Filter.isEmpty || match.team1?.shortName?.localizedCaseInsensitiveContains(team1Filter) == true) &&
                                    (team2Filter.isEmpty || match.team2?.shortName?.localizedCaseInsensitiveContains(team2Filter) == true)
                                },
                            id: \.matchID
                    ) { match in
                        MatchItemView(match: match)
                    }
                }
                .padding(16)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            matchService.fetchMatches(leagueShortcut: league.leagueShortcut ?? "bl1", leagueSeason: league.leagueSeason ?? "2008")
        }
    }
}



#Preview {
    let league = League(leagueId: 5, leagueName: "Uefa EM 2008 ", leagueShortcut: "fem08", leagueSeason: "2008", sport: Sport(sportId: 1, sportName: "Fußball"))
    
    MatchesDetailsView(
        league: league
    )
}

