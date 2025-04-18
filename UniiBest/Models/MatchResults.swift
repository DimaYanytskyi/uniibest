import Foundation

struct MatchResults : Codable {
	let resultID : Int?
	let resultName : String?
	let pointsTeam1 : Int?
	let pointsTeam2 : Int?
	let resultOrderID : Int?
	let resultTypeID : Int?
	let resultDescription : String?

	enum CodingKeys: String, CodingKey {

		case resultID = "resultID"
		case resultName = "resultName"
		case pointsTeam1 = "pointsTeam1"
		case pointsTeam2 = "pointsTeam2"
		case resultOrderID = "resultOrderID"
		case resultTypeID = "resultTypeID"
		case resultDescription = "resultDescription"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		resultID = try values.decodeIfPresent(Int.self, forKey: .resultID)
		resultName = try values.decodeIfPresent(String.self, forKey: .resultName)
		pointsTeam1 = try values.decodeIfPresent(Int.self, forKey: .pointsTeam1)
		pointsTeam2 = try values.decodeIfPresent(Int.self, forKey: .pointsTeam2)
		resultOrderID = try values.decodeIfPresent(Int.self, forKey: .resultOrderID)
		resultTypeID = try values.decodeIfPresent(Int.self, forKey: .resultTypeID)
		resultDescription = try values.decodeIfPresent(String.self, forKey: .resultDescription)
	}

}
