abstract class LoginRepositoryException implements Exception {}

class LoginDataSaveException extends LoginRepositoryException {}

class PasswordLoadException extends LoginRepositoryException {}

class LoginRepositoryNotInitializedException extends LoginRepositoryException {}
