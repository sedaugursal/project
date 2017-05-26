
import UIKit
import Firebase


class RegisterViewController: BaseViewController {

    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var usernameTextfield: UITextField!
    
    var ref : FIRDatabaseReference = FIRDatabaseReference()
    
    //var imageView : UIImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.hideKeyboardWhenTappedAround()
        
        self.usernameTextfield.tag = 10101
        self.passwordTextfield.tag = 10102
        self.emailTextfield.tag = 10103
        
        self.usernameTextfield.delegate = self
        self.passwordTextfield.delegate = self
        self.emailTextfield.delegate = self
        
        //self.navigationController?.navigationItem.title = "Üye ol"

        //self.navigationItem.title = "Üye ol"
        //self.backButton.isHidden = true
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Üye ol"
        self.backButton.setTitle(" ", for: .normal)
        
    }
    
    

    @IBAction func signUpButton(_ sender: Any) {

    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        self.view.endEditing(true)
        //scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RegisterViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag > 0 {
            textField.resignFirstResponder()
            return true
        } else {
            return false
        }
        
    }
}
