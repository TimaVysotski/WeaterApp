import UIKit

class SearchViewController : UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    
    private var cityList = [String]()
    private var requiredCity = [String]()
    private var cityIsFound = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readCityList()
    }

    func readCityList(){
        ForecastService.shared.getCurrentCity(){ [weak self] cities in
            DispatchQueue.main.async {
                self?.cityList = cities
            }
        }
    }
}


extension SearchViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cityIsFound{
            return requiredCity.count
        } else {
            return cityList.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCellController else {
            return UITableViewCell()
        }
        if cityIsFound{
            cell.setUpCell(city: requiredCity[indexPath.row])
        } else {
            cell.setUpCell(city: cityList[indexPath.row])
        }
    return cell
    }
    
}

extension SearchViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        ForecastService.shared.getCityPrefix(cityList, searchText){  [weak self] foundCities in
            DispatchQueue.main.async {
                 self?.requiredCity = foundCities
                 self?.cityIsFound = true
                 self?.tableView.reloadData()
            }
        }
    }
}

//func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//    requiredCity = cityList.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
//    cityIsFound = true
//    tableView.reloadData()
//}
