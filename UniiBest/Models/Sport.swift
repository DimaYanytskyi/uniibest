import Foundation

struct Sport : Codable {
	let sportId : Int?
	let sportName : String?

	enum CodingKeys: String, CodingKey {

		case sportId = "sportId"
		case sportName = "sportName"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		sportId = try values.decodeIfPresent(Int.self, forKey: .sportId)
		sportName = try values.decodeIfPresent(String.self, forKey: .sportName)
	}

    init(sportId: Int?, sportName: String?) {
        self.sportId = sportId
        self.sportName = sportName
    }
}
