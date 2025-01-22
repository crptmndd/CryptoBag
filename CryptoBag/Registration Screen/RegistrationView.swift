import UIKit


final class RegistrationView: UIView {
    
    var onRegisterButtonTap: ((String, String, String, String) -> Void)?
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress
        textField.autocorrectionType = .no
        textField.textContentType = .emailAddress
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.textContentType = .username
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.textContentType = .newPassword
        if #available(iOS 12.0, *) {
            textField.passwordRules = UITextInputPasswordRules(descriptor: "required: upper; required: lower; required: digit; minlength: 8;")
        }
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Confirm Password"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.textContentType = .newPassword
        if #available(iOS 12.0, *) {
            textField.passwordRules = UITextInputPasswordRules(descriptor: "required: upper; required: lower; required: digit; minlength: 8;")
        }
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var registerButton: UIButton = {
        let action = UIAction { [weak self] _ in
            guard let self = self else { return }
            let email = self.emailTextField.text ?? ""
            let username = self.usernameTextField.text ?? ""
            let password = self.passwordTextField.text ?? ""
            let confirmPassword = self.confirmPasswordTextField.text ?? ""
            self.onRegisterButtonTap?(email, username, password, confirmPassword)
        }
        let button = UIButton(configuration: .filled(), primaryAction: action)
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {

        addSubview(emailTextField)
        addSubview(usernameTextField)
        addSubview(passwordTextField)
        addSubview(confirmPasswordTextField)
        addSubview(registerButton)
        
        NSLayoutConstraint.activate([
            
            emailTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 120),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            usernameTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            usernameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            usernameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            registerButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 40),
            registerButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 64),
            registerButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -64)
            
        ])
        
    }
    
}
