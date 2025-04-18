import Foundation
import Combine

class UpcomingMatchesService: ObservableObject {
    @Published var match: Match = Match()
    @Published var noMatchFound: Bool = false

    private var cancellables = Set<AnyCancellable>()

    func fetchUpcomingMatches(leagueId: Int, teamId: Int) {
        guard let url = URL(string: "https://api.openligadb.de/getnextmatchbyleagueteam/\(leagueId)/\(teamId)/") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response -> Data in
                if let string = String(data: data, encoding: .utf8),
                   string.starts(with: "No next match") {
                    DispatchQueue.main.async {
                        self.noMatchFound = true
                    }
                    throw URLError(.badServerResponse)
                } else {
                    DispatchQueue.main.async {
                        self.noMatchFound = false
                    }
                }
                return data
            }
            .decode(type: Match.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error fetching matches: \(error)")
                }
            }, receiveValue: { [weak self] match in
                DispatchQueue.main.async {
                    self?.noMatchFound = false
                }
                self?.match = match
            })
            .store(in: &cancellables)
    }
}

