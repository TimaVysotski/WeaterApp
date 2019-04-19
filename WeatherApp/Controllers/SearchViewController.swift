import UIKit

class SearchViewController : UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    
    private var city : [String] = ["Minsk", "Moscow", "London"]
    private var requiredCity = [String]()
    private var cityIsFound = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


extension SearchViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cityIsFound{
            return requiredCity.count
        } else {
            return city.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCellController else {
            return UITableViewCell()
        }
        if cityIsFound{
            cell.setUpCell(city: requiredCity[indexPath.row])
        } else {
            cell.setUpCell(city: city[indexPath.row])
        }
    return cell
    }
    
}

extension SearchViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        requiredCity = city.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        cityIsFound = true
        tableView.reloadData()
    }

}

