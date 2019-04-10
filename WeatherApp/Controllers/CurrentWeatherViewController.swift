import UIKit

class CurrnetWeatherViewController : UIViewController {
   
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    @IBOutlet weak var cityTextLabel: UILabel!
    @IBOutlet weak var temperatureTextLabel: UILabel!
    @IBOutlet weak var temperatureScaleTextLabel: UILabel!
   
    let forecastAPIKey = "5525af52c6a9c118cb1c1b4694711b0f"
    let coordinate: (lat: Double, long: Double) = (37.8267,-122.4233)
    var forecastService: ForecastService!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBackGroundView()
        escapeNavigationBar()
        
        forecastService = ForecastService(APIKey: forecastAPIKey)
        forecastService.getCurrentWeather(latitude: coordinate.lat, longitude: coordinate.long) { (currentWeather) in
            if let currentWeather = currentWeather{
                DispatchQueue.main.async {
                    if let temperature = currentWeather.temperature{
                        self.temperatureScaleTextLabel.text = "\(temperature)°"
                    } else {
                        self.temperatureScaleTextLabel.text = "False"
                    }
                }
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
