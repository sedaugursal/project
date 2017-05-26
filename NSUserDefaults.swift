
import Foundation


extension UserDefaults {
    
    class func setObjectAndSync(value : AnyObject, key : String) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(value, forKey: key)
        userDefaults.synchronize()
    }
    
    class func getObjectForKey(key : String) -> AnyObject? {
        let userDefaults = UserDefaults.standard
        return userDefaults.object(forKey: key) as AnyObject?
    }
    
    class func removeObjectForKey(key : String){
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: key)
        userDefaults.synchronize()
    }
}


