protocol PropertyReflectable {
    subscript(key: String) -> Any? { get }
}

//default implementation
extension PropertyReflectable {
    subscript(key: String) -> Any? {
        
        // Instance of Mirror with the initializer Mirror(reflecting:)
        let mirror = Mirror(reflecting: self)
        
        return mirror.children.first { $0.label == key }?.value
    }
}
