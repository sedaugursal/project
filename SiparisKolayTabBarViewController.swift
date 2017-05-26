
import UIKit

class SiparisKolayTabBarViewController: UITabBarController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}

extension SiparisKolayTabBarViewController : UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        selectedIndex = tabBarController.selectedIndex
        //setTabItems()
        if UserDefaults().object(forKey: Constant.IS_USER_LOGIN) != nil && UserDefaults().object(forKey: Constant.IS_USER_LOGIN) as! Bool == true{
            
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        //Logger.debug("tabBarController.selectedIndex \(viewController)")
        print("tabBarController.selectedIndex \(viewController)")
        /*if viewController is ProfileViewController{
            (viewController as! BaseViewController).performLoginNeedOperation(operation: { (loginStatusChanged, isUserLogin) in
                //Logger.debug("loginStatusChanged \(loginStatusChanged) isUserLogin : \(isUserLogin)")
                print("loginStatusChanged \(loginStatusChanged) isUserLogin : \(isUserLogin)")
                if isUserLogin == true{
                    self.selectedViewController = viewController
                }
            })
            return false
        }else{
            return true
        }*/
        
        return true
        
        
        
    }
}
