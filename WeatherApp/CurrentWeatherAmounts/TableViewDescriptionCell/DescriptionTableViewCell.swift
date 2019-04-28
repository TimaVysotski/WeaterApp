import UIKit

class DescriptionTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setUpCell(_ city : City){
        
        self.descriptionLabel.text = (city.value(forKey: Words.descriptionToday) as! String)
    }
    
}
