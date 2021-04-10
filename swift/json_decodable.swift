import Foundation

struct FoobarSummary {
    let fooRating: String
    let fooScore: Float
}

enum CodingKeys: String, CodingKey {
    case fooRating = "bb_foo_rating"
    case fooScore = "bb_foo_score"
}

extension FoobarSummary: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        fooScore = Float(try values.decode(String.self, forKey: .fooScore)) ?? 0.00
        fooRating = try values.decode(String.self, forKey: .fooRating)
    }
}

if let a =
    """
{
  "bb_foo_rating": "low",
  "bb_foo_score": "500.00",
  "blah_blah": "yes"
}
""".data(using: .utf8) {
    let foobar = try JSONDecoder().decode(FoobarSummary.self, from: a)
    print(foobar.fooScore)
    print(foobar.fooRating)
}

