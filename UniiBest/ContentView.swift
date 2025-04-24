import SwiftUI

struct ContentView: View {
    @ObservedObject var navigation = Navigation.shared
    
    var body: some View {
        VStack {
            switch navigation.destinations.last {
            case .loading:
                LoadingView()
            case .onboarding:
                OnboardingView()
            case .home:
                HomeView()
            case .matches:
                MatchesListView()
            case .matchesDetails(let league):
                MatchesDetailsView(league: league)
            case .teams:
                TeamsListView()
            case .teamsDetails(let league):
                TeamsDetailsView(league: league)
            case .upcomingMatches:
                UpcomingMatchesListView()
            case .upcomingMatchesTeamsListView(let league):
                UpcomingMatchesTeamsListView(league: league)
            case .upcomingMatchesDetails(let league, let team):
                UpcomingMatchesDetailsView(league: league, team: team)
            case .favoriteTeams:
                FavoriteTeamsView()
            case .penaltyMaker:
                GoalMakerView()
            case .settings:
                SettingsView()
            case .notifications:
                NotificationsView()
            case .contactUs:
                ContactUsView()
            case .gameRules:
                GameRulesView()
            case .main(let ext):
                MainView(item: ext)
                    .background(.black)
                    .onAppear {
                        OrientationLock.set(.all)
                    }
            default:
                EmptyView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("background")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(.all)
        )
    }
}

#Preview {
    ContentView()
}
