import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'auth_events.dart';
import 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  FirebaseAuth auth = FirebaseAuth.instance;
  AuthBloc() : super(AuthState()) {
    on<SignInWithGoogle>((event, emit) async {
      try {
        emit(SignInState(isLoading: true));

        final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

        if (gUser != null) {
          final GoogleSignInAuthentication gAuth = await gUser.authentication;
          final credential = GoogleAuthProvider.credential(
            accessToken: gAuth.accessToken,
            idToken: gAuth.idToken,
          );
          emit(SignInState(isLoading: true));
          await FirebaseAuth.instance.signInWithCredential(credential);
          emit(SignInState(isSignInSuccess: true));
        }
      } 
      finally {
        emit(SignInState(isLoading: false));
      }
    });
  }
}
