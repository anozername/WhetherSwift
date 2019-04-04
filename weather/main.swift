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

struct Point : Codable {
    let lon : Double
    let lat : Double
}

struct City : Codable {
    let id : Int
    let name : String
    let country : String
    let coord : Point
    
    enum CodingKeys : String, CodingKey {
        case id
        case name
        case country
        case coord
    }
}

func getWeatherByCityName(city : String, country : String) {
    let query: [String: String] = [
        "q" : city + "," + country,
        "appid" : APPID
    ]
    let url = baseURL.withQueries(query)!
    let task = URLSession.shared.dataTask(with: url) {
        (data, response, error) in
        let jsonDecoder = JSONDecoder()
        if let data = data,
            let report = try? jsonDecoder.decode(TODO.self,from: data)
        {
            for result in report.results {
                print("\'\(result.collectionName)\' par \'\(result.artistName)\'")
            }
        }
        exit(EXIT_SUCCESS)
    }
        
    task.resume()
}

func findCityByName(city : String) {
    if let path = Bundle.main.path(forResource: "test", ofType: "json") {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? City {
                    print("\'\(result.collectionName)\' par \'\(result.artistName)\'")
                }
        } catch {
            
        }
    }
    
}

print(getWeatherByCityName(city: "Paris", country: "fr"))
