import Foundation
import Alamofire
import SwiftyJSON

class ForecastService {
  
    static let shared = ForecastService()
    
    private let forecastAPIKey = "03f07442bb1ee385c3c61ec678db4d9b"
    private var forecastBaseURL = "https://api.openweathermap.org/data/2.5/"
    private var forecastParameters = "?lang=en&units=metric&appid="
    
    
    func getCurrentWeather(_ cityName : String,_ weather : CurrentWeather, completion : @escaping (_ resault : CurrentWeather) -> () ){
        if let forecastURL = URL(string: "\(forecastBaseURL)weather\(forecastParameters)\(forecastAPIKey)&q=\(cityName)"){
            Alamofire.request(forecastURL).responseJSON(completionHandler: {(response) in
                DispatchQueue.global().async() {
                    if let responseWeather = response.result.value{
                        let jsonResponse = JSON(responseWeather)
                        weather.location = jsonResponse[Words.name].stringValue
                        weather.descriptionToday = jsonResponse[Words.weather].array![0][Words.description].stringValue
                        weather.iconToday = jsonResponse[Words.weather].array![0][Words.icon].stringValue
                        weather.backgroundImage = "\(weather.iconToday)b"
                        weather.temperatureToday = "\(jsonResponse[Words.main][Words.temp].intValue)°"
                        let maxTemperature = jsonResponse[Words.main][Words.maxTemperature].doubleValue
                        let minTemperature = jsonResponse[Words.main][Words.minTemperature].doubleValue
                        weather.feltTemperature = "\(Int((maxTemperature + minTemperature) / 2))°"
                        completion(weather)
                    } else {
                        print("Error")
                    }
                }
            })
        }
        
    }
    

    func getWeekWeather(_ cityName : String,_ weather : CurrentWeather, completion : @escaping (_ resault : CurrentWeather) -> () ){
        if let forecastURL = URL(string: "\(forecastBaseURL)forecast\(forecastParameters)\(forecastAPIKey)&q=\(cityName)"){
            Alamofire.request(forecastURL).responseJSON(completionHandler: {(response) in
                DispatchQueue.global().async() {
                    if let responseWeather = response.result.value{
                        let jsonResponse = JSON(responseWeather)
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
                        weather.fifthDayTemperature = "\(jsonResponse[Words.list].array![39][Words.main][Words.temp].intValue)°"
                        weather.fifthDayIcon = jsonResponse[Words.list].array![39][Words.weather].array![0][Words.icon].stringValue
                        let date = Date()
                        let calendar = Calendar.current
                        weather.todayDayNameId = Int("\(calendar.component(.weekday, from: date))")!
                        self.calculateDay(weather)
                        weather.todayDayName = self.checkWeekDayName(weather.todayDayNameId)
                        weather.firstDayName = self.checkWeekDayName(weather.firstDayNameId)
                        weather.secondDayName = self.checkWeekDayName(weather.secondDayNameId)
                        weather.thirdDayName = self.checkWeekDayName(weather.thirdDayNameId)
                        weather.fourthDayName = self.checkWeekDayName(weather.fourthDayNameId)
                        weather.fifthDayName = self.checkWeekDayName(weather.fifthDayNameId)
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
            direction = "!?"
        }
        return direction
    }
    
    func calculateDay(_ weather : CurrentWeather){
        weather.firstDayNameId = weather.todayDayNameId == 7 ? 1 : (weather.todayDayNameId + 1)
        weather.secondDayNameId = weather.firstDayNameId == 7 ? 1 : (weather.firstDayNameId + 1)
        weather.thirdDayNameId = weather.secondDayNameId == 7 ? 1 : (weather.secondDayNameId + 1)
        weather.fourthDayNameId = weather.thirdDayNameId == 7 ? 1 : (weather.thirdDayNameId + 1)
        weather.fifthDayNameId = weather.fourthDayNameId == 7 ? 1 : (weather.fourthDayNameId + 1)
    }
    
    func checkWeekDayName(_ dayId : Int) -> String{
        var dayName = String()
        switch dayId {
        case 1 :
            dayName = "Sun"
        case 2 :
            dayName = "Mon"
        case 3 :
            dayName = "Tue"
        case 4 :
            dayName = "Wed"
        case 5 :
            dayName = "Thu"
        case 6 :
            dayName = "Fri"
        case 7 :
            dayName = "Sat"
        default:
            dayName = "!?"
        }
        return dayName
    }
}
