
import UIKit
import Firebase
import FirebaseDatabase

class CheckViewController: BaseViewController {
    
    var ref : FIRDatabaseReference?
    var refLoadOrdersTable : FIRDatabaseReference?
    var getOrdersArray : [OrderModel] = []
    var loadOrdersArray : [OrderModel] = []
    var tableNoArray : [String] = []
    var currentTableNo : String?
    var loadOrdersTableView : UITableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.object(forKey: Constant.TABLE_NO) != nil {
            currentTableNo = UserDefaults.standard.object(forKey: Constant.TABLE_NO) as? String
        }
        
        ref = FIRDatabase.database().reference()
        refLoadOrdersTable = FIRDatabase.database().reference().child("Result").child("SubmittedOrders")

        loadOrdersTableView.frame = CGRect(x: 5, y: 64, width: UIScreen.main.bounds.size.width - 10, height: UIScreen.main.bounds.size.height - 200)
        loadOrdersTableView.delegate = self
        loadOrdersTableView.dataSource = self
        self.view.addSubview(loadOrdersTableView)
        
        self.loadCheckServiceCall()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Hesap"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationItem.title = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadCheckServiceCall() {
        refLoadOrdersTable?.observe(FIRDataEventType.value, with: { (snapshot) in
            print("children : \(snapshot.childrenCount)")
            self.loadOrdersArray.removeAll()
            if snapshot.childrenCount > 0 {
                for loadOrder in snapshot.children.allObjects as! [FIRDataSnapshot] {
                    let loadOrderTable = loadOrder.value as? [String : AnyObject]
                    
                    //let displayName = menuFoodObject?["DisplayName"]
                    let amount = loadOrderTable?["Amount"]
                    let foodName = loadOrderTable?["FoodName"]
                    
                    let price = loadOrderTable?["Price"]
                    let tableNo = loadOrderTable?["TableNo"]
                    let isOrderCompleted = loadOrderTable?["IsOrderCompleted"]
                    
                    
                    let order = OrderModel.init(Amount: amount as! String?, FoodName: foodName as! String?, Price: price as! String?, TableNo: tableNo as! String?, IsOrderCompleted: isOrderCompleted as! String?)
                    
                    self.loadOrdersArray.append(order)
                    self.tableNoArray.append(order.TableNo!)
                    
                    
                    print("order : \(order.FoodName)")
                    //self.emptyTables.append(order.TableNo!)
                }
                self.checkTableNoAndOrderComplete(tableNoAndOrderCompleteArr: self.loadOrdersArray)
                //self.loadOrdersTableView.reloadData()
                
            }
        })
    }
    
    func checkTableNoAndOrderComplete(tableNoAndOrderCompleteArr : [OrderModel]) {
        self.getOrdersArray.removeAll()
        for index in 0...tableNoAndOrderCompleteArr.count - 1 {
            print("currentTableNo is : \(currentTableNo)")
            if currentTableNo! == tableNoAndOrderCompleteArr[index].TableNo {
                if !self.getOrdersArray.contains(tableNoAndOrderCompleteArr[index]) {
                    self.getOrdersArray.append(tableNoAndOrderCompleteArr[index])
                }
            }
        }
        self.loadOrdersTableView.reloadData()
    }
    
    func deleteBasketServiceCall() {
        ref?.child("Result").child("SubmittedOrders").removeValue()
        self.getOrdersArray.removeAll()
        self.loadOrdersTableView.reloadData()
    }
    
    func alert() {
        let okAction = UIAlertAction(title: "Tamam", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
            self.navigationController?.popViewController(animated: true)
        }
        self.showAlert(title: "Uyarı", message: "Ödeme Gerçekleşti", actions: [okAction])
    }
    
    //ACTIONS
    
    @IBAction func payButton(_ sender: Any) {
        self.deleteBasketServiceCall()
        self.alert()
        //self.loadOrdersTableView.reloadData()
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

extension CheckViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension CheckViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getOrdersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as UITableViewCell!
        
        if(cell == nil){
            cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: cellIdentifier)
            //tableView.separatorStyle = .none
        }
        
        
        
        cell?.textLabel?.text = getOrdersArray[indexPath.row].FoodName
        cell?.detailTextLabel?.text = getOrdersArray[indexPath.row].Price
        
        
        return cell!
        
    }
}
