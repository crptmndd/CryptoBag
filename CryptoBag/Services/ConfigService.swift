import Foundation

protocol UserDefaultsManagerProtocol: AnyObject {
    func logInUser()
    func logOutUser()
    func isLoggedIn() -> Bool
}

final class SessionService: UserDefaultsManagerProtocol {
    
    static let shared = UserDefaultsManager()
    
    private let userDefaults = UserDefaults(suiteName: "logged_info")
    private let loggedInKey = "logged_in"
    
    func logInUser() {
        userDefaults?.setValue(true, forKey: loggedInKey)
    }
    
    func logOutUser() {
        userDefaults?.removeObject(forKey: loggedInKey)
    }
    
    func isLoggedIn() -> Bool {
        return userDefaults?.bool(forKey: loggedInKey) ?? false
    }
    
}

    
    
