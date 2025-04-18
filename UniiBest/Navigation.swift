import Foundation

enum NavigationDestinations {
    case loading
    case onboarding
    case home
    case matches
    case matchesDetails(League)
    case teams
    case teamsDetails(League)
    case upcomingMatches
    case upcomingMatchesTeamsListView(League)
    case upcomingMatchesDetails(League, Team)
    case favoriteTeams
    case penaltyMaker
    case settings
    case gameRules
    case contactUs
    case notifications
}

class Navigation : ObservableObject {
    static let shared = Navigation()
    
    @Published var destinations: [NavigationDestinations] = []
    
    init() {
        destinations.append(.loading)
    }
    
    func navigate(to destination: NavigationDestinations) {
        destinations.append(destination)
    }
    
    func navigateBack() {
        destinations.removeLast()
    }
}

