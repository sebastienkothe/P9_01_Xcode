import UIKit

final class TranslateViewController: RootController {
    
    // MARK: - Outlets
    @IBOutlet weak private var translationTextField: UITextField!
    @IBOutlet weak private var translationResultLabel: UILabel!
    @IBOutlet weak private var selectionLanguagePickerView: UIPickerView!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var translateActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        translateActivityIndicator.isHidden = true
        translateButton.layer.cornerRadius = 30
    }
}

// MARK: - Translation
extension TranslateViewController {
    @IBAction private func didTapOnTranslateButton() {
        
        // To show the activity indicator and hide the button
        toggleActivityIndicator(shown: true, activityIndicator: translateActivityIndicator, button: translateButton)
        handleTheTranslationRequest()
    }
    
    /// Used to handle the translation request
    private func handleTheTranslationRequest() {
        let translateNetworkManager = TranslateNetworkManager()
        
        guard let expression = translationTextField.text else { return }
        let selectedLanguageIndex = selectionLanguagePickerView.selectedRow(inComponent: 0)
        let selectedLanguageCode = languages[selectedLanguageIndex].code
        
        translateNetworkManager.fetchTranslationInformationFor(expression: expression, languageCode: selectedLanguageCode, completion: { [weak self] (result) in
            guard let self = self else {return}
            
            DispatchQueue.main.async {
                self.toggleActivityIndicator(shown: false, activityIndicator: self.translateActivityIndicator, button: self.translateButton)
                switch result {
                case .failure(let error):
                    self.handleError(error: error)
                case .success(let response):
                    guard let translatedText = response.data.translations.first?.translatedText else { return }
                    guard let detectedSourceLanguage = response.data.translations.first?.detectedSourceLanguage else { return }
                    self.translationResultLabel.text =
                        
                        """
                        \("detected_source_language_title".localized) : \(detectedSourceLanguage)\n
                        \("translated_text_title".localized) : \(translatedText)
                    """
                }
            }
            
        })
    }
}

// MARK: - PickerView
extension TranslateViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    internal func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    internal func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languages.count
    }
    
    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languages[row].name
    }
}

// MARK: - Keyboard
extension TranslateViewController: UITextFieldDelegate {
    @IBAction private func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        translationTextField.resignFirstResponder()
    }
    
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == translationTextField {
            //any task to perform
            
            // Used to dismiss your keyboard
            textField.resignFirstResponder()
        }
        return true
    }
}
