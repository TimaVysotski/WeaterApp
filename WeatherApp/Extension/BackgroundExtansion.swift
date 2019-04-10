import UIKit

extension UIViewController {
    func setUpBackGroundView(){
        let backGroundImage : UIImage =  UIImage(image: .lightBackground)
        return self.view.layer.contents = backGroundImage.cgImage
    }
}
