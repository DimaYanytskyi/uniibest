import Foundation
import Combine

class LeagueService: ObservableObject {
    @Published var leagues: [League] = []
    private var cancellables = Set<AnyCancellable>()
    
    func fetchLeagues() {
        guard let url = URL(string: "https://api.openligadb.de/getavailableleagues") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [League].self, decoder: JSONDecoder())
            .map { leagues in
                leagues
                    .filter { league in
                        guard let name = league.leagueName?.lowercased() else { return false }
                        let isTestLeague = name.contains("test")
                        let containsLiga = name.contains("liga")
                        let containsLeague = name.contains("league")

                        return !isTestLeague || containsLiga || containsLeague
                    }
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error fetching leagues: \(error)")
                }
            }, receiveValue: { [weak self] cleanedLeagues in
                self?.leagues = cleanedLeagues
            })
            .store(in: &cancellables)
    }
}
