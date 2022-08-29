import UIKit

/*
 https://api.goprogram.ai/inspiration/
 */

let json = """
{
    "quote": "Count your age by friends, not years. Count your life by smiles, not tears.",
    "author": "John Lennon"
}
"""

/*
 쉬운 전략 : 옵셔널 형태로 만들어주기
 - 이렇게 되면 Key값이 맞지 않을 때 항상 nil값만 들어오기 때문에 적절한 대응은 아닐 수 있음
 */
struct Quote: Decodable {
    let quoteContent: String?
    let authorName: String?
}

// String -> Data -> Struct


guard let result = json.data(using: .utf8) else { fatalError("Data Error") }
print(result)


do {
    let value = try JSONDecoder().decode(Quote.self, from: result)
    print(value)
    print(value.quoteContent)
    print(value.authorName)
    
} catch {
    print(error)
}
