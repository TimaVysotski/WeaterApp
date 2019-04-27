import UIKit
import CoreData
import Alamofire
import SwiftyJSON
import CoreLocation

var cities = [City]()

class CurrnetWeatherViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
   
    @IBOutlet weak var horizontalCollectionView: UICollectionView!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var pageControll: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        escapeToolBar(toolBar)
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
    @IBAction func weatherButtonPressed(_ sender: UIBarButtonItem) {
       // checkLocation()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle  {
        return .lightContent
    }    
}



// MARK -- CollectionView

extension CurrnetWeatherViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height + 80
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.pageControll.numberOfPages = cities.count
        return cities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalCollectionViewCell", for: indexPath) as! HorizontalCollectionViewCell
        let city = cities[indexPath.row]
        cell.setUpCell(city)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControll.currentPage = indexPath.row
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

//
//    func forecastWeather(){
//        ForecastService.shared.getCurrentWeather(cityName){ [weak self] text in
//            DispatchQueue.main.async {
//                let backgroundImage = UIImage(named: "\(text)b")
//                self?.view.layer.contents = backgroundImage?.cgImage
//            }
//        }
//    }


// MARK -- LocationManager
//
//extension CurrnetWeatherViewController : CLLocationManagerDelegate {
//    func startLocationManager(){
//        if CLLocationManager.locationServicesEnabled(){
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyBest
//            locationManager.startUpdatingLocation()
//            isUpdatingLocation = true
//        }
//    }
//
//    func stopLocationManager(){
//        if isUpdatingLocation{
//            locationManager.stopUpdatingLocation()
//            locationManager.delegate = nil
//            isUpdatingLocation = false
//        }
//    }
//
//    func checkLocation(){
//        let autorizationStatus = CLLocationManager.authorizationStatus()
//        if autorizationStatus == .notDetermined {
//            locationManager.requestWhenInUseAuthorization()
//            return
//        }
//
//        if isUpdatingLocation {
//            stopLocationManager()
//        } else {
//            location = nil
//            lastLocationError = nil
//            startLocationManager()
//        }
//
//
//        if autorizationStatus == .denied || autorizationStatus == .restricted {
//            reportLocationServicesDeniedError()
//            return
//        }
//    }
//
//    func reportLocationServicesDeniedError(){
//        let alert = UIAlertController(title: "Location Services Disabled", message: "Please go to Settings > Privacy to enable location services for this app", preferredStyle: .alert)
//        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
//        alert.addAction(okButton)
//        present(alert, animated: true, completion: nil)
//    }
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("Error")
//        if (error as NSError).code == CLError.locationUnknown.rawValue{
//            return
//        }
//        lastLocationError = error
//        stopLocationManager()
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        location = locations.last!
//        print("")
//        stopLocationManager()
//        CitiesService.shared.getSelfLocation((location?.coordinate.latitude)!, (location?.coordinate.latitude)!){ [weak self] selfLocation in
//            DispatchQueue.main.async {
//                print(selfLocation)
//            }
//        }
//    }
//
//}
