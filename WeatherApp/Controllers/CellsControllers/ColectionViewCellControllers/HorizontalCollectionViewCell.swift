import UIKit

class HorizontalCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    func setUpCell(_ city : City){
       // locationLabel.text = (city.value(forKey: Weather.location) as! String)
     //   temperatureLabel.text = (city.value(forKey: Weather.temperature) as! String)
      //  iconImageView.image = UIImage(named: ((city.value(forKey: Weather.icon) as! String)))
       self.backgroundColor = UIColor(patternImage: UIImage(named: (city.value(forKey: Words.backgroundImage) as! String))!)
        
    }
}
