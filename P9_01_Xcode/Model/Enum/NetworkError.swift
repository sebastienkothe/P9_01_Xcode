enum NetworkError: Error {
    case unknownError
    case failedToDecodeJSON
    case noData
    case failedToCreateURL
    case emptyTextField
    
    var title: String {
        switch self {
        case .unknownError: return "error_unknown_error_title".localized
        case .failedToDecodeJSON: return "error_failed_to_decode_json_title".localized
        case .noData: return "error_no_data_title".localized
        case .failedToCreateURL: return "error_convert_math_operator_title".localized
        case .emptyTextField: return "error_empty_textfield_title".localized
        }
    }
}
