import UIKit

extension UIImage {
    enum Images : String{
        case lightBackground = "LightBackground"
        case blueBackground = "BlueBackground"
        case skyTest = "testSky"
    }
    convenience init!(image : Images){
        self.init(named: image.rawValue)
    }
}
