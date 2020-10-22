import Foundation

extension String {
    
    /// Used to return the correct value in the device language
    var localized: String {
        
        return NSLocalizedString(self, comment: "")
    }
}
