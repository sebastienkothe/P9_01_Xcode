enum NetworkError: Error, CaseIterable {
    case unknownError
    case failedToDecodeJSON
    case noData
    case failedToCreateURL
    case emptyTextField
    case incorrectHttpResponseCode
    case locationServiceDisabled
    case noLanguageSelected
    
    var title: String {
        switch self {
        case .unknownError: return "error_unknown_error_title".localized
        case .failedToDecodeJSON: return "error_failed_to_decode_json_title".localized
        case .noData: return "error_no_data_title".localized
        case .failedToCreateURL: return "error_cannot_create_url_title".localized
        case .emptyTextField: return "error_empty_textfield_title".localized
        case .incorrectHttpResponseCode: return "error_incorrect_http_response_code_title".localized
        case .locationServiceDisabled: return "error_location_service_disabled_title".localized
        case .noLanguageSelected: return "error_no_language_selected".localized
        }
    }
}
