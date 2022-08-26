abstract class LoginRepositoryException implements Exception {}

class LoginSaveException extends LoginRepositoryException {}

class LoginRepositoryNotInitializedException extends LoginRepositoryException {}
