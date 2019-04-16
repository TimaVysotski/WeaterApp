import UIKit
import CoreData
import Alamofire
import SwiftyJSON
import CoreLocation


class CurrnetWeatherViewController : UIViewController, CLLocationManagerDelegate {
   
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var conditionLabal: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var iconNameLabel: UILabel!
    
    var cityName = "Minsk"
    
    let locationManager = CLLocationManager()
    let apiKey = "03f07442bb1ee385c3c61ec678db4d9b"
    // https://api.openweathermap.org/data/2.5/weather?q=Minsk&units=metric&appid=03f07442bb1ee385c3c61ec678db4d9b
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBackGroundView()
        escapeNavigationBar()
        
        startingLocationManager()
        
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    Alamofire.request("https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&units=metric&appid=\(apiKey)").responseJSON {

        response in
        
        if let responseStr = response.result.value{
            let jsonResponse = JSON(responseStr)
            print(jsonResponse)
            let jsonWeather = jsonResponse["weather"].array![0]
            let jsonTemp = jsonResponse["main"]
            let iconName = jsonWeather["icon"].stringValue

            self.locationLabel.text = jsonResponse["name"].stringValue
            self.conditionImageView.image = UIImage(named: iconName)
            self.conditionLabal.text = jsonWeather["main"].stringValue
            self.temperatureLabel.text = "\(Int(round(jsonTemp["temp"].doubleValue)))°C"
        }
        }
    }
    
}

extension UIViewController {
    func setUpBackGroundView(){
        let backGroundImage : UIImage =  UIImage(image: .lightBackground)
        return self.view.layer.contents = backGroundImage.cgImage
    }
}

extension CurrnetWeatherViewController {
    func startingLocationManager(){
        locationManager.requestWhenInUseAuthorization()
        if(CLLocationManager.locationServicesEnabled()){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
}
