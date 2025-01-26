import UIKit

// Protocol inheritance & extension

enum Language {
  case english, german, croatian
}

protocol Localizable {
  static var supportedLanguages: [Language] { get }
}

protocol MutableLocalizable: Localizable {
  mutating func change(to language: Language)
}

protocol UIKitLocalizable: AnyObject, Localizable {
  func change(to language: Language)
}

protocol LocalizableViewController where Self: UIViewController {
  func showLocalizedAlert(text: String)
}

protocol Greetable {
  func greet() -> String
}

extension Greetable {
  func greet() -> String {
    return "Hello"
  }

  func leave() -> String {  // not a requirement of Greetable
    return "Bye"
  }
}

//struct GermanGreeter: Greetable { }
struct GermanGreeter: Greetable {
  func greet() -> String {
    return "Hallo"
  }

  func leave() -> String {
    return "Tschüss"
  }
}

let greeter = GermanGreeter()
greeter.greet()  // Hello; Hallo
greeter.leave()  // Bye; Tschüss

let greeterX: Greetable = GermanGreeter()
greeterX.greet()  // Hallo
greeterX.leave()  // Bye

// Inheritance vs. Composition

//protocol DiskWritable: Encodable {
protocol DiskWritable {
  func writeToDisk(at url: URL) throws
}

//extension DiskWritable {
extension DiskWritable where Self: Encodable {
  func writeToDisk(at url: URL) throws {
    let encoder = JSONEncoder()
    let data = try encoder.encode(self)
    try data.write(to: url)
  }
}

typealias DiskWritableByEncoding = DiskWritable & Encodable
//struct TodoList: DiskWritable, Encodable {
struct TodoList: DiskWritableByEncoding {
  var name: String
  var items: [String]  // simplified Item
}

// Type erasure

protocol Request {
  associatedtype Response
  associatedtype Error: Swift.Error
//  func perform(then handler: @escaping (Result<Response, Error>) -> Void)
  typealias Handler = (Result<Response, Error>) -> Void
  func perform(then handler: @escaping Handler)
}

struct NetworkRequest: Request {
//  typealias Response = HTTPURLResponse
//  typealias Error = URLError
//  func perform(then handler: @escaping (Result<Response, Error>) -> Void) { }
  func perform(then handler: @escaping (Result<HTTPURLResponse, URLError>) -> Void) { }
}

//func fetchAll(_ requests: [Request]) { }  // Uncomment to see error message
func fetchAll<R: Request>(_ requests: [R]) { }

struct AnyRequest<Response, Error: Swift.Error> {
  typealias Handler = (Result<Response, Error>) -> Void
  let perform: (@escaping Handler) -> Void
  let handler: Handler
}

enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case update = "UPDATE"
  case delete = "DELETE"
}

//protocol APIRequest {
protocol APIRequest: Hashable {
  var url: URL { get }
  var method: HTTPMethod { get }
  associatedtype Output
  func decode(_ data: Data) throws -> Output
}

struct AnyAPIRequest: Hashable {
  let url: URL
  let method: HTTPMethod
}

class APIRequestCache<Value> {
//  private var store: [any APIRequest: Value] = [:]  // Uncomment to see error message
  private var store: [AnyAPIRequest: Value] = [:]

  func response<R: APIRequest>(for request: R) -> Value? where R.Output == Value {
    let erasedAPIRequest = AnyAPIRequest(url: request.url, method: request.method)
    return store[erasedAPIRequest]
  }

  func saveResponse<R: APIRequest>(_ response: Value, for request: R) where R.Output == Value {
    let erasedAPIRequest = AnyAPIRequest(url: request.url, method: request.method)
    store[erasedAPIRequest] = response
  }
}

// Primary Associated Types

protocol Request2<Response> {
    associatedtype Response
    associatedtype Error: Swift.Error
    func perform(then handler: @escaping (Result<Response, Error>) -> Void)
}

//extension Request2 where Response == HTTPURLResponse { }
extension Request2<HTTPURLResponse> { }

let networkRequests: [any Request2<HTTPURLResponse>]

// Protocols are non-nominal types
protocol MyProtocol {
  var number: Int { get set }
  init(number: Int)
}

//let mp = MyProtocol(number: 42)  // uncomment to see error

// Simulating Abstract Classes
// See [Abstract types and methods in Swift](https://www.swiftbysundell.com/articles/abstract-types-and-methods/)
