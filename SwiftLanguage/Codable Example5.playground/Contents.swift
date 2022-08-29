import UIKit

/*
 https://api.goprogram.ai/inspiration/
 */

let json = """
{
    "quote_content": "Count your age by friends, not years. Count your life by smiles, not tears.",
    "author_name": null,
    "likeCount": 12345
}
"""

/*
 디코딩 전략도 통하지 않는다.
 */
struct Quote: Decodable {
    let word: String
    let author: String
    let like: Int
    let isInfluencer: Bool /// 10000개 이상 좋아요 받은 경우
    
    // (받아오는 데이터와 사용하려는 구조체 형태가 다를 때 맞춰주고 싶다면)
    enum CodingKeys: String, CodingKey { // 내부적으로 선언되어 있는 열거형
        case word = "quote_content"
        case author = "author_name"
        case like = "likeCount"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        word = try container.decode(String.self, forKey: .word)
        author = try container.decodeIfPresent(String.self, forKey: .author) ?? "unknown"
        like = try container.decode(Int.self, forKey: .like)
        isInfluencer = (10000...).contains(like) ? true : false
    }
}

// String -> Data
guard let result = json.data(using: .utf8) else { fatalError("Data Error") }
print(result)

// Data -> Struct
do {
    let value = try JSONDecoder().decode(Quote.self, from: result)
    print(value)
    print(value.word)
    print(value.author)
    
} catch {
    print(error)
}
