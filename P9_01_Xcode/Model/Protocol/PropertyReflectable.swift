protocol PropertyReflectable {
    subscript(key: String) -> Any? { get }
}

//default implementation
extension PropertyReflectable {
    subscript(key: String) -> Any? {
        let m = Mirror(reflecting: self)
        return m.children.first { $0.label == key }?.value
    }
}
