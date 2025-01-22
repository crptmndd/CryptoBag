enum ValidationError: Error {
    case tooShort
    case noUppercase
    case noDigit
    case passwordsDoNotMatch
    case emptyFields
}
