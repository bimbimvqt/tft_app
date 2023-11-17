class AuthState {}

class SignInState extends AuthState {
  bool? isLoading;
  bool? isSignInSuccess;
  Object? error;

  SignInState({this.isLoading, this.error, this.isSignInSuccess});
}

