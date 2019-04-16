import UIKit
import CoreData
import Alamofire
import SwiftyJSON
import CoreLocation


class CurrnetWeatherViewController : UIViewController, UIScrollViewDelegate, CLLocationManagerDelegate {
   
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var locationScrollView: UIScrollView!
    @IBOutlet weak var pagesController: UIPageControl!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    //let locationManager = CLLocationManager()
    let coordinate:(lat: Double, lon: Double) = (53.9023,27.5619)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        escapeNavigationBar()
        
        
        
        
        
        ForecastService.shared.getCurrentWeather(latitude: coordinate.lat, longitude: coordinate.lon){ [weak self] text in
            DispatchQueue.main.async {
                
                print(text)
            }
        
        }
        
        
        
        // startingLocationManager()
    }
    
    
    
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//    Alamofire.request("https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&units=metric&appid=\(apiKey)").responseJSON {
//
//        response in
//
//        if let responseStr = response.result.value{
//            let jsonResponse = JSON(responseStr)
//            print(jsonResponse)
//            let jsonWeather = jsonResponse["weather"].array![0]
//            let jsonTemp = jsonResponse["main"]
//            let iconName = jsonWeather["icon"].stringValue
//
//
//            self.locationLabel.text = jsonResponse["name"].stringValue
//            self.conditionImageView.image = UIImage(named: iconName)
//            self.conditionLabal.text = jsonWeather["main"].stringValue
//            self.temperatureLabel.text = "\(Int(round(jsonTemp["temp"].doubleValue)))°C"
//        }
//        }
//    }
//
}



//extension CurrnetWeatherViewController {
//    func startingLocationManager(){
//        locationManager.requestWhenInUseAuthorization()
//        if(CLLocationManager.locationServicesEnabled()){
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyBest
//            locationManager.startUpdatingLocation()
//        }
//    }
//}
