
import UIKit


class MenuFoodModel: NSObject {
    
    var ID : String?
    var CatID : String?
    var DisplayName : String?
    var Price : String?
    var imageURL : String?
    
    init(ID : String?, CatID : String?, DisplayName : String?, Price : String?, imageURL : String?) {
        self.ID = ID
        self.CatID = CatID
        self.DisplayName = DisplayName
        self.Price = Price
        self.imageURL = imageURL
    }
    
}
