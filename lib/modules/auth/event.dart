abstract class AuthEvent {}

class SignInWithEmailPassword extends AuthEvent {
  String email;
  String password;

  SignInWithEmailPassword({required this.email, required this.password});
}

class SignUpWithEmailPassword extends AuthEvent {
  String email;
  String password;

  SignUpWithEmailPassword({required this.email, required this.password});
}

class SignInWithGoogle extends AuthEvent {}
