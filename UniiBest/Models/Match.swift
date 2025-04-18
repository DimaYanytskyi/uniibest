import Foundation

struct Match : Codable {
	let matchID : Int?
	let matchDateTime : String?
	let timeZoneID : String?
	let leagueId : Int?
	let leagueName : String?
	let leagueSeason : Int?
	let leagueShortcut : String?
	let matchDateTimeUTC : String?
	let group : Group?
	let team1 : Team1?
	let team2 : Team2?
	let lastUpdateDateTime : String?
	let matchIsFinished : Bool?
	let matchResults : [MatchResults]?
	let goals : [Goals]?
	let location : Location?
	let numberOfViewers : Int?

	enum CodingKeys: String, CodingKey {

		case matchID = "matchID"
		case matchDateTime = "matchDateTime"
		case timeZoneID = "timeZoneID"
		case leagueId = "leagueId"
		case leagueName = "leagueName"
		case leagueSeason = "leagueSeason"
		case leagueShortcut = "leagueShortcut"
		case matchDateTimeUTC = "matchDateTimeUTC"
		case group = "group"
		case team1 = "team1"
		case team2 = "team2"
		case lastUpdateDateTime = "lastUpdateDateTime"
		case matchIsFinished = "matchIsFinished"
		case matchResults = "matchResults"
		case goals = "goals"
		case location = "location"
		case numberOfViewers = "numberOfViewers"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		matchID = try values.decodeIfPresent(Int.self, forKey: .matchID)
		matchDateTime = try values.decodeIfPresent(String.self, forKey: .matchDateTime)
		timeZoneID = try values.decodeIfPresent(String.self, forKey: .timeZoneID)
		leagueId = try values.decodeIfPresent(Int.self, forKey: .leagueId)
		leagueName = try values.decodeIfPresent(String.self, forKey: .leagueName)
		leagueSeason = try values.decodeIfPresent(Int.self, forKey: .leagueSeason)
		leagueShortcut = try values.decodeIfPresent(String.self, forKey: .leagueShortcut)
		matchDateTimeUTC = try values.decodeIfPresent(String.self, forKey: .matchDateTimeUTC)
		group = try values.decodeIfPresent(Group.self, forKey: .group)
		team1 = try values.decodeIfPresent(Team1.self, forKey: .team1)
		team2 = try values.decodeIfPresent(Team2.self, forKey: .team2)
		lastUpdateDateTime = try values.decodeIfPresent(String.self, forKey: .lastUpdateDateTime)
		matchIsFinished = try values.decodeIfPresent(Bool.self, forKey: .matchIsFinished)
		matchResults = try values.decodeIfPresent([MatchResults].self, forKey: .matchResults)
		goals = try values.decodeIfPresent([Goals].self, forKey: .goals)
		location = try values.decodeIfPresent(Location.self, forKey: .location)
		numberOfViewers = try values.decodeIfPresent(Int.self, forKey: .numberOfViewers)
	}

    init() {
        self.matchID = nil
        self.matchDateTime = nil
        self.timeZoneID = nil
        self.leagueId = nil
        self.leagueName = nil
        self.leagueSeason = nil
        self.leagueShortcut = nil
        self.matchDateTimeUTC = nil
        self.group = nil
        self.team1 = nil
        self.team2 = nil
        self.lastUpdateDateTime = nil
        self.matchIsFinished = nil
        self.matchResults = nil
        self.goals = nil
        self.location = nil
        self.numberOfViewers = nil
    }
}
