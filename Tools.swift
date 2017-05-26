
import UIKit

class Tools: NSObject {
    
    class func listAllFonts(){
        let familyNames : [String] = UIFont.familyNames
        var fontNames : Array<AnyObject>

        
        for family in familyNames {
            print("Familame \(family)")
            fontNames = UIFont.fontNames(forFamilyName: family) as Array<AnyObject>
            for font in fontNames {
                print("FontName \(font)")
            }
            
        }
    }
    
    class func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x:0, y:0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
    
    class func reCalculateViewHeight(view: UIView!){
        var maxHeight : CGFloat = 0
       
        for subview in view.subviews{
            maxHeight = subview.frame.origin.y + subview.frame.size.height > maxHeight ? subview.frame.origin.y + subview.frame.size.height : maxHeight
        }
        
        var frame = view.frame
        frame.size.height = maxHeight + 15
        view.frame = frame
        
    }
    
    
    class func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    
    class func delay(delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            closure()
        }
    }
    
    
}





