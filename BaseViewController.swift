
import UIKit

class BaseViewController : UIViewController{
    
    typealias CompletionBlock = (_ succeed : Bool)->()
    var completionBlock : CompletionBlock?
    
    let BACK_BUTTON_TAG =  101
    let BACK_IMAGE_TAG =  102
    var backImageView : UIImageView = UIImageView()
    var backButton: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.tintColor = UIColor(red:0.72, green:0.63, blue:0.42, alpha:1)
        
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor(red:0.17, green:0.18, blue:0.22, alpha:1)
        //self.navigationController?.navigationBar.translucent = false
        //self.navigationController.navigationBar.navigationItem.leftBarButtonItem.title = @"";
        self.navigationItem.backBarButtonItem?.title = "";
        
        self.navigationController?.interactivePopGestureRecognizer!.delegate = self
        self.navigationController?.interactivePopGestureRecognizer!.isEnabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.addBackButton()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.viewWithTag(BACK_BUTTON_TAG)?.removeFromSuperview()
        self.navigationController?.navigationBar.viewWithTag(BACK_IMAGE_TAG)?.removeFromSuperview()
        
    }
    
    func addBackButton(){
        
        //backImageView = UIImageView(frame: CGRectMake(10, 13, 11, 19.5))
        backImageView.frame = CGRect(x: 10, y: 13, width: 11, height: 19.5)
        backImageView.image = UIImage(named: "back")
        backImageView.tag = BACK_IMAGE_TAG
        self.navigationController?.navigationBar.addSubview(backImageView)
        
        //backButton = UIButton(frame: CGRectMake(0, 0, 100, 44))
        backButton.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
        backButton.setTitle("", for: UIControlState.normal)
        backButton.tag = BACK_BUTTON_TAG
        //backButton.imageEdgeInsets = UIEdgeInsetsMake(10, -50, 10, 0)
        //backButton.setImage(UIImage(named: "back"), forState: .Normal)
        backButton.setTitleColor(UIColor.black, for: .normal)
        backButton.addTarget(self, action: #selector(self.backButtonClicked), for: UIControlEvents.touchUpInside)
        self.navigationController?.navigationBar.addSubview(backButton)
        
    }
    
    func backButtonClicked(sender : AnyObject){
        self.navigationController?.popViewController(animated: true)
    }
    
    func performLoginNeedOperation(operation:@escaping (_ loginStatusChanged : Bool, _ isUserLogin : Bool)->()){
        if UserDefaults.value(forKey: Constant.IS_USER_LOGIN) != nil && UserDefaults.value(forKey: Constant.IS_USER_LOGIN) as! Bool == true {
            operation(false, true)
        }else{
            self.showLoginWithCompletion(completion: { (succeed) in
                if succeed == true{
                    operation(true, true)
                }else{
                    operation(false, false)
                }
            })
        }
    }
    
    func showLoginWithCompletion(completion:@escaping (_ succeed : Bool)->()){
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        viewController.completionBlock = completion
        
        let navigationController : UINavigationController = UINavigationController.init(rootViewController: viewController)
        self.present(navigationController, animated: false, completion: nil)
        
        
    }
    
    func dismissNavigationController(){
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
        /*let tabbarController = self.storyboard!.instantiateViewControllerWithIdentifier("BeymenTabBarController") as! BeymenTabBarController
         let navController = UINavigationController(rootViewController: tabbarController)
         tabbarController.selectedIndex = 2
         UIApplication.sharedApplication().delegate?.window!!.rootViewController = navController*/
    }
    
    func showAlert(title: String, message: String, actions: [UIAlertAction]?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        if actions == nil {
            alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertActionStyle.default, handler: nil))
        } else {
            for action in actions! {
                alert.addAction(action)
            }
        }
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    /*func sendScreenName(screenName : String) {
        let tracker = GAI.sharedInstance().defaultTracker
        /* tracker.set("kGAIScreenName", value: screenName)
         let builder = GAIDictionaryBuilder.createScreenView()
         tracker.send(builder.build() as [NSObject : AnyObject])*/
        self.screenName = screenName
        // tracker.set(kGAIScreenName, value: screenName)
        //  tracker.sendView(screenName)
    }*/
    
    
}

extension BaseViewController : UIGestureRecognizerDelegate{
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
