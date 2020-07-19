import UIKit

final class TranslateViewController: UIViewController {
    
    // MARK: - Properties
    private let translateNetworkManager = TranslateNetworkManager()
    
    // MARK: - Outlets
    @IBOutlet weak private var translationTextField: UITextField!
    @IBOutlet weak private var translationResultLabel: UILabel!
    @IBOutlet weak private var selectionLanguagePickerView: UIPickerView!
}

// MARK: - Translation
extension TranslateViewController {
    @IBAction private func didTapOnTranslateButton() {
        
        guard let expression = translationTextField.text else { return }
        let selectedLanguageIndex = selectionLanguagePickerView.selectedRow(inComponent: 0)
        let selectedLanguageCode = languages[selectedLanguageIndex].code
        
        translateNetworkManager.fetchTranslationInformationFor(expression: expression, languageCode: selectedLanguageCode, completion: {(result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let response):
                    guard let translatedText = response.data.translations.first?.translatedText else { return }
                    guard let detectedSourceLanguage = response.data.translations.first?.detectedSourceLanguage else { return }
                    self.translationResultLabel.text =
                    
                    """
                    Detected source language : \(detectedSourceLanguage)\n
                    Translated text : \(translatedText)
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
