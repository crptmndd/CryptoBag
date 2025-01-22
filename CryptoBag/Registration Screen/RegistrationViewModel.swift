import Foundation


protocol RegistrationViewModelProtocol {
    var onRegistrationSuccess: (() -> Void)? { get set }
    var onRegistrationFailure: ((Error) -> Void)? { get set }
    func register(email: String, username: String, password: String, confirmPassword: String)
}

final class RegistrationViewModel: RegistrationViewModelProtocol {
    
    var onRegistrationSuccess: (() -> Void)?
    var onRegistrationFailure: ((any Error) -> Void)?
    
    private let keyChain: KeychainServiceProtocol
    
    init(keyChain: KeychainServiceProtocol = KeychainService()) {
        self.keyChain = keyChain
    }
    
    func register(email: String, username: String, password: String, confirmPassword: String) {
        do {
            try PasswordsValidator.validate(password: password, confirmPassword: confirmPassword)
            let success = keyChain.savePassword(login: email, password: password)
            
            if success {
                self.onRegistrationSuccess?()
                print("Password Saved")
            }
            print("Пароль валиден!")
        } catch {
            self.onRegistrationFailure?(error)
            print("Error: \(error.localizedDescription)")
        }
    }
    
    
}
