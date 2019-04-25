import UIKit
import CoreData
import Alamofire
import SwiftyJSON
import CoreLocation


class CurrnetWeatherViewController : UIViewController, UINavigationBarDelegate, UIScrollViewDelegate, CLLocationManagerDelegate{
   
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var scrollView: UIScrollView!
    

    
    //let locationManager = CLLocationManager()
    
    let coordinate:(lat: Double, lon: Double) = (53.9167,27.55)
    var cityName = "Minsk"
    var cities : [String] = ["Minsk", "Poland", "Moscow"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.delegate = self
        setupScrollView()
        escapeNavigationBar()
        // startingLocationManager()
    }
    
    func setupScrollView(){
        for index in 0..<cities.count{
            let imageView = UIImageView()
            imageView.image = UIImage(named: "0\(index + 1)db")
            let xPosition = self.view.frame.width * CGFloat(index)
            imageView.frame = CGRect(x: xPosition, y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height)

            scrollView.contentSize.width = self.view.frame.width * CGFloat(cities.count)
            scrollView.addSubview(imageView)
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "0\(index + 1)db")!)
        }
    }
    
    @IBAction func menuButtonPressed(_ sender: UIBarButtonItem) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "CitiesViewController") as! CitiesViewController
        self.present(controller, animated: true, completion: nil)
    }
    
}

extension CurrnetWeatherViewController {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.topAttached
    }
    func escapeNavigationBar(){
        self.navigationBar.setBackgroundImage(UIImage(), for:
            UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.navigationBar.backgroundColor = UIColor.clear
    }
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
//    func forecastWeather(){
//        ForecastService.shared.getCurrentWeather(cityName){ [weak self] text in
//            DispatchQueue.main.async {
//                let backgroundImage = UIImage(named: "\(text)b")
//                self?.view.layer.contents = backgroundImage?.cgImage
//            }
//        }
//    }
