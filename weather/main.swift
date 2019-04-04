import Foundation
import Cocoa

let APPID = "e7a6caa465aee8f94b57375dde1ba754"
let baseURL = URL(string : "https://api.openweathermap.org/data/2.5/weather?q=")!
let runLoop = CFRunLoopGetCurrent()


extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.flatMap {
            URLQueryItem(name: $0.0, value: $0.1)
        }
        return components?.url
    }
}

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

struct Response: Codable {
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

func getWeatherByCityNameAndCountryCode(city : String, country : String){
    let query: [String: String] = [
        "q" : city + "," + country,
        "appid" : APPID
    ]
    let url = baseURL.withQueries(query)!
    print(url)
    let task = URLSession.shared.dataTask(with: url) { data, _, error in
        guard let data = data, error == nil else {
            return
        }
        do {
            let response = try JSONDecoder().decode(Response.self, from: data)
            print("bulk :\(response)")
            print("\nWeather : \(response.weather[0].description) in \(response.name)")
            CFRunLoopStop(runLoop)
        } catch let parseError {
            print("bulk :\n\(parseError)")
            print("the city name you had entered is unknow")
            CFRunLoopStop(runLoop)
        }
    }
    task.resume()
}

func getWeatherByCityName(city : String) {
    let query: [String: String] = [
        "q" : city,
        "appid" : APPID
    ]
    let url = baseURL.withQueries(query)!
    print(url)
    let task = URLSession.shared.dataTask(with: url) { data, _, error in
        guard let data = data, error == nil else {
            return
        }
        do {
            let response = try JSONDecoder().decode(Response.self, from: data)
            print("bulk :\n\(response)")
            print("\nWeather : \(response.weather[0].description) in \(response.name)")
            CFRunLoopStop(runLoop)
        } catch let parseError {
            print("bulk :\n\(parseError)")
            print("the city name you had entered is unknow")
            CFRunLoopStop(runLoop)
        }
    }
    task.resume()
}

func findCityByName(city : String) {
    let query: [String: String] = [
        "q" : city,
        "appid" : APPID
    ]
    let url = baseURL.withQueries(query)!
    print(url)
    let task = URLSession.shared.dataTask(with: url) { data, _, error in
        guard let data = data, error == nil else {
            //completion(nil, error ?? FetchError.unknownNetworkError)
            return
        }
        do {
            let response = try JSONDecoder().decode(Response.self, from: data)
            print("bulk :\n\(response)")
            print("\nWe found that : \(response.name) is in \(response.sys.country) at \(response.coord.lon) lon, \(response.coord.lat) lat")
            CFRunLoopStop(runLoop)
        } catch let parseError {
            print("bulk :\n\(parseError)")
            print("the city name you had entered is unknow")
            CFRunLoopStop(runLoop)
        }
    }
    task.resume()
}

print("Please enter a known city name", terminator: ".\n")
let name = readLine()
print("\nstart 1")
findCityByName(city: name!)
CFRunLoopRun()
print("end 1")
print("\nstart 2")
getWeatherByCityName(city: name!)
CFRunLoopRun()
print("end 2")
