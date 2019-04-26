import UIKit
import CoreData


class CitiesViewController : UIViewController, UINavigationBarDelegate{
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
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



extension CitiesViewController : UITableViewDelegate, UITableViewDataSource, SearchViewControllerDelegate{
    func separateLine(){
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
        ForecastService.shared.getCurrentWeather(city){ [weak self] cityWeather in
            DispatchQueue.main.async {
                self?.saveCity(cityWeather)
                self?.tableView.reloadData()
            }
        }
    }
    
    func saveCity(_ cityWeather : [String : String]){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let city = City(entity: City.entity(), insertInto: context)
        saveCurrentCity(city, cityWeather)
        do{
            try context.save()
            cities.append(city)
        } catch let error as NSError {
            print("Could not save\(error), \(error.userInfo)")
        }
    }
    
//    func fetchRequest(){
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//
//        do {
//            let resault = try context.fetch(City.fetchRequest())
//            cities = resault as! [City]
//        } catch let error as NSError {
//            print("Could not save\(error), \(error.userInfo)")
//        }
//    }
    
    func saveCurrentCity(_ city : City,_ cityWeather : [String : String]){
        city.setValue(cityWeather[Weather.location], forKey: Weather.location)
        city.setValue(cityWeather[Weather.temperature], forKey: Weather.temperature)
        city.setValue(cityWeather[Weather.icon], forKey: Weather.icon)
        city.setValue(cityWeather[Weather.backgroundImage], forKey: Weather.backgroundImage)
    }
}
