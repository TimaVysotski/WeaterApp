import UIKit
import CoreData
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView
import CoreLocation


class CurrnetWeatherViewController : UIViewController, CLLocationManagerDelegate {
   
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var conditionLabal: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var iconNameLabel: UILabel!
    
    var activityIndicator: NVActivityIndicatorView!
    var cityName = "Minsk"
    
    let locationManager = CLLocationManager()
    let apiKey = "03f07442bb1ee385c3c61ec678db4d9b"
    // https://api.openweathermap.org/data/2.5/weather?q=Minsk&units=metric&appid=03f07442bb1ee385c3c61ec678db4d9b
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBackGroundView()
        escapeNavigationBar()
        
        let indicatorSize: CGFloat = 70
        let indicatorFrame = CGRect(x: (view.frame.width - indicatorSize/2), y: (view.frame.height - indicatorSize/2), width: indicatorSize, height: indicatorSize)
        activityIndicator = NVActivityIndicatorView(frame: indicatorFrame, type: .lineScale, color: UIColor.white, padding: 20.0)
        activityIndicator.backgroundColor = UIColor.black
        view.addSubview(activityIndicator)
        
        locationManager.requestWhenInUseAuthorization()
        
        activityIndicator.startAnimating()
        if(CLLocationManager.locationServicesEnabled()){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    Alamofire.request("https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&units=metric&appid=\(apiKey)").responseJSON {
        
        response in
        self.activityIndicator.stopAnimating()
        if let responseStr = response.result.value{
            let jsonResponse = JSON(responseStr)
            let jsonWeather = jsonResponse["weather"].array![0]
            let jsonTemp = jsonResponse["main"]
            let iconName = jsonWeather["icon"].stringValue
            
            self.locationLabel.text = jsonResponse["name"].stringValue
            self.conditionImageView.image = UIImage(named: "01d")
            self.conditionLabal.text = jsonWeather["description"].stringValue
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
        
    }
}
