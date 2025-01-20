import Foundation
import LocalAuthentication


protocol FaceIDServiceProtocol: AnyObject {
    func authenticateWithFaceID() async throws
}


final class FaceIDService: FaceIDServiceProtocol {
    
    private let context = LAContext()
    
    func authenticateWithFaceID() async throws {
        var error: NSError?
        
        return try await withCheckedThrowingContinuation { continuation in
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Authenticate with FaceID") { success, error in
                    if success {
                        continuation.resume(returning: ())
                    } else {
                        continuation.resume(throwing: error ?? NSError(domain: "FaceID", code: -1, userInfo: [NSLocalizedDescriptionKey: "Ошибка аутентификации"]))
                    }
                }
            } else {
                continuation.resume(throwing: error ?? NSError(domain: "FaceID", code: -1, userInfo: [NSLocalizedDescriptionKey: "FaceID недоступен"]))
            }
        }
        
    }
    
}
