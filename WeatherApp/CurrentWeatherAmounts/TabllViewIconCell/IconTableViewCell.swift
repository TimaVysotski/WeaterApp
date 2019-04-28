import UIKit

class IconTableViewCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setUpCell(_ city : City){
        
         self.iconImageView.image = (UIImage(named: (city.value(forKey: Words.icon) as! String))!)
    }
    
}
