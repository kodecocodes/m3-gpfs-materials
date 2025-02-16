import UIKit

// Swap two Ints
func swapTwoValues(a: Int, b: Int) -> (a: Int, b: Int) {
  let temp = a
  let newA = b
  let newB = temp
  return (newA, newB)
}

swapTwoValues(a: 42, b: 5)

// Swap two Strings
func swapTwoValues(a: String, b: String) -> (a: String, b: String) {
  let temp = a
  let newA = b
  let newB = temp
  return (newA, newB)
}

swapTwoValues(a: "begin", b: "finish")

// Generic swap function
func swapValues<T>(a: T, b: T) -> (a: T, b: T) {
  let temp = a
  let newA = b
  let newB = temp
  return (newA, newB)
}

swapValues(a: 42, b: 5)
swapValues(a: "begin", b: "finish")

// Generic type
struct Setting<T> {
  let key: String

  var value: T? {
    get {
      UserDefaults.standard.value(forKey: key) as? T
    } set {
      UserDefaults.standard.setValue(newValue, forKey: key)
    }
  }
}

var volume = Setting<Float>(key: "audioVolume")
volume.value = 0.5

let setting: Setting<Int> = .init(key: "myKey")

// Extension of generic type: Constrain the extension
//extension Setting where T: Decodable {
//  mutating func save(from untypedValue: Any) {
//    if let value = untypedValue as? T {
//      self.value = value
//    }
//  }
//
//  mutating func save(from json: Data) throws {
//    let decoder = JSONDecoder()
//    self.value = try decoder.decode(T.self, from: json)
//  }
//}

// Extension of generic type: Constrain a method
extension Setting {
  mutating func save(from untypedValue: Any) {
    if let value = untypedValue as? T {
      self.value = value
    }
  }

  // Constraint on method where T isn't a parameter type
  mutating func save(from json: Data) throws where T: Decodable {
    let decoder = JSONDecoder()
    self.value = try decoder.decode(T.self, from: json)
  }
}
