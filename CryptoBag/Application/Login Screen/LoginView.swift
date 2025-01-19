import UIKit


final class LoginView: UIView {
    
    var onLoginButtonTap: ((String, String) -> Void)?
    var onGuestButtonTap: (() -> Void)?
    var onFaceIDButtonTap: (() -> Void)?
    
    private lazy var loginTextField: UITextField = {
        let textFeild = UITextField()
        textFeild.placeholder = "Login"
        textFeild.keyboardType = .emailAddress
        textFeild.autocapitalizationType = .none
        textFeild.translatesAutoresizingMaskIntoConstraints = false
        textFeild.borderStyle = .roundedRect
        return textFeild
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textFeild = UITextField()
        textFeild.placeholder = "Password"
        textFeild.keyboardType = .default
        textFeild.autocapitalizationType = .none
        textFeild.isSecureTextEntry = true
        textFeild.translatesAutoresizingMaskIntoConstraints = false
        textFeild.borderStyle = .roundedRect
        return textFeild
    }()
    
    private lazy var loginButton: UIButton = {
        let action = UIAction { [weak self] _ in
            guard let self = self else { return }
            let login = self.loginTextField.text ?? ""
            let password = self.passwordTextField.text ?? ""
            self.onLoginButtonTap?(login, password)
        }
        let button = UIButton(configuration: .filled(), primaryAction: action)
        button.setTitle("Login", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var guestButton: UIButton = {
        let action = UIAction { [weak self] _ in
            guard let self = self else { return }
            self.onGuestButtonTap?()
        }
        let button = UIButton(configuration: .plain(), primaryAction: action)
        button.setTitle("Login as Guest", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var faceIdButton: UIButton = {
        let action = UIAction { [weak self] _ in
            guard let self = self else { return }
            self.onFaceIDButtonTap?()
        }
        let button = UIButton(configuration: .plain(), primaryAction: action)
        let image = UIImage(systemName: "faceid")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        
        addSubview(loginTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(guestButton)
        addSubview(faceIdButton)
        
        NSLayoutConstraint.activate([
            loginTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 120),
            loginTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            loginTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 64),
            loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -64),
            
            guestButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
            guestButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            faceIdButton.topAnchor.constraint(equalTo: guestButton.bottomAnchor, constant: 10),
            faceIdButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    deinit {
        print("Deinit LoginView")
    }
    
}
