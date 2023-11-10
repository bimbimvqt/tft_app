class AuthState {}

class SignInState extends AuthState {
  bool? isLoading;
  bool? isSignInSuccess;
  bool? isVertifi;
  Object? error;

  SignInState({this.isLoading, this.error, this.isSignInSuccess, this.isVertifi});
}

class SignUpState extends AuthState {
  bool? isLoading;
  bool? isSignUpSuccess;
  Object? error;

  SignUpState({this.isLoading, this.error, this.isSignUpSuccess});
}
