import UIKit


final class LoginViewController: UIViewController {
    
    private var loginViewModel: LoginViewModelProtocol
    private let loginView: LoginView
    
    init(loginViewModel: LoginViewModel) {
        self.loginViewModel = loginViewModel
        self.loginView = LoginView(frame: .zero)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLoginViewBindings()
        setupLoginViewModelBindings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    private func setupLoginViewBindings() {
        loginView.onLoginButtonTap = { [weak self] login, password in
            self?.loginViewModel.loginButtonDidTap(login: login, password: password)
        }
        
        loginView.onGuestButtonTap = { [weak self] in
            self?.loginViewModel.guestButtonDidTap()
        }
        
        loginView.onFaceIDButtonTap = { [weak self] in
            self?.loginViewModel.authWithFaceID()
        }
    }
    
    private func setupLoginViewModelBindings() {
        loginViewModel.onLoginSuccess = { [weak self] in
            print("Authorized")
        }
        
        loginViewModel.onLoginFailure = { error in
            print("Error: \(error)")
        }
        
        loginViewModel.onGuestLogin = { [weak self] in
            print("Guest login")
        }
        
        loginViewModel.onFaceIDLogin = { [weak self] in
            print("FaceID login")
        }
    }
    

}

