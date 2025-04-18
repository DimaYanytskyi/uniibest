import Foundation

struct Group : Codable {
	let groupName : String?
	let groupOrderID : Int?
	let groupID : Int?

	enum CodingKeys: String, CodingKey {

		case groupName = "groupName"
		case groupOrderID = "groupOrderID"
		case groupID = "groupID"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		groupName = try values.decodeIfPresent(String.self, forKey: .groupName)
		groupOrderID = try values.decodeIfPresent(Int.self, forKey: .groupOrderID)
		groupID = try values.decodeIfPresent(Int.self, forKey: .groupID)
	}

}
