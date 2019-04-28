import UIKit
import CoreData


class CitiesViewController : UIViewController, UINavigationBarDelegate{
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    
    var weather = CurrentWeather()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        deleteSeparateLine()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRequest()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle  {
        return .lightContent
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func addButtinPressed(_ sender: UIBarButtonItem) {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else {
            return
        }
        controller.delegate = self
        self.present(controller, animated: true, completion: nil)
    }
    
    func reloadData(_ city: City){
        
    }
    
}



extension CitiesViewController {
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



extension CitiesViewController : UITableViewDelegate, UITableViewDataSource, SearchViewControllerDelegate, SelfLocationDelegate
{

    func deleteSeparateLine(){
        self.tableView.separatorStyle = .none
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CitiesTableViewCell", for: indexPath) as? CitiesTableViewCellController else {
            return UITableViewCell()
        }
        let city = cities[indexPath.row]
        cell.setUpCell(city)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        if editingStyle == .delete{
            context.delete(cities[indexPath.row])
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do{
               cities = try context.fetch(City.fetchRequest())
            } catch let error as NSError {
                print("Could not save\(error), \(error.userInfo)")
            }
            //tableView.reloadData()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func addCity(_ city: String) {
        ForecastService.shared.getCurrentWeather(city, weather){ [weak self] weather in
            DispatchQueue.main.async {
                ForecastService.shared.getWeekWeather(city, weather){ [weak self] weather in
                    DispatchQueue.main.async {
                        self?.saveCity(weather)
                        self?.tableView.reloadData()
                    }
                }
            }
        }
    }
    func addSelfLocation(_ city: String) {
        ForecastService.shared.getCurrentWeather(city, weather){ [weak self] weather in
            DispatchQueue.main.async {
                ForecastService.shared.getWeekWeather(city, weather){ [weak self] weather in
                    DispatchQueue.main.async {
                        self?.saveCity(weather)
                        self?.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    func saveCity(_ weather : CurrentWeather){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let city = City(entity: City.entity(), insertInto: context)
        saveCurrentCity(city, weather)
        saveCurrentWeather(city, weather)
        do{
            try context.save()
            cities.append(city)
        } catch let error as NSError {
            print("Could not save\(error), \(error.userInfo)")
        }
    }
    
    
    func saveCurrentCity(_ city : City,_ weather : CurrentWeather){
        city.setValue(weather.location, forKey: Words.location)
        city.setValue(weather.temperatureToday, forKey: Words.temperature)
        city.setValue(weather.iconToday, forKey: Words.icon)
        city.setValue(weather.backgroundImage, forKey: Words.backgroundImage)
        city.setValue(weather.descriptionToday, forKey: Words.descriptionToday)
        city.setValue(weather.feltTemperature, forKey: Words.feltTemperature)
    }
    
    func saveCurrentWeather(_ city : City,_ weather : CurrentWeather){
        city.setValue(weather.windDirection, forKey: Words.windDirection)
        city.setValue(weather.windSpeed, forKey: Words.windSpeed)
        city.setValue(weather.firstDayName, forKey: Words.firstDayName)
        city.setValue(weather.fifthDayTemperature, forKey: Words.firstDayTemperature)
        city.setValue(weather.firstDayIcon, forKey: Words.firstDayIcon)
        city.setValue(weather.secondDayName, forKey: Words.secondDayName)
        city.setValue(weather.secondDayTemperature, forKey: Words.secondDayTemperature)
        city.setValue(weather.secondDayIcon, forKey: Words.secondDayIcon)
        city.setValue(weather.thirdDayName, forKey: Words.thirdDayName)
        city.setValue(weather.thirdDayTemperature, forKey: Words.thirdDayTemperature)
        city.setValue(weather.thirdDayIcon, forKey: Words.thirdDayIcon)
        city.setValue(weather.fourthDayName, forKey: Words.fourthDayName)
        city.setValue(weather.fourthDayTemperature, forKey: Words.fourthDayTemperature)
        city.setValue(weather.fourthayIcon, forKey: Words.fourthDayIcon)
        city.setValue(weather.firstDayName, forKey: Words.fifthDayName)
        city.setValue(weather.fifthDayTemperature, forKey: Words.fifthDayTemperature)
        city.setValue(weather.fifthDayIcon, forKey: Words.fifthDayIcon)
    }
}
