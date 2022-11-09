//
//  LoginViewController.swift
//  MenuApp
//
//  Created by Milos Petrusic on 7.11.22..
//

import UIKit

class LoginViewController: BaseVC {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signInButtonBottomConstraint: NSLayoutConstraint!
    
    private let loginService = LoginService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addKeyboardNotifications()
        addGestureRecoginzers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillShowNotification)
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillHideNotification)
    }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        if isFormValid {
            self.startActivityIndicator()
            loginService.login(email: email, password: password) { [weak self] result in
                guard let self else { return }
                
                DispatchQueue.main.async {
                    self.stopActivityIndicator()
                }
                switch result {
                case .success(_):
                    DispatchQueue.main.async {
                        self.loginSuccess()
                    }
                case .failure(_):
                    DispatchQueue.main.async {
                        self.loginFailure()
                    }
                }
            }
        }
    }
    
    private func configureUI() {
        signInButton.layer.cornerRadius = 8
    }
    
    private func loginSuccess() {
        let storyboard = UIStoryboard(name: "Venues", bundle: nil)
        let venuesVC = storyboard.instantiateViewController(withIdentifier: "VenuesNavigationController")
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(venuesVC, options: .transitionFlipFromRight)
    }
    
    private func loginFailure() {
        let ac = UIAlertController(title: "Login failed", message: "Please try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    private var isFormValid: Bool {
        var isFormValid = true

        if emailTextField?.text?.count == 0 || emailTextField?.text == nil {
            isFormValid = false
        }
   
        if passwordTextField?.text?.count == 0 || passwordTextField?.text == nil {
            isFormValid = false
        }
        
        return isFormValid
    }
    
    private func addGestureRecoginzers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer?) {
        sender?.cancelsTouchesInView = false
        view.endEditing(true)
    }
    
    private func addKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        
        let keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardHeight = keyboardFrame.height
        
        UIView.animate(withDuration: 0.6) {
            self.signInButtonBottomConstraint.constant = keyboardHeight
            self.view.layoutIfNeeded()
        }
    }

    @objc func keyboardWillHide(notification:NSNotification) {
        UIView.animate(withDuration: 0.6) {
            self.signInButtonBottomConstraint.constant = 46
            self.view.layoutIfNeeded()
        }
    }
}
