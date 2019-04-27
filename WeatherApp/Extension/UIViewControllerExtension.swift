import UIKit

extension UIViewController{
    func fetchRequest(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            let resault = try context.fetch(City.fetchRequest())
            cities = resault as! [City]
        } catch let error as NSError {
            print("Could not save\(error), \(error.userInfo)")
        }
    }
    func escapeToolBar(_ toolBar : UIToolbar){
        toolBar.setBackgroundImage(UIImage(), forToolbarPosition: UIBarPosition.any, barMetrics: UIBarMetrics.default)
    }
    
}
