
import Foundation

extension NSURL {
    
    public var queryItems: [String: String] {
        var params = [String: String]()
        return NSURLComponents(url: self as URL, resolvingAgainstBaseURL: false)?
            .queryItems?
            .reduce([:], { (_, item) -> [String: String] in
                params[item.name] = item.value
                return params
            }) ?? [:]
    }
}
