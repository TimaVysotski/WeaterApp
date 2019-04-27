import Foundation
import Alamofire
import SwiftyJSON


class CitiesService {
    static let shared = CitiesService()
    
    private let forecastAPIKey = "03f07442bb1ee385c3c61ec678db4d9b"
    private var forecastBaseURL = "https://api.openweathermap.org/data/2.5/weather?lang=en&units=metric&appid="
    
    
    func getSelfLocation(_ lat : Double, _ lon : Double, completion : @escaping (_ resault : String) -> ()){
        if let forecastURL = URL(string: "\(forecastBaseURL)\(forecastAPIKey)&lan=\(lat)&lon=\(lon)"){
            Alamofire.request(forecastURL).responseJSON(completionHandler: {(response) in
                DispatchQueue.global().async() {
                    if let responseWeather = response.result.value{
                        var currentCity = String()
                        let jsonResponse = JSON(responseWeather)
                        currentCity = jsonResponse[Words.name].stringValue
                        completion(currentCity)
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
