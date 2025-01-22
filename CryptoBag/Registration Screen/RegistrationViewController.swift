import UIKit


final class RegistrationViewController: UIViewController {
    
    private var registrationViewModel: RegistrationViewModelProtocol
    private let registrationView: RegistrationView 
    
    init(registrationViewModel: RegistrationViewModelProtocol) {
        self.registrationViewModel = registrationViewModel
        self.registrationView = RegistrationView(frame: .zero)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = registrationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
    }
    
    private func setupBindings() {
        registrationView.onRegisterButtonTap = { [weak self] email, username, password, confirmPassword in
            self?.registrationViewModel.register(email: email, username: username, password: password, confirmPassword: confirmPassword)
        }
        
        registrationViewModel.onRegistrationSuccess = { [weak self] in
            print("Successfully registered")
        }
        
        registrationViewModel.onRegistrationFailure = { [weak self] error in
            print("Error registering: \(error)")
        }
    }
    
}
