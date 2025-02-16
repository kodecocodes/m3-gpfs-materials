import UIKit

// Pure Functions
enum RideCategory: String {
  case family
  case kids
  case thrill
  case scary
  case relaxing
  case water
}

typealias Minutes = Double
struct Ride {
  let name: String
  let categories: Set<RideCategory>
  let waitTime: Minutes
}

let parkRides = [
  Ride(name: "Raging Rapids",
       categories: [.family, .thrill, .water],
       waitTime: 45.0),
  Ride(name: "Crazy Funhouse", categories: [.family], waitTime: 10.0),
  Ride(name: "Spinning Tea Cups", categories: [.kids], waitTime: 15.0),
  Ride(name: "Spooky Hollow", categories: [.scary], waitTime: 30.0),
  Ride(name: "Thunder Coaster",
       categories: [.family, .thrill],
       waitTime: 60.0),
  Ride(name: "Grand Carousel", categories: [.family, .kids], waitTime: 15.0),
  Ride(name: "Bumper Boats", categories: [.family, .water], waitTime: 25.0),
  Ride(name: "Mountain Railroad",
       categories: [.family, .relaxing],
       waitTime: 0.0)
]

func ridesWithWaitTimeUnder(_ waitTime: Minutes,
                            from rides: [Ride]) -> [Ride] {
  return rides.filter { $0.waitTime < waitTime }
}

let shortWaitRides = ridesWithWaitTimeUnder(15, from: parkRides)
func testShortWaitRides(_ testFilter:(Minutes, [Ride]) -> [Ride]) {
  let limit = Minutes(15)
  let result = testFilter(limit, parkRides)
  print("rides with wait less than 15 minutes:\n\(result)")
  let names = result.map { $0.name }.sorted(by: <)
  let expected = ["Crazy Funhouse",
                  "Mountain Railroad"]
  assert(names == expected)
  print("✅ test rides with wait time under 15 = PASS\n-")
}
testShortWaitRides(ridesWithWaitTimeUnder(_:from:))

// Imperative vs. Declarative Programming
var numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

// Imperative
var newNumbers: [Int] = []
for number in numbers {
  newNumbers.append(number * number)
}

// Declarative
let newNumbers2 = numbers.map { $0 * $0 }

// Higher-order function with function as argument
func squareOperation(value: Int) -> Int {
  print("Original Value is: \(value)")
  let newValue = value * value
  print("New Value is: \(newValue)")
  return newValue
}

let newNumbers3 = numbers.map(squareOperation(value:))

// Function Composition
func extractElements(_ content: String) -> [String] {
  return content.components(separatedBy: ",").map { String($0) }
}

func formatAsCurrency(content: [String]) -> [String] {
  return content.map {"$\($0)"}
}

let content = "10,20,30,40,50,60"
let elements = extractElements(content)
formatAsCurrency(content: elements)

formatAsCurrency(content: extractElements(content))

let formatExtractedElements = {
  data in
  formatAsCurrency(content: extractElements(data))
}
formatExtractedElements(content)

precedencegroup ForwardPipe {
  associativity: left
}

infix operator |> : ForwardPipe

func |> <T, V>(
  f: @escaping (T) -> V,
  g: @escaping (V) -> V ) -> (T) -> V {
  return { x in g(f(x)) }
}

let extractThenFormat = extractElements |> formatAsCurrency
extractThenFormat(content)
