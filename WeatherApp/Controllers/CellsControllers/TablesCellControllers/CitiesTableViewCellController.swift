import UIKit

class CitiesTableViewCellController : UITableViewCell {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIconImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpCell(_ city : City){
       cityLabel.text = (city.value(forKey: Weather.location) as! String)
       temperatureLabel.text = (city.value(forKey: Weather.temperature) as! String)
       weatherIconImage.image = UIImage(named: (city.value(forKey: Weather.icon) as! String))
       self.backgroundColor = UIColor(patternImage: UIImage(named: (city.value(forKey: Weather.backgroundImage) as! String))!)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cityLabel.text = nil
        temperatureLabel.text = nil
        weatherIconImage.image = nil
        self.backgroundColor = nil
    }
    
}
