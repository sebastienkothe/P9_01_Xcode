import UIKit

final class TranslateViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var translateActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var translationResultTextView: UITextView!
    @IBOutlet weak var targetLanguageTextField: UITextField!
    @IBOutlet weak var translationTextView: UITextView!
    
    
    private let selectionLanguagePickerView = UIPickerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        translateActivityIndicator.isHidden = true
        translateButton.layer.cornerRadius = 30
        translationTextView.delegate = self
        
        translationTextView.addFinishButtonToKeyboard()
        
        translationTextView.text = "placeholder_translationTextView".localized
        translationTextView.textColor = UIColor.gray
        
        targetLanguageTextField.attributedPlaceholder = NSAttributedString(string: "placeholder_targetLanguageTextField".localized, attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        
        
        setupLanguagePicker()
        
        self.navigationItem.title = "navigation_item_title_translate".localized
    }
    
    private func setupLanguagePicker() {
        selectionLanguagePickerView.delegate = self
        selectionLanguagePickerView.dataSource = self
        
        targetLanguageTextField.inputView = selectionLanguagePickerView
        
        let toolBar = UIToolbar()
        
        let enptyBarButtonIte = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: self,
            action: nil
        )
        let doneBarButtonIte = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(closeKeyboard)
        )
        toolBar.items = [enptyBarButtonIte, doneBarButtonIte]
        
        toolBar.sizeToFit()
        
        targetLanguageTextField.inputAccessoryView = toolBar
    }
    
    @objc private func closeKeyboard() {
        view.endEditing(true)
    }
    
    var selectedLanguage: Language = .Afrikaans {
        didSet {
            targetLanguageTextField.text = selectedLanguage.displayNane
        }
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
        
        guard let expression = translationTextView.text else { return }
        
        
        translateNetworkManager.fetchTranslationInformationFor(expression: expression, languageCode: selectedLanguage.code, completion: { [weak self] (result) in
            guard let self = self else {return}
            
            DispatchQueue.main.async {
                self.toggleActivityIndicator(shown: false, activityIndicator: self.translateActivityIndicator, button: self.translateButton)
                switch result {
                case .failure(let error):
                    self.handleError(error: error)
                case .success(let response):
                    guard let translatedText = response.data.translations.first?.translatedText else { return }
                    self.translationResultTextView.text = translatedText
                }
            }
            
        })
    }
}

// MARK: - PickerView
extension TranslateViewController: UIPickerViewDataSource {
    internal func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    internal func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Language.allCases.count
    }
    
    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Language.allCases[row].displayNane
    }
}

extension TranslateViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedLanguage = Language.allCases[row]
    }
}

// MARK: - Keyboard
extension TranslateViewController: UITextViewDelegate {
    @IBAction private func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        translationTextView.resignFirstResponder()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.gray {
            textView.text = nil
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            translationTextView.text = "placeholder_translationTextView".localized
            textView.textColor = UIColor.gray
        }
    }
}
