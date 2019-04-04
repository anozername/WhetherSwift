import Foundation
import Cocoa

let APPID = "e7a6caa465aee8f94b57375dde1ba754"
let currentURL = URL(string : "https://api.openweathermap.org/data/2.5/weather?q=")!
let forecastURL = URL(string : "https://api.openweathermap.org/data/2.5/forecast?q=")!
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

func getCurrentWeatherByCityNameAndCountryCode(city : String, country : String){
    let query: [String: String] = [
        "q" : city + "," + country,
        "appid" : APPID
    ]
    let url = currentURL.withQueries(query)!
    print(url)
    let task = URLSession.shared.dataTask(with: url) { data, _, error in
        guard let data = data, error == nil else { return }
        do {
            let response = try JSONDecoder().decode(CurrentWeather.self, from: data)
            //print("bulk :\(response)")
            print("\nCurrent weather : \(response.weather[0].description) in \(response.name)")
            CFRunLoopStop(runLoop)
        } catch let parseError {
            print("bulk :\n\(parseError)")
            print("the city name you had entered is unknow")
            CFRunLoopStop(runLoop)
        }
    }
    task.resume()
}

func getCurrentWeatherByCityName(city : String) {
    let query: [String: String] = [
        "q" : city,
        "appid" : APPID
    ]
    let url = currentURL.withQueries(query)!
    print(url)
    let task = URLSession.shared.dataTask(with: url) { data, _, error in
        guard let data = data, error == nil else { return }
        do {
            let response = try JSONDecoder().decode(CurrentWeather.self, from: data)
            //print("bulk :\n\(response)")
            print("\nCurrent weather : \(response.weather[0].description) in \(response.name)")
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
    let url = currentURL.withQueries(query)!
    print(url)
    let task = URLSession.shared.dataTask(with: url) { data, _, error in
        guard let data = data, error == nil else { return }
        do {
            let response = try JSONDecoder().decode(CurrentWeather.self, from: data)
            //print("bulk :\n\(response)")
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

func forecastByCityName(city : String) {
    let query: [String: String] = [
        "q" : city,
        "appid" : APPID
    ]
    let url = forecastURL.withQueries(query)!
    print(url)
    let task = URLSession.shared.dataTask(with: url) { data, _, error in
        guard let data = data, error == nil else { return }
        do {
            let response = try JSONDecoder().decode(ForecastWeather.self, from: data)
            //print("bulk :\n\(response)")
            for index in 0...9 {
                print(" \nWeather \(response.list[4*index].dt_txt): \(response.list[4*index].weather[0].description)")
            }
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
getCurrentWeatherByCityName(city: name!)
CFRunLoopRun()
print("end 2")
print("\nstart 3")
forecastByCityName(city: name!)
CFRunLoopRun()
print("end 3")

