
import UIKit

class OrderModel: NSObject {
    
    var Amount : String?
    var FoodName : String?
    var Price : String?
    var TableNo : String?
    var IsOrderCompleted : String?

    init(Amount : String?, FoodName : String?, Price : String?, TableNo : String?, IsOrderCompleted : String?) {
        self.Amount = Amount
        self.FoodName = FoodName
        self.Price = Price
        self.TableNo = TableNo
        self.IsOrderCompleted = IsOrderCompleted
    }

}
