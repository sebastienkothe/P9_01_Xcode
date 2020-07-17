import UIKit

final class TranslateViewController: UIViewController {
    // MARK: - Properties
    let translateNetworkManager = TranslateNetworkManager()
    
    // MARK: - Outlets
    @IBOutlet weak var translationTextField: UITextField!
    @IBOutlet weak var translationResultLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Translation
extension TranslateViewController {
    @IBAction func didTapOnTranslateButton() {
        guard let expression = translationTextField.text else { return }
        translateNetworkManager.fetchTranslationInformationFor(expression: expression, completion: {(result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let response):
                    guard let translatedText = response.data.translations.first?.translatedText else { return }
                    self.translationResultLabel.text = translatedText
                }
            }
        })
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
