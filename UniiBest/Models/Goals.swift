import Foundation

struct Goals : Codable {
	let goalID : Int?
	let scoreTeam1 : Int?
	let scoreTeam2 : Int?
	let matchMinute : Int?
	let goalGetterID : Int?
	let goalGetterName : String?
	let isPenalty : Bool?
	let isOwnGoal : Bool?
	let isOvertime : Bool?
	let comment : String?

	enum CodingKeys: String, CodingKey {

		case goalID = "goalID"
		case scoreTeam1 = "scoreTeam1"
		case scoreTeam2 = "scoreTeam2"
		case matchMinute = "matchMinute"
		case goalGetterID = "goalGetterID"
		case goalGetterName = "goalGetterName"
		case isPenalty = "isPenalty"
		case isOwnGoal = "isOwnGoal"
		case isOvertime = "isOvertime"
		case comment = "comment"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		goalID = try values.decodeIfPresent(Int.self, forKey: .goalID)
		scoreTeam1 = try values.decodeIfPresent(Int.self, forKey: .scoreTeam1)
		scoreTeam2 = try values.decodeIfPresent(Int.self, forKey: .scoreTeam2)
		matchMinute = try values.decodeIfPresent(Int.self, forKey: .matchMinute)
		goalGetterID = try values.decodeIfPresent(Int.self, forKey: .goalGetterID)
		goalGetterName = try values.decodeIfPresent(String.self, forKey: .goalGetterName)
		isPenalty = try values.decodeIfPresent(Bool.self, forKey: .isPenalty)
		isOwnGoal = try values.decodeIfPresent(Bool.self, forKey: .isOwnGoal)
		isOvertime = try values.decodeIfPresent(Bool.self, forKey: .isOvertime)
		comment = try values.decodeIfPresent(String.self, forKey: .comment)
	}

}
