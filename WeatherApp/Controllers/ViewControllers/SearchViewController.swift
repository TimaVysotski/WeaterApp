import UIKit

protocol SearchViewControllerDelegate : AnyObject{
    func addCity(_ city : String)
}


class SearchViewController : UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    
    private var cityList = [String]()
    private var requiredCity = [String]()
    private var cityIsFound = false
    
    weak var delegate : SearchViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deleteSeparateLine()
        readCityList()
        searchBar.becomeFirstResponder()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle  {
        return .lightContent
    }
    
    func readCityList(){
        CitiesService.shared.getCurrentCity(){ [weak self] cities in
            DispatchQueue.main.async {
                self?.cityList = cities
            }
        }
    }
}

extension SearchViewController : UITableViewDelegate, UITableViewDataSource {
    func deleteSeparateLine(){
        self.tableView.separatorStyle = .none
    }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cityName = requiredCity[indexPath.row].replacingOccurrences(of: " ", with: "%20")
        delegate?.addCity(cityName)
        self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
}

extension SearchViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        CitiesService.shared.getCityPrefix(cityList, searchText){  [weak self] foundCities in
            DispatchQueue.main.async {
                 self?.requiredCity = foundCities
                 self?.cityIsFound = true
                 self?.tableView.reloadData()
            }
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
}
