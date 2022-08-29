import UIKit

/*
 https://api.goprogram.ai/inspiration/
 */

let json = """
{
    "quote_content": "Count your age by friends, not years. Count your life by smiles, not tears.",
    "author_name": "John Lennon"
}
"""

/*
 디코딩 전략도 통하지 않는다.
 */
struct Quote: Decodable {
    let word: String
    let author: String
    
    // (받아오는 데이터와 사용하려는 구조체 형태가 다를 때 맞춰주고 싶다면)
    enum CodingKeys: String, CodingKey { // 내부적으로 선언되어 있는 열거형
        case word = "quote_content"
        case author = "author_name"
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
