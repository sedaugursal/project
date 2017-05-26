
import UIKit
import Firebase
import FirebaseDatabase

class MenuViewController: BaseViewController {
    
    var refMenuFoods : FIRDatabaseReference?
    var menuFoodList : [MenuFoodModel] = []
    var tableNo : String?

    @IBOutlet weak var menuTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refMenuFoods = FIRDatabase.database().reference().child("Result").child("FoodList")
        self.menuServiceCall()
        
        if UserDefaults.standard.object(forKey: Constant.TABLE_NO) != nil {
            tableNo = UserDefaults.standard.object(forKey: Constant.TABLE_NO) as? String
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
            self.navigationController?.navigationBar.topItem?.title = "Menü"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func menuServiceCall() {
        refMenuFoods?.observe(FIRDataEventType.value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                for menuFoods in snapshot.children.allObjects as! [FIRDataSnapshot] {
                    let menuFoodObject = menuFoods.value as? [String : AnyObject]
                    let displayName = menuFoodObject?["DisplayName"]
                    let price = menuFoodObject?["Price"]
                    let id = menuFoodObject?["ID"]
                    let catID = menuFoodObject?["CatID"]
                    let imageUrl = menuFoodObject?["imageURL"]
                    
                    let food = MenuFoodModel.init(ID: id as! String?, CatID: catID as! String?, DisplayName: displayName as! String?, Price: price as! String?, imageURL: imageUrl as! String?)
                    
                    
                    self.menuFoodList.append(food)
                }
                self.menuTableView.reloadData()
            }
        })
    }
}


extension MenuViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MenuDetailViewController") as! MenuDetailViewController
        //viewController.foodId = menuFoodList[indexPath.row].ID
        //viewController.foodName = menuFoodList[indexPath.row].DisplayName
        viewController.foodModel = menuFoodList[indexPath.row]
        viewController.tableNo = self.tableNo
        print("food : \(menuFoodList[indexPath.row].ID)")
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension MenuViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuFoodList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as UITableViewCell!
        
        if(cell == nil){
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: cellIdentifier)
            //tableView.separatorStyle = .none
        }
        
        cell?.textLabel?.text = menuFoodList[indexPath.row].DisplayName
        cell?.detailTextLabel?.text = menuFoodList[indexPath.row].Price

        return cell!

    }
}
