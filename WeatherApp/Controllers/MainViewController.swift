import UIKit

class MainViewController : UIViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBackground()
    }
    
    
    
    func setUpBackground(){
        self.view.backgroundColor = UIColor(patternImage: UIImage(image: .LightBackground))
    }
}
