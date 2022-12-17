class AuthException implements Exception{
  static const Map<String, String> errors = {
    'EMAIL_EXISTS': 'Esse e-mail já foi cadastrado.',
    'OPERATION_NOT_ALLOWED': 'Operação não permitida.',
    'TOO_MANY_ATTEMPTS_TRY_LATER': 'Muitas tentativas. Tente novamente depois.',
    'EMAIL_NOT_FOUND': 'E-mail não encontrado!',
    'INVALID_PASSWORD': 'Senha inválida!',
    'USER_DISABLED': 'Usuário desabilitado!',
  };

  final String key;

  AuthException(this.key);

  @override
  String toString(){
    return errors[key] ?? 'Ocorreu um erro no processo.';
  }
}