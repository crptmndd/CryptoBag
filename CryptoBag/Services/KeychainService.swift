import Foundation
import Security


protocol KeychainServiceProtocol {
    func savePassword(login: String, password: String) -> Bool
    func getPassword(login: String) -> String?
    func deletePassword(login: String) -> Bool
}


final class KeychainService: KeychainServiceProtocol {
    
    func savePassword(login: String, password: String) -> Bool {
        let passwordData = password.data(using: .utf8)!
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: login,
            kSecValueData as String: passwordData
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status == errSecDuplicateItem {
            let updateQuery: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: login,
                kSecValueData as String: passwordData
            ]
            let statusUpdate = SecItemUpdate(query as CFDictionary, updateQuery as CFDictionary)
            return statusUpdate == errSecSuccess
        }
        
        return status == errSecSuccess
    }
    
    func getPassword(login: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: login,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecSuccess, let data = result as? Data {
            return String(data: data, encoding: .utf8)
        } else {
            return nil
        }
    }
    
    func deletePassword(login: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: login
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }
    
    
}
