import Foundation
import Combine

class TeamService: ObservableObject {
    @Published var teams: [Team] = []
    private var cancellables = Set<AnyCancellable>()
    
    func fetchTeams(leagueShortcut: String, leagueSeason: String) {
        guard let url = URL(string: "https://api.openligadb.de/getavailableteams/\(leagueShortcut)/\(leagueSeason)/") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Team].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error fetching matches: \(error)")
                }
            }, receiveValue: { [weak self] teams in
                self?.teams = teams
            })
            .store(in: &cancellables)
    }
}
