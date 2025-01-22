struct PasswordsValidator {
    
    static func validate(password: String, confirmPassword: String) throws {
        guard password.count >= 8 else { throw ValidationError.tooShort }
        guard password.rangeOfCharacter(from: .uppercaseLetters) != nil else { throw ValidationError.noUppercase }
        guard password.rangeOfCharacter(from: .decimalDigits) != nil else { throw ValidationError.noDigit }
        guard password == confirmPassword else { throw ValidationError.passwordsDoNotMatch }
        guard !password.isEmpty || !confirmPassword.isEmpty else { throw ValidationError.emptyFields }
    }
    
}
