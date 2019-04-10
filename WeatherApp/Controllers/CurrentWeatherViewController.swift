import UIKit

class CurrnetWeatherViewController : UIViewController {
   
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    @IBOutlet weak var cityTextLabel: UILabel!
    @IBOutlet weak var temperatureTextLabel: UILabel!
    @IBOutlet weak var temperatureScaleTextLabel: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBackGroundView()
        escapeNavigationBar()
        
    }
    
}

extension UIViewController {
    func setUpBackGroundView(){
        let backGroundImage : UIImage =  UIImage(image: .lightBackground)
        return self.view.layer.contents = backGroundImage.cgImage
    }
}
