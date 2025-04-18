import Foundation

class FavoriteManager: ObservableObject {
    static let shared = FavoriteManager()
    
    @Published private(set) var favoriteTeams: [Team] = [] {
        didSet {
            saveFavorites()
        }
    }

    private let key = "favorite_teams_full"

    private init() {
        loadFavorites()
    }

    private func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: key),
           let teams = try? JSONDecoder().decode([Team].self, from: data) {
            self.favoriteTeams = teams
        }
    }

    private func saveFavorites() {
        if let data = try? JSONEncoder().encode(favoriteTeams) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    func isFavorite(teamId: Int) -> Bool {
        favoriteTeams.contains(where: { $0.teamId == teamId })
    }

    func toggleFavorite(team: Team) {
        if let id = team.teamId, let index = favoriteTeams.firstIndex(where: { $0.teamId == id }) {
            favoriteTeams.remove(at: index)
        } else {
            favoriteTeams.append(team)
        }
    }
}

