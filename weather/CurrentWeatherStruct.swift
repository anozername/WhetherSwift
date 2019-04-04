import Foundation

struct City : Codable {
    let id : Int
    let name : String
    let country: String
    let coord : Coord
    
    enum CodingKeys : String, CodingKey {
        case id
        case name
        case country
        case coord
    }
}

struct Coord : Codable {
    let lon : Double
    let lat : Double
}

struct Weather : Codable {
    let id : Int
    let main : String
    let description : String
    let icon : String
}

struct Main : Codable {
    let temp : Double
    let pressure : Double
    let humidity : Double
    let temp_min : Double
    let temp_max : Double
}

struct Wind : Codable {
    let speed : Double
    let deg : Double
}

struct Clouds : Codable {
    let all : Int
}

struct Sys : Codable {
    //let type : Int
    //let id : Int
    let message : Double
    let country : String
    let sunrise : Int
    let sunset : Int
}

struct CurrentWeather: Codable {
    let coord : Coord
    let weather : [Weather]
    let base : String
    let main : Main
    let wind : Wind
    let clouds : Clouds
    let dt : Int
    let sys : Sys
    let id : Int
    let name : String
}
