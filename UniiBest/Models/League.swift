import Foundation

struct League : Codable {
	let leagueId : Int?
	let leagueName : String?
	let leagueShortcut : String?
	let leagueSeason : String?
	let sport : Sport?

	enum CodingKeys: String, CodingKey {

		case leagueId = "leagueId"
		case leagueName = "leagueName"
		case leagueShortcut = "leagueShortcut"
		case leagueSeason = "leagueSeason"
		case sport = "sport"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		leagueId = try values.decodeIfPresent(Int.self, forKey: .leagueId)
		leagueName = try values.decodeIfPresent(String.self, forKey: .leagueName)
		leagueShortcut = try values.decodeIfPresent(String.self, forKey: .leagueShortcut)
		leagueSeason = try values.decodeIfPresent(String.self, forKey: .leagueSeason)
		sport = try values.decodeIfPresent(Sport.self, forKey: .sport)
	}

    init(leagueId: Int?, leagueName: String?, leagueShortcut: String?, leagueSeason: String?, sport: Sport?) {
        self.leagueId = leagueId
        self.leagueName = leagueName
        self.leagueShortcut = leagueShortcut
        self.leagueSeason = leagueSeason
        self.sport = sport
    }
}
