import SwiftUI

struct TeamsListView : View {
    @ObservedObject var navigation = Navigation.shared
    @StateObject var leagueService = LeagueService()
    
    @AppStorage("yearUpFilter") var yearUp = true
    @AppStorage("leagueSearchText") var searchText = ""
    
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
                
                Text("Teams")
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
                
                HStack(spacing: 14) {
                    Button(action: {
                        yearUp.toggle()
                    }) {
                        HStack(alignment: .center, spacing: 10) {
                            Text("Year")
                                .foregroundStyle(Color("111111"))
                                .font(.system(size: 20, weight: .heavy))
                            
                            Image(systemName: yearUp ? "arrowshape.up.fill" : "arrowshape.down.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(Color("111111"))
                                .frame(width: 18)
                        }
                        .padding(4)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color("FFE71D"))
                        )
                    }
                    
                    HStack {
                        Text("League: ")
                            .foregroundStyle(Color("111111"))
                            .font(.system(size: 20, weight: .heavy))
                        
                        TextField("Search...", text: $searchText)
                            .foregroundStyle(Color("111111"))
                            .font(.system(size: 20, weight: .medium))
                    }
                    .padding(4)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color("FFE71D"))
                    )
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.black.opacity(0.6))
            
            ScrollView {
                VStack(spacing: 18) {
                    ForEach(
                        leagueService.leagues
                                        .filter { league in
                                            searchText.isEmpty || (league.leagueName?.localizedCaseInsensitiveContains(searchText) ?? false)
                                        }
                                        .sorted {
                                            let year1 = Int($0.leagueSeason ?? "") ?? 0
                                            let year2 = Int($1.leagueSeason ?? "") ?? 0
                                            return yearUp ? (year1 < year2) : (year1 > year2)
                                        },
                                    id: \.leagueId
                    ) { league in
                        LeagueItemView(league: league)
                            .onTapGesture {
                                navigation.navigate(to: .teamsDetails(league))
                            }
                    }
                }
                .padding(16)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            leagueService.fetchLeagues()
        }
    }
}

#Preview {
    MatchesListView()
}

