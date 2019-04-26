import UIKit
import CoreData
import Alamofire
import SwiftyJSON

var cities = [City]()

class CurrnetWeatherViewController : UIViewController, UINavigationBarDelegate, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
   
    
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var horizontalCollectionView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRequest()
        horizontalCollectionView.reloadData()
    }
    @IBAction func menuButtonPressed(_ sender: UIBarButtonItem) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "CitiesViewController") as! CitiesViewController
        self.present(controller, animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle  {
        return .lightContent
    }
    

}

extension CurrnetWeatherViewController {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        escapeNavigationBar()
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

extension CurrnetWeatherViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height + 35
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalCollectionViewCell", for: indexPath) as! HorizontalCollectionViewCell
        let city = cities[indexPath.row]
        cell.setUpCell(city)
        return cell
    }
}

extension UIViewController {
    func fetchRequest(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            let resault = try context.fetch(City.fetchRequest())
            cities = resault as! [City]
        } catch let error as NSError {
            print("Could not save\(error), \(error.userInfo)")
        }
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
