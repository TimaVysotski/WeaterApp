import Foundation
import Alamofire
import SwiftyJSON

class ForecastService {
  
    static let shared = ForecastService()
    
    let forecastAPIKey = "03f07442bb1ee385c3c61ec678db4d9b"
    var forecastBaseURL = "https://api.openweathermap.org/data/2.5/weather?lang=en&units=metric&appid="
    

    func getCurrentWeather(_ cityName : String, completion : @escaping (_ resault : [String : String]) -> () ){
        
        if let forecastURL = URL(string: "\(forecastBaseURL)\(forecastAPIKey)&q=\(cityName)"){
            Alamofire.request(forecastURL).responseJSON(completionHandler: {(response) in
                DispatchQueue.global().async() {
                    if let responseWeather = response.result.value{
                        var currentWeather = [String : String]()
                        
                        let jsonResponse = JSON(responseWeather)
                        let jsonWeather = jsonResponse[Weather.weather].array![0]
                        let jsonMain = jsonResponse[Weather.main]
                        currentWeather[Weather.location] = jsonResponse[Weather.name].stringValue
                        currentWeather[Weather.temperature] = "\(Int(round(jsonMain[Weather.temp].doubleValue)))°C"
                        currentWeather[Weather.icon] = jsonWeather[Weather.icon].stringValue
                        currentWeather[Weather.backgroundImage] = "\(jsonResponse[Weather.weather].array![0][Weather.icon])b"
                        print("________________")
                        print(currentWeather)
                        completion(currentWeather)
                    } else {
                        print("Error")
                    }
              }
                
            })
        }
        
    }
    
    func getCurrentCity(completion : @escaping (_ resault : [String]) -> ()){
        DispatchQueue.global().async {
            var cityList = [String]()
            if let path = Bundle.main.path(forResource: "cityList", ofType: "txt"){
                if let text = try? String(contentsOfFile: path){
                    cityList = text.components(separatedBy: "\n")
                }
                completion(cityList)
            } else {
                print("erorr")
            }
            
        }
    }
    
    func getCityPrefix(_ cities : [String],_ text : String, completion : @escaping (_ resault : [String]) -> ()){
        DispatchQueue.global().async() {
            var requiredCities : [String] = []
            if text == ""{
                completion(requiredCities)
            } else {
                requiredCities = cities.filter({$0.lowercased().prefix(text.count) == text.lowercased()})
                completion(requiredCities)
            }
        }
    }
    
}
