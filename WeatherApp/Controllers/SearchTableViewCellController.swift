import UIKit

class SearchTableViewCellController : UITableViewCell {
    
    @IBOutlet weak var cellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpCell(city : String){
        cellLabel.text = city
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellLabel.text = nil
    }
    
}
