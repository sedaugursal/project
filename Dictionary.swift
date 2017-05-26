
import Foundation

extension Dictionary {
    
    /// Build string representation of HTTP parameter dictionary of keys and objects
    ///
    /// This percent escapes in compliance with RFC 3986
    ///
    /// http://www.ietf.org/rfc/rfc3986.txt
    ///
    /// :returns: String representation in the form of key1=value1&key2=value2 where the keys and values are percent escaped
    
    func stringFromHttpParameters() -> String {
        let parameterArray = self.map { (key, value) -> String in
            let percentEscapedKey = (key as! String).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            if value is String {
                let percentEscapedValue = (value as! String).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                return "\(percentEscapedKey!)=\(percentEscapedValue!)"
            } else if value is NSDictionary {
                return (value as! Dictionary).stringFromHttpParameters()
            } else {
                return ""
            }
        }
        
        return parameterArray.joined(separator: "&")
    }
    
}
