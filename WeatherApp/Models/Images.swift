import UIKit


extension UIImage {
    enum Images : String{
        case LightBackground = "LightBackground"
        case BlueBackground = "BlueBackground"
    }
    convenience init!(image : Images){
        self.init(named: image.rawValue)
    }
}
