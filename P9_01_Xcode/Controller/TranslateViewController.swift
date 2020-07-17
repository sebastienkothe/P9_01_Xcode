import UIKit

final class TranslateViewController: UIViewController {
    // MARK: - Properties
    let translateNetworkManager = TranslateNetworkManager()
    
    // MARK: - Outlets
    @IBOutlet weak var translationTextField: UITextField!
    @IBOutlet weak var translationResultLabel: UILabel!
    @IBOutlet weak var selectionLanguagePickerView: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Translation
extension TranslateViewController {
    @IBAction func didTapOnTranslateButton() {
        
        guard let expression = translationTextField.text else { return }
        let selectedLanguageIndex = selectionLanguagePickerView.selectedRow(inComponent: 0)
        let selectedLanguageCode = languages[selectedLanguageIndex].code
        
        translateNetworkManager.fetchTranslationInformationFor(expression: expression, languageCode: selectedLanguageCode, completion: {(result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let response):
                    guard let translatedText = response.data.translations.first?.translatedText else {
                        //                        self.handleError(error: .emptyTextField);
                        return }
                    self.translationResultLabel.text = translatedText
                }
            }
        })
    }
}

// MARK: - PickerView
extension TranslateViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languages[row].name
    }
}

// MARK: - Keyboard
extension TranslateViewController: UITextFieldDelegate {
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        translationTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == translationTextField {
            //any task to perform
            
            // Used to dismiss your keyboard
            textField.resignFirstResponder()
        }
        return true
    }
}
