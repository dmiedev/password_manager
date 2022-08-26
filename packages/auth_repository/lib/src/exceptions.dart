abstract class AuthRepositoryException implements Exception {}

class AuthenticationFailureException extends AuthRepositoryException {}

class AuthenticationLockNotSetException extends AuthRepositoryException {}
