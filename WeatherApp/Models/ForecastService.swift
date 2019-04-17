import Foundation
import Alamofire
import SwiftyJSON

class ForecastService {
  
    static let shared = ForecastService()
    
    let forecastAPIKey = "03f07442bb1ee385c3c61ec678db4d9b"
    var forecastBaseURL = "https://api.openweathermap.org/data/2.5/weather?lang=en&units=metric&appid="
    
    
    func getCurrentWeather(name : String, completion : @escaping (_ resault : [String : String]) -> () ){
        
        if let forecastURL = URL(string: "\(forecastBaseURL)\(forecastAPIKey)&q=\(name)"){
            Alamofire.request(forecastURL).responseJSON(completionHandler: {(response) in
                DispatchQueue.global().async() {
                    if let responseStr = response.result.value{
                        var currentWeather : [String : String] = [:]
                        let jsonResponse = JSON(responseStr)
                        let location = jsonResponse["name"].stringValue
                        currentWeather["location"] = location
                        let temperature = "\(jsonResponse["main"]["temp"].stringValue)°C"
                        currentWeather["temperature"] = temperature
                        print(jsonResponse)
                        completion(currentWeather)
                    } 
              }
                
            })
        }
        
    }
    
}
