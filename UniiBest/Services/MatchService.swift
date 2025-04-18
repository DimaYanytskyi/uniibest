import Foundation
import Combine

class MatchService: ObservableObject {
    @Published var matches: [Match] = []
    private var cancellables = Set<AnyCancellable>()
    
    func fetchMatches(leagueShortcut: String, leagueSeason: String) {
        guard let url = URL(string: "https://api.openligadb.de/getmatchdata/\(leagueShortcut)/\(leagueSeason)/") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Match].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error fetching matches: \(error)")
                }
            }, receiveValue: { [weak self] matches in
                self?.matches = matches
            })
            .store(in: &cancellables)
    }
}
