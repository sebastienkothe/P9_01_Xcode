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
        
        translationTextView.delegate = self
        translationTextView.text = "placeholder_translationTextView".localized
        translationTextView.textColor = UIColor.gray
        translationTextView.addDoneButtonToKeyboard()
        
        translateButton.layer.cornerRadius = 30
        
        self.navigationItem.title = "navigation_item_title_translate".localized
        
        setUpPlaceholderFrom(targetLanguageTextField, placeholderString: "placeholder_targetLanguageTextField")
        
        setupLanguagePicker()
    }
    
    private func setupLanguagePicker() {
        selectionLanguagePickerView.delegate = self
        selectionLanguagePickerView.dataSource = self
        
        targetLanguageTextField.inputView = selectionLanguagePickerView
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
        
        let emptyBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: self,
            action: nil
        )
        
        let doneBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(closeKeyboard)
        )
        
        doneBarButtonItem.tintColor = .systemYellow
        
        toolbar.items = [emptyBarButtonItem, doneBarButtonItem]
        
        toolbar.sizeToFit()
        
        targetLanguageTextField.inputAccessoryView = toolbar
    }
    
    @objc private func closeKeyboard() {
        view.endEditing(true)
    }
    
    var selectedLanguage: Language = .Afrikaans {
        didSet {
            targetLanguageTextField.text = selectedLanguage.displayName
        }
    }
}

// MARK: - Translation
extension TranslateViewController {
    @IBAction private func didTapOnTranslateButton() {
        
        guard targetLanguageTextField.text != "placeholder_targetLanguageTextField".localized, targetLanguageTextField.text != "".trimmingCharacters(in: .whitespaces) else {
            return
                handleError(error: .noLanguageSelected)
        }
        
        guard translationTextView.text != "placeholder_translationTextView".localized, translationTextView.text != "".trimmingCharacters(in: .whitespaces) else {
            handleError(error: .emptyTextField)
            return
        }
        
        // To show the activity indicator and hide the button
        toggleActivityIndicator(shown: true, activityIndicator: translateActivityIndicator, button: translateButton)
        handleTheTranslationRequestFrom(translationTextView.text)
    }
    
    /// Used to handle the translation request
    private func handleTheTranslationRequestFrom(_ textToTranslate: String) {
        let translateNetworkManager = TranslateNetworkManager()
        
        translateNetworkManager.fetchTranslationInformationFor(expression: textToTranslate, languageCode: selectedLanguage.code, completion: { [weak self] (result) in
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
        return Language.allCases[row].displayName
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
        if textView.text == "placeholder_translationTextView".localized {
            textView.text = nil
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespaces).isEmpty {
            translationTextView.text = "placeholder_translationTextView".localized
            textView.textColor = UIColor.gray
        }
    }
}
