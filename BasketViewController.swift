
import UIKit
import Firebase
import FirebaseDatabase

class BasketViewController: BaseViewController {
    
    
    @IBOutlet weak var completeOrder: UIButton!
    
    var refCheckEmptyTable : FIRDatabaseReference?
    var refLoadOrdersTable : FIRDatabaseReference?
    var ref : FIRDatabaseReference?
    var emptyTables : [String] = []
    var emptyArray = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"]
    var loadOrdersArray : [OrderModel] = []
    var tableNoArray : [String] = []
    var getOrdersArray : [OrderModel] = []
    var currentTableNo : String?
    var loadOrdersTableView : UITableView = UITableView()
    
    var chooseTablePopoup : ChooseTablePopupView = ChooseTablePopupView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UserDefaults.standard.removeObject(forKey: Constant.TABLE_NO)
        print("UserDefaults.standard.object(forKey: Constant.TABLE_NO) : \(UserDefaults.standard.object(forKey: Constant.TABLE_NO))")
        //currentTableNo = UserDefaults.standard.object(forKey: Constant.TABLE_NO) != nil ?UserDefaults.standard.object(forKey: Constant.TABLE_NO) as! String? : "1"
        chooseTablePopoup.frame = CGRect(x:10, y:50, width: UIScreen.main.bounds.size.width - 20, height: 200)
        chooseTablePopoup.delegate = self
        
        refCheckEmptyTable = FIRDatabase.database().reference().child("Result").child("Orders")
        refLoadOrdersTable = FIRDatabase.database().reference().child("Result").child("Orders")
        ref = FIRDatabase.database().reference()
        self.checkEmptyTableServiceCall()
        self.view.addSubview(chooseTablePopoup)
        
        loadOrdersTableView.frame = CGRect(x: 5, y: 64, width: UIScreen.main.bounds.size.width - 10, height: UIScreen.main.bounds.size.height - 200)
        loadOrdersTableView.delegate = self
        loadOrdersTableView.dataSource = self
        self.view.addSubview(loadOrdersTableView)
        
        completeOrder.layer.borderWidth = 1.5
        completeOrder.layer.borderColor = UIColor.blue.cgColor
        
        
        if UserDefaults.standard.object(forKey: Constant.TABLE_NO) != nil {
            currentTableNo = UserDefaults.standard.object(forKey: Constant.TABLE_NO) as? String
            chooseTablePopoup.alpha = 0
            loadOrdersTableView.alpha = 1
            completeOrder.alpha = 1
            self.loadBasketServiceCall()
            
        } else {
            chooseTablePopoup.alpha = 1
            loadOrdersTableView.alpha = 0
            completeOrder.alpha = 0
        }

        if self.emptyTables.count > 0 {
            self.chooseTablePopoup.createPickerView(tableNoArray: self.emptyTables)
        } else {
            self.chooseTablePopoup.createPickerView(tableNoArray: self.emptyArray)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Sepet"
        //self.viewDidLoad()
        self.emptyTables.removeAll()
        self.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationItem.title = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadBasketServiceCall() {
   
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
    
    func checkEmptyTableServiceCall() {
        refCheckEmptyTable?.observe(FIRDataEventType.value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                for emptyTableCheck in snapshot.children.allObjects as! [FIRDataSnapshot] {
                    let orderEmptyTable = emptyTableCheck.value as? [String : AnyObject]
                    //let displayName = menuFoodObject?["DisplayName"]
                    let amount = orderEmptyTable?["Amount"]
                    let foodName = orderEmptyTable?["FoodName"]
                    
                    let price = orderEmptyTable?["Price"]
                    let tableNo = orderEmptyTable?["TableNo"]
                    let isOrderCompleted = orderEmptyTable?["IsOrderCompleted"]
                    
                    
                    let order = OrderModel.init(Amount: amount as! String?, FoodName: foodName as! String?, Price: price as! String?, TableNo: tableNo as! String?, IsOrderCompleted: isOrderCompleted as! String?)
                    
                    
                    self.emptyTables.append(order.TableNo!)
                }

            }
        })

    }
    
    func completeOrderServiceCall() {
        for index in 0...getOrdersArray.count - 1 {
        let key = ref?.child("Result").child("SubmittedOrders").childByAutoId().key
        let food = ["FoodName": (getOrdersArray[index].FoodName)! as String,
                    "Price": (getOrdersArray[index].Price)! as String,
                    "Amount": "1",
                    "TableNo": getOrdersArray[index].TableNo,
                    "IsOrderCompleted": "true"]
        /*let childUpdates = ["Result/Orders/\(key)": food,
         
         ] as [String : Any]
         ref?.updateChildValues(childUpdates)*/
        ref?.child("Result").child("SubmittedOrders").child(key!).setValue(food)
            
        }
    
        self.deleteBasketServiceCall()
  
    }
    
    func deleteBasketServiceCall() {
        ref?.child("Result").child("Orders").removeValue()
        self.getOrdersArray.removeAll()
        self.loadOrdersTableView.reloadData()
    }
    
    func checkTableNoAndOrderComplete(tableNoAndOrderCompleteArr : [OrderModel]) {
        self.getOrdersArray.removeAll()
        for index in 0...tableNoAndOrderCompleteArr.count - 1 {
            print("currentTableNo is : \(currentTableNo)")
            if currentTableNo! == tableNoAndOrderCompleteArr[index].TableNo && tableNoAndOrderCompleteArr[index].IsOrderCompleted == "false" {
                if !self.getOrdersArray.contains(tableNoAndOrderCompleteArr[index]) {
                    self.getOrdersArray.append(tableNoAndOrderCompleteArr[index])
                }
            }
        }
        self.loadOrdersTableView.reloadData()
    }
    
    func alert() {
        
            let okAction = UIAlertAction(title: "Tamam", style: UIAlertActionStyle.default) {
                (result : UIAlertAction) -> Void in
                self.navigationController?.popViewController(animated: true)
            }
            self.showAlert(title: "Uyarı", message: "Siparişiniz verildi, afiyet olsun", actions: [okAction])

    }
    
    //ACTIONS
    
    @IBAction func completeOrderButton(_ sender: Any) {
        
        self.completeOrderServiceCall()
        
        self.alert()
        
    }
    
    @IBAction func tableChooseButton(_ sender: Any) {
        
        if UserDefaults.standard.object(forKey: Constant.TABLE_NO) != nil {
            
        } else {
            
        }
    }


}

extension BasketViewController : UITableViewDelegate {
    
}

extension BasketViewController : UITableViewDataSource {
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

extension BasketViewController : ChooseTablePopupViewDelegate {
    
    func sendTableNo(tableNo: String) {
        
        
        self.currentTableNo = tableNo
        
         UserDefaults.standard.setValue(tableNo, forKey: Constant.TABLE_NO)
        
        print("table no : \(self.currentTableNo)")
        
    }
}
