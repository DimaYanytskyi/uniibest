import Foundation

struct Location : Codable {
	let locationID : Int?
	let locationCity : String?
	let locationStadium : String?

	enum CodingKeys: String, CodingKey {

		case locationID = "locationID"
		case locationCity = "locationCity"
		case locationStadium = "locationStadium"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		locationID = try values.decodeIfPresent(Int.self, forKey: .locationID)
		locationCity = try values.decodeIfPresent(String.self, forKey: .locationCity)
		locationStadium = try values.decodeIfPresent(String.self, forKey: .locationStadium)
	}

}
