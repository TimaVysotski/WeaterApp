import Foundation

class CurrentWeather {
   
    let temperature: Int?
    let humidity: Int?
    let precipProbability: Int?
    let summary: String?
    let icon: String?
    
    struct WeatherKeys {
        static let temperature = "temperature"
        static let humidity = "humidity"
        static let precipProbability = "precipProbability"
        static let summery = "summery"
        static let icon = "icon"
    }
    
    init(weatherDictionary: [String : Any]){
        temperature = weatherDictionary[WeatherKeys.temperature] as? Int
        
        if let hunidityDouble = weatherDictionary[WeatherKeys.humidity] as? Double{
            humidity = Int(hunidityDouble * 100)
        } else {
            humidity = nil
        }
        
        if let precipProbabilityDouble = weatherDictionary[WeatherKeys.precipProbability] as? Double{
            precipProbability = Int(precipProbabilityDouble * 100)
        } else {
            precipProbability = nil
        }
        
        summary = weatherDictionary[WeatherKeys.summery] as? String
        icon = weatherDictionary[WeatherKeys.icon] as? String
    }
}
