import Foundation
import UIKit

var weather = CurrentWeather()

class TestViewController : UIViewController {
    
    @IBOutlet weak var testLabel: UILabel!
    
    let city : String = "Minsk"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ForecastService.shared.getCurrentWeather(city, weather){ [weak self] weather in
            DispatchQueue.main.async {
                self?.testLabel.text = weather.location
            }
        }
    }
}
