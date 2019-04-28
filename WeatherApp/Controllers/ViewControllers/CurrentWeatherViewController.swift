import UIKit
import CoreData
import Alamofire
import SwiftyJSON
import CoreLocation

var cities = [City]()

protocol SelfLocationDelegate : AnyObject{
    func addSelfLocation(_ city : String)
}

class CurrnetWeatherViewController : UIViewController{

    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    weak var delegate: SelfLocationDelegate?
    
    let locationManager = CLLocationManager()
    var location: CLLocation?
    var isUpdatingLocation = false
    var lastLocationError: Error?
    

    
    override var preferredStatusBarStyle: UIStatusBarStyle  {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRequest()
        launchScrollView()
    }
    
    func launchScrollView(){
        let slides: [ScrollViewSlide] = createSlidesForScrollView()
        setUpScrollViewSlides(slides)
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
    }
    
    func createSlidesForScrollView() -> [ScrollViewSlide]{
        var slides = [ScrollViewSlide]()
        for index in 0..<cities.count{
            let slide : ScrollViewSlide = Bundle.main.loadNibNamed("ScrollViewSlideView", owner: self, options: nil)?.first as! ScrollViewSlide
            slide.city = cities[index]
            slides.append(slide)
        }
        return slides
    }
    
    func setUpScrollViewSlides(_ slides : [ScrollViewSlide]){
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for index in 0..<slides.count{
            slides[index].frame = CGRect(x: view.frame.width * CGFloat(index), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[index])
        }
        
    }
    
   func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
    print(pageIndex)
        pageControl.currentPage = Int(pageIndex)
    }
    
    @IBAction func menuButtonPressed(_ sender: UIButton) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "CitiesViewController") as! CitiesViewController
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func locationButtonPressed(_ sender: Any) {
       checkLocation()
    }
    
    func checkLocation(){
        let autorizationStatus = CLLocationManager.authorizationStatus()
        if autorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        
        if isUpdatingLocation {
            stopLocationManager()
        } else {
            location = nil
            lastLocationError = nil
            startLocationManager()
        }
        
        
        if autorizationStatus == .denied || autorizationStatus == .restricted {
            reportLocationServicesDeniedError()
            return
        }
    }
    
    func startLocationManager(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.startUpdatingLocation()
            isUpdatingLocation = true
        }
    }
    
    func stopLocationManager(){
        if isUpdatingLocation{
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            isUpdatingLocation = false
        }
    }
    func reportLocationServicesDeniedError(){
        let alert = UIAlertController(title: "Location Services Disabled", message: "Please go to Settings > Privacy to enable location services for this app", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
}

extension CurrnetWeatherViewController : CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error---\(error)")
        if (error as NSError).code == CLError.locationUnknown.rawValue{
            return
        }
        lastLocationError = error
        stopLocationManager()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last!
        print("-------------------")
        print((location?.coordinate.latitude)!)
        print((location?.coordinate.longitude)!)
    CitiesService.shared.getSelfLocation((location?.coordinate.latitude)!, (location?.coordinate.longitude)!){ [weak self] cityName in
            DispatchQueue.main.async {
               print(cityName)
            }
    }
    stopLocationManager()
    }

}
