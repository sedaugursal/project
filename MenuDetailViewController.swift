
import UIKit
import Firebase
import FirebaseDatabase

class MenuDetailViewController: BaseViewController {
    
    var ref : FIRDatabaseReference?
    var refMenuFoodDetail : FIRDatabaseReference?
    //var foodId : String?
    //var foodName : String?
    var foodModel : MenuFoodModel?
    var tableNo : String?
    
    @IBOutlet weak var menuFoodImage: UIImageView!
    @IBOutlet weak var menuFoodAmount: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        refMenuFoodDetail = FIRDatabase.database().reference().child("Result").child("FoodList").child((foodModel?.ID!)!)
        //self.loadFoodDetailServiceCall()
        // Do any additional setup after loading the view.
        self.navigationItem.title = foodModel?.DisplayName
        
        self.loadImage(urlString: (foodModel?.imageURL)!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.backButton.setTitle(" ", for: .normal)
        
    }
    
    
    @IBAction func addToBasketButton(_ sender: Any) {
        self.addBasketServiceCall()
    }
    
    /*func loadFoodDetailServiceCall() {
        refMenuFoodDetail?.observe(FIRDataEventType.value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                for menuFoods in snapshot.children.allObjects as! [FIRDataSnapshot] {
                    let menuFoodObject = menuFoods.value as? [String : AnyObject]
                    let displayName = menuFoodObject?["DisplayName"]
                    let price = menuFoodObject?["Price"]
                    
                    self.foodModel = MenuFoodModel.init(ID: nil, CatID: nil, DisplayName: displayName as! String?, Price: price as! String?, imageURL: nil)
                    
                    //self.menuFoodList.append(food)
                }
                //self.menuTableView.reloadData()
            }
        })
    }*/
    
    func addBasketServiceCall() {

        /*var key = ref?.child("Orders").childByAutoId().key
        self.ref?.child("Result").child("Orders").setValue(["id": key, "tableNo": "2", "foodName": foodModel?.DisplayName, "price": foodModel?.Price])*/
        
        let key = ref?.child("Result").child("Orders").childByAutoId().key
        let food = ["FoodName": (foodModel?.DisplayName)! as String,
                    "Price": (foodModel?.Price)! as String,
                    "Amount": menuFoodAmount.text != nil ? menuFoodAmount.text : "1",
                    "TableNo": tableNo,
                    "IsOrderCompleted": "false"]
        /*let childUpdates = ["Result/Orders/\(key)": food,
                            
                            ] as [String : Any]
        ref?.updateChildValues(childUpdates)*/
        ref?.child("Result").child("Orders").child(key!).setValue(food)
        
        self.alert()
    }
    
    func alert() {
        let okAction = UIAlertAction(title: "Tamam", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
            self.navigationController?.popViewController(animated: true)
        }
        self.showAlert(title: "Uyarı", message: "Sepete Eklendi", actions: [okAction])
    }
    
    func loadImage(urlString:String) {
        
        if let url = NSURL(string: urlString) {
            if let data = NSData(contentsOf: url as URL) {
                self.menuFoodImage.image = UIImage(data: data as Data)
            }        
        }
        
        
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
