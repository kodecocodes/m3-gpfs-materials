import UIKit

var arrayOfNumbers = [2, 3, 4, 5, 6]
let newArrayUsingMap = arrayOfNumbers.map { $0 * 10 }
arrayOfNumbers = arrayOfNumbers.map { $0 * 10 }   // 😲

// Function Composition

func extractElements(_ content: String) -> [String] {
  return content.components(separatedBy: ",").map { String($0) }
}

func formatAsCurrency(content: [String]) -> [String] {
  return content.map {"$\($0)"}
}

let content = "10,20,40,30,80,60"
let elements = extractElements(content)
formatAsCurrency(content: elements)

formatAsCurrency(content: extractElements(content))

let formatExtractedElements = {
  data in
  formatAsCurrency(content: extractElements(data))
}
formatExtractedElements(content)

precedencegroup AssociativityLeft {
  associativity: left
}

infix operator |> : AssociativityLeft

func |> <T, V>(f: @escaping (T) -> V, g: @escaping (V) -> V ) -> (T) -> V {
  return { x in g(f(x)) }
}

let extractThenFormat = extractElements |> formatAsCurrency
extractThenFormat("10,20,40,30,80,60")
