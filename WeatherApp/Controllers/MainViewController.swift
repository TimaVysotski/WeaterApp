import UIKit

class MainViewController : UIViewController {
   
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBackGround()
        setUpNB()
    }
    
}






extension UIViewController {
    func setUpBackGround(){
        let backGroundImage : UIImage =  UIImage(image: .LightBackground)
          return self.view.layer.contents = backGroundImage.cgImage
    }
    func setUpNB(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }
}
