import Foundation
import Alamofire
import SwiftyJSON

class ForecastService {
  
    static let shared = ForecastService()
    
    let forecastAPIKey = "03f07442bb1ee385c3c61ec678db4d9b"
    var forecastBaseURL = "https://api.openweathermap.org/data/2.5/weather?lang=en&units=metric&appid="
    
    
    func getCurrentWeather(_ latitude : Double,_ longitude : Double, completion : @escaping (_ resault : String) -> () ){
        
        if let forecastURL = URL(string: "\(forecastBaseURL)\(forecastAPIKey)&lat=\(latitude)&lon=\(longitude)"){
            Alamofire.request(forecastURL).responseJSON(completionHandler: {(response) in
                DispatchQueue.global().async() {
                    if let responseStr = response.result.value{
                        let jsonResponse = JSON(responseStr)
                        let iconName = jsonResponse["weather"].array![0]["icon"].stringValue
                       // let location = jsonResponse["name"].stringValue
                       //print(jsonResponse)
                        completion(iconName)
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
                print(cityList[0])
                completion(cityList)
            } else {
                print("erorr")
            }
            
        }
    }
    
    func getCityPrefix(_ cities : [String],_ text : String, completion : @escaping (_ resault : [String]) -> ()){
        DispatchQueue.global().async {
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
