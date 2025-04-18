import Foundation

struct Team2 : Codable {
	let teamId : Int?
	let teamName : String?
	let shortName : String?
	let teamIconUrl : String?
	let teamGroupName : String?

	enum CodingKeys: String, CodingKey {

		case teamId = "teamId"
		case teamName = "teamName"
		case shortName = "shortName"
		case teamIconUrl = "teamIconUrl"
		case teamGroupName = "teamGroupName"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		teamId = try values.decodeIfPresent(Int.self, forKey: .teamId)
		teamName = try values.decodeIfPresent(String.self, forKey: .teamName)
		shortName = try values.decodeIfPresent(String.self, forKey: .shortName)
		teamIconUrl = try values.decodeIfPresent(String.self, forKey: .teamIconUrl)
		teamGroupName = try values.decodeIfPresent(String.self, forKey: .teamGroupName)
	}

}
