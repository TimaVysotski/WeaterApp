import UIKit

struct CellData {
    let cell : Int!
}


class ScrollViewSlide: UIView{
   
    var cellData = [CellData(cell : 1), CellData(cell : 2), CellData(cell : 3), CellData(cell : 4)]
    
    @IBOutlet weak var scrollViewImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var city : City?{
        didSet {
            self.scrollViewImageView.image = (UIImage(named: (city!.value(forKey: Words.backgroundImage) as! String))!)
            self.locationLabel.text = (city!.value(forKey: Words.location) as! String)
            tableView.dataSource = self
            tableView.delegate = self
            tableView.allowsSelection = false
        }
    }
    
}

extension ScrollViewSlide : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      if cellData[indexPath.row].cell == 1{
            let cell = Bundle.main.loadNibNamed("LocationTableViewCell", owner: self, options: nil)?.first as! LocationTableViewCell
            cell.setUpCell(city!)
            cell.translatesAutoresizingMaskIntoConstraints = false
            cell.clipsToBounds = false
        cell.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300)
            NSLayoutConstraint.activate([
                cell.heightAnchor.constraint(equalToConstant: 300),
                cell.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
                ])
        print("---------------------------")
        print(cell.frame)
            return cell
        } else if cellData[indexPath.row].cell == 2{
            let cell = Bundle.main.loadNibNamed("WindTableViewCell", owner: self, options: nil)?.first as! WindTableViewCell
            cell.setUpCell(city!)
            return cell
        } else if cellData[indexPath.row].cell == 3{
            let cell = Bundle.main.loadNibNamed("FeltTemperatureTableViewCell", owner: self, options: nil)?.first as! FeltTemperatureTableViewCell
            cell.setUpCell(city!)
            return cell
        } else if cellData[indexPath.row].cell == 4{
            let cell = Bundle.main.loadNibNamed("WeekDayWeatherTableViewCell", owner: self, options: nil)?.first as! WeekDayWeatherTableViewCell
            cell.setUpCell(city!)
            return cell
        } else {
            let cell = Bundle.main.loadNibNamed("WeekDayWeatherTableViewCell", owner: self, options: nil)?.first as! WeekDayWeatherTableViewCell
            cell.setUpCell(city!)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if cellData[indexPath.row].cell == 1{
            return CGFloat(300)
        } else if cellData[indexPath.row].cell == 2{
            return CGFloat(70)
        } else if cellData[indexPath.row].cell == 3{
            return CGFloat(70)
        } else if cellData[indexPath.row].cell == 4{
            return CGFloat(260)
        } else {
            return CGFloat(0)
        }
    }
}
