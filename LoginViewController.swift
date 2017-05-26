
import UIKit
import Firebase
import FirebaseDatabase

class LoginViewController: BaseViewController {
    
    var usernamesArray : [String] = []
    
    
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    
    
    var ref : FIRDatabaseReference = FIRDatabaseReference()
    
    var dbRef : FIRDatabaseReference = FIRDatabaseReference()
    var userRef : FIRDatabaseReference = FIRDatabaseReference()
    
    var handleDatabase : FIRDatabaseHandle = FIRDatabaseHandle()
    
    var postData = [String]()
    
    //var actualPost : String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Giriş"
        self.backButton.setTitle(" ", for: .normal)
        
    }

    //SERVICE CALLS
    func loginServiceCall(username : String, password : String) {
        
    }
    
    //ACTIONS
    @IBAction func signUpButtonAction(_ sender: Any) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        //self.present(viewController, animated: true, completion: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @IBAction func loginButtonAction(_ sender: Any) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
