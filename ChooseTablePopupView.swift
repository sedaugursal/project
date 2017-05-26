
import UIKit

protocol ChooseTablePopupViewDelegate {
    func sendTableNo(tableNo : String)
}

class ChooseTablePopupView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var delegate : ChooseTablePopupViewDelegate?
    
    var containerView : UIView = UIView()
    var pickerView : UIPickerView = UIPickerView()
    
    var tableArray : [String] = []
    var currentTableNo : String?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        containerView.frame = CGRect(x:10, y:50, width: UIScreen.main.bounds.size.width - 20, height: 200)
        containerView.backgroundColor = UIColor.lightGray
        self.addSubview(containerView)
        
        pickerView.frame = CGRect(x: 15, y: 20, width: containerView.bounds.size.width - 30, height: 160)
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = UIColor.orange
        self.containerView.addSubview(pickerView)
    }
    
    func createPickerView(tableNoArray : [String]) {
        self.tableArray = tableNoArray
        pickerView.reloadAllComponents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tableArray.count
    }
    
    // Delegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return tableArray[row]
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if UserDefaults.standard.object(forKey: Constant.TABLE_NO) != nil && UserDefaults.standard.object(forKey: Constant.TABLE_NO) as! String != tableArray[row]{
            UserDefaults.standard.removeObject(forKey: Constant.TABLE_NO)
            
        }
        UserDefaults.standard.setValue(tableArray[row], forKey: Constant.TABLE_NO)
        //UserDefaults.standard.setValue(tableArray[row], forKey: Constant.TABLE_NO)
        self.delegate?.sendTableNo(tableNo: tableArray[row])
        
    }

    
    

}
