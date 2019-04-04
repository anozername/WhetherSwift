import Foundation


let APPID = "e7a6caa465aee8f94b57375dde1ba754"
let baseURL = URL(string : "https://api.openweathermap.org/data/2.5/weather?q=")!

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
    let pressure : Int
    let humidity : Int
    let temp_min : Double
    let temp_max : Double
}

struct Wind : Codable {
    let speed : Double
    let deg : Int
}

struct Clouds : Codable {
    let all : Int
}

struct Sys : Codable {
    let type : Int
    let id : Int
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

struct StoreItem: Codable { //useless for now
    let id : Int
}
    
func getWeatherByCityNameAndCountryCode(city : String, country : String) {
    let query: [String: String] = [
        "q" : city + "," + country,
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
            print(response)
            //completion(storeItems.results, nil)
        } catch let parseError {
            print(parseError)
            print("doh")
            //completion(nil, parseError)
        }
    }
    task.resume()
    //RunLoop.main.run()
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
            //completion(nil, error ?? FetchError.unknownNetworkError)
            return
        }
        do {
            let response = try JSONDecoder().decode(Response.self, from: data)
            print(response)
            //completion(storeItems.results, nil)
        } catch let parseError {
            print(parseError)
            print("doh")
            //completion(nil, parseError)
        }
    }
    task.resume()
    RunLoop.main.run()
}

func findCityByName(city : String) {
    if let path = Bundle.main.path(forResource: "test", ofType: "json") {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            if let jsonResult = jsonResult as? City {
                print("TODO")
            }
        }catch{}
    }
}
print("Name&Code")
print(getWeatherByCityNameAndCountryCode(city: "Paris", country: "fr"))

print("Name")
print(getWeatherByCityName(city: "London"))

