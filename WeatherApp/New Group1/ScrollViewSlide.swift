
import UIKit

class ScrollViewSlide: UIView {
    @IBOutlet weak var scrollViewImageView: UIImageView!
    
    func setUpScrollViewSlide(_ city : City){
         self.scrollViewImageView.image = (UIImage(named: (city.value(forKey: Words.backgroundImage) as! String))!)
    }
}
