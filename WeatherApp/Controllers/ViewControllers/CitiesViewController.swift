import UIKit

class CitiesViewController : UIViewController, UINavigationBarDelegate{
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.delegate = self
        escapeNavigationBar()
        
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addButtinPressed(_ sender: UIBarButtonItem) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        self.present(controller, animated: true, completion: nil)
    }
}

extension CitiesViewController {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.topAttached
    }
    func escapeNavigationBar(){
        self.navigationBar.setBackgroundImage(UIImage(), for:
            UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.navigationBar.backgroundColor = UIColor.clear
    }
}

