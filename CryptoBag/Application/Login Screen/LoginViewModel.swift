import Foundation
import LocalAuthentication


enum LoginError: Error {
    case invalidCredentials
}


protocol LoginViewModelProtocol {
    var onLoginSuccess: (() -> Void)? { get set }
    var onLoginFailure: ((Error) -> Void)? { get set }
    var onGuestLogin: (() -> Void)? { get set }
    var onFaceIDLogin: (() -> Void)? { get set }
    func loginButtonDidTap(login: String, password: String) -> Void
    func guestButtonDidTap() -> Void
    func isUserLoggedIn() -> Bool
    func authWithFaceID() -> Void
}


final class LoginViewModel: LoginViewModelProtocol {
    var onLoginSuccess: (() -> Void)?
    var onLoginFailure: ((Error) -> Void)?
    var onGuestLogin: (() -> Void)?
    var onFaceIDLogin: (() -> Void)?
    
    private let userDefaultsManager: UserDefaultsManagerProtocol
    private let faceIDService: FaceIDServiceProtocol
    
    init(userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager.shared, faceIDService: FaceIDServiceProtocol = FaceIDService()) {
        self.userDefaultsManager = userDefaultsManager
        self.faceIDService = faceIDService
    }
    
    func loginButtonDidTap(login: String, password: String) -> Void {
        Task {
            do {
                let success = try await authenticate(login: login, password: password)
                if success {
                    self.userDefaultsManager.logInUser()
                    self.onLoginSuccess?()
                } else {
                    self.onLoginFailure?(LoginError.invalidCredentials)
                }
            } catch {
                self.onLoginFailure?(error)
            }
            
        }
    }
    
    func guestButtonDidTap() -> Void {
        onGuestLogin?()
    }
    
    private func authenticate(login: String, password: String) async throws -> Bool {
        try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
                if login == "admin" && password == "123" {
                    continuation.resume(returning: true)
                } else {
                    continuation.resume(throwing: LoginError.invalidCredentials)
                }
            }
        }
    }
    
    func isUserLoggedIn() -> Bool {
        return userDefaultsManager.isLoggedIn()
    }
    
    func authWithFaceID() -> Void {
        Task {
            do {
                try await self.faceIDService.authenticateWithFaceID()
                onFaceIDLogin?()
            } catch {
                print("Ошибка FaceID: \(error.localizedDescription)")
            }
        }
    }
    
}
