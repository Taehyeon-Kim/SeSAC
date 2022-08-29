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
 디코딩 전략
 - 디코딩 전략을 설정해줄 수 있는 방법이 있다. -> keyDecodingStrategy -> 이 또한 한계가 존재한다.
 - SnakeCase
 */
struct Quote: Decodable {
    let quoteContent: String
    let authorName: String
    
    
}

// String -> Data -> Struct


guard let result = json.data(using: .utf8) else { fatalError("Data Error") }
print(result)

let decoder = JSONDecoder()
decoder.keyDecodingStrategy = .convertFromSnakeCase

do {
    let value = try decoder.decode(Quote.self, from: result)
    print(value)
    print(value.quoteContent)
    print(value.authorName)
    
} catch {
    print(error)
}
