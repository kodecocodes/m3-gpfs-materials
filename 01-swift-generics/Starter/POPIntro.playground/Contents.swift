import Foundation

protocol Vehicle {
    var numberOfWheels: Int { get }
    var maxSpeed: Double { get }
    var totalDistanceTraveled: Double { get set }
    func showDetails() -> String
    func move(direction: Direction, duration: TimeInterval, speed: Double)
}

enum Direction {
    case forward
    case backwards
}

class FamilyCar: Vehicle {
    let maxSpeed: Double
    let numberOfWheels: Int
    var totalDistanceTraveled: Double
    
    init() {
        self.maxSpeed = 50.0
        self.numberOfWheels = 4
        self.totalDistanceTraveled = 0.0
    }
    
    func move(direction: Direction, duration: TimeInterval, speed: Double) {
        let travelingSpeed: Double
        if speed < 0 {
          travelingSpeed = 0
        } else if speed > maxSpeed {
          travelingSpeed = maxSpeed
        } else {
          travelingSpeed = speed
        }
        let distance = travelingSpeed * duration
        if direction == .backwards {
          totalDistanceTraveled = totalDistanceTraveled - distance
          print("Traveled -\(distance)")
        } else {
          totalDistanceTraveled = totalDistanceTraveled + distance
          print("Traveled \(distance)")
        }
    }
    
    func showDetails() -> String {
        "I am a family car"
    }
}

open class VehicleType {
    let numberOfWheels: Int
    var maxSpeed: Double
    var totalDistanceTraveled: Double
    
    init() {
        self.numberOfWheels = 4
        self.maxSpeed = 100
        self.totalDistanceTraveled = 0.0
    }
    
    func move(direction: Direction, duration: TimeInterval, speed: Double) {
        let travelingSpeed: Double
        if speed < 0 {
          travelingSpeed = 0
        } else if speed > maxSpeed {
          travelingSpeed = maxSpeed
        } else {
          travelingSpeed = speed
        }
        let distance = travelingSpeed * duration
        if direction == .backwards {
          totalDistanceTraveled = totalDistanceTraveled - distance
          print("Traveled -\(distance)")
        } else {
          totalDistanceTraveled = totalDistanceTraveled + distance
          print("Traveled \(distance)")
        }
    }
    
    func showDetails() -> String {
        "I am a vehicle"
    }
}

class FamilyCarInheritance: VehicleType {
    let carMaxSpeed = 50.0
    override var maxSpeed: Double {
        get {
            return carMaxSpeed
        }
        set {
            // Do nothing
        }
    }

    override func move(direction: Direction, duration: TimeInterval, speed: Double) {
        super.move(direction: direction, duration: duration, speed: speed)
        print("Current distance is \(totalDistanceTraveled)")
    }

    override func showDetails() -> String {
        "I am a family car"
    }
}

let familyCar = FamilyCar()
familyCar.move(direction: .forward, duration: 15, speed: 30)
familyCar.move(direction: .forward, duration: 15, speed: 60)
print(familyCar.showDetails())


// Added code for Generics 03-instruction2
func max<T: Comparable>(lhs: T, rhs: T) -> T {
  return lhs > rhs ? lhs : rhs
}
// TODO: Instantiate myCar, call max


let familyCar2 = FamilyCarInheritance()
familyCar2.move(direction: .forward, duration: 15, speed: 30)
familyCar2.move(direction: .forward, duration: 15, speed: 60)
print(familyCar2.showDetails())

class Truck: Vehicle {
    var numberOfWheels: Int
    
    var maxSpeed: Double
    
    var totalDistanceTraveled: Double
    
    func showDetails() -> String {
        "I am a truck"
    }
    
    init() {
      self.numberOfWheels = 6
      self.maxSpeed = 30
      self.totalDistanceTraveled = 0
    }
    
    func move(direction: Direction, duration: TimeInterval, speed: Double) {
        let travelingSpeed: Double
        if speed < 0 {
          travelingSpeed = 0
        } else if speed > maxSpeed {
          travelingSpeed = maxSpeed
        } else {
          travelingSpeed = speed
        }
        let distance = travelingSpeed * duration
        if direction == .backwards {
          totalDistanceTraveled = totalDistanceTraveled - distance
          print("Traveled -\(distance)")
        } else {
          totalDistanceTraveled = totalDistanceTraveled + distance
          print("Traveled \(distance)")
        }
    }
}

let truck = Truck()
truck.numberOfWheels = 12
