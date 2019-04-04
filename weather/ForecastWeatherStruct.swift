import Foundation

struct ForecastWeather: Codable {
    let list : [Prevision]
    let city : City
}

struct Prevision: Codable {
    let dt : Int
    let main : Main
    let weather : [Weather]
    let clouds : Clouds
    let wind : Wind
    let sys : ForecastSys
    let dt_txt : String
}

struct ForecastSys: Codable {
    let pod : String
}
