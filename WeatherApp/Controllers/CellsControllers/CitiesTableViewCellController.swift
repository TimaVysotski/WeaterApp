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
        cityLabel.text = (city.value(forKey: "location") as! String)
        temperatureLabel.text = "15°C"
        weatherIconImage.image = UIImage(named: "01d")
        self.backgroundColor = UIColor(patternImage: UIImage(named: "01db")!)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cityLabel.text = nil
        temperatureLabel.text = nil
        weatherIconImage.image = nil
        self.backgroundColor = nil
    }
    
}
