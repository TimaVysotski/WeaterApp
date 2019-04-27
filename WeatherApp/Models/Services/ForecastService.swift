import Foundation
import Alamofire
import SwiftyJSON

class ForecastService {
  
    static let shared = ForecastService()
    
    private let forecastAPIKey = "03f07442bb1ee385c3c61ec678db4d9b"
    private var forecastBaseURL = "https://api.openweathermap.org/data/2.5/forecast?lang=en&units=metric&appid="
    

    func getCurrentWeather(_ cityName : String,_ weather : CurrentWeather, completion : @escaping (_ resault : CurrentWeather) -> () ){
  
        if let forecastURL = URL(string: "\(forecastBaseURL)\(forecastAPIKey)&q=\(cityName)"){
            Alamofire.request(forecastURL).responseJSON(completionHandler: {(response) in
                DispatchQueue.global().async() {
                    if let responseWeather = response.result.value{
                        let jsonResponse = JSON(responseWeather)
                        
                        weather.location = jsonResponse[Words.city][Words.name].stringValue 
                        weather.temperatureToday = "\(jsonResponse[Words.list].array![0][Words.main][Words.temp].intValue)°"
                        let maxTemperature = jsonResponse[Words.list].array![0][Words.main][Words.maxTemperature].doubleValue
                        let minTemperature = jsonResponse[Words.list].array![0][Words.main][Words.minTemperature].doubleValue
                        weather.feltTemperature = "\(Int((maxTemperature + minTemperature) / 2))°"
                        weather.weatherDesriptionToday = jsonResponse[Words.list].array![0][Words.weather].array![0][Words.description].stringValue
                        weather.weatherIconToday = jsonResponse[Words.list].array![0][Words.weather].array![0][Words.icon].stringValue
                        weather.windSpeed = "\(jsonResponse[Words.list].array![0][Words.wind][Words.speed].doubleValue) m/sec"
                        weather.windDirection = self.checkWindDirection(jsonResponse[Words.list].array![0][Words.wind][Words.degree].intValue)
                        weather.firstDayTemperature = "\(jsonResponse[Words.list].array![8][Words.main][Words.temp].intValue)°"
                        weather.firstDayIcon = jsonResponse[Words.list].array![8][Words.weather].array![0][Words.icon].stringValue
                        weather.secondDayTemperature = "\(jsonResponse[Words.list].array![16][Words.main][Words.temp].intValue)°"
                        weather.secondDayIcon = jsonResponse[Words.list].array![16][Words.weather].array![0][Words.icon].stringValue
                        weather.thirdDayTemperature = "\(jsonResponse[Words.list].array![24][Words.main][Words.temp].intValue)°"
                        weather.thirdDayIcon = jsonResponse[Words.list].array![24][Words.weather].array![0][Words.icon].stringValue
                        weather.fourthDayTemperature = "\(jsonResponse[Words.list].array![32][Words.main][Words.temp].intValue)°"
                        weather.fourthayIcon = jsonResponse[Words.list].array![32][Words.weather].array![0][Words.icon].stringValue
                        weather.fifthDayTemperature = "\(jsonResponse[Words.list].array![40][Words.main][Words.temp].intValue)°"
                        weather.fifthDayIcon = jsonResponse[Words.list].array![40][Words.weather].array![0][Words.icon].stringValue
                        
                        completion(weather)
                    } else {
                        print("Error")
                    }
              }
            })
        }
        
    }
    
    func checkWindDirection(_ windDegree : Int) -> String{
        var direction = String()
        switch windDegree {
            case 0 :
                direction = "N"
            case 90 :
                direction = "E"
            case 180 :
                direction = "S"
            case 270 :
                direction = "W"
            case 360 :
                direction = "N"
            case 1..<90 :
                direction = "NE"
            case 91..<180 :
                direction = "ES"
            case 181..<270 :
                direction = "SW"
            case 271..<360 :
                direction = "WN"
            default:
                direction = "UNCKNOWN Direction"
        }
        return direction
    }
}
