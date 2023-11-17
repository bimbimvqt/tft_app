import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'event.dart';
import 'state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  FirebaseAuth auth = FirebaseAuth.instance;
  AuthBloc() : super(AuthState()) {
    on<SignInWithEmailPassword>((event, emit) async {
      emit(SignInState(isLoading: true));
      try {
        await auth.signInWithEmailAndPassword(email: event.email, password: event.password);
        if (auth.currentUser!.emailVerified) {
          emit(SignInState(isSignInSuccess: true));
        } else {
          emit(SignInState(isVertifi: false));
        }
      } catch (e) {
        emit(SignInState(error: e));
      }
    });

    on<SignUpWithEmailPassword>((event, emit) async {
      emit(SignUpState(isLoading: true));
      try {
        await auth.createUserWithEmailAndPassword(email: event.email, password: event.password);
        await auth.signInWithEmailAndPassword(email: event.email, password: event.password);
        FirebaseAuth.instance.currentUser?.sendEmailVerification();
        emit(SignUpState(isSignUpSuccess: true));
      } catch (e) {
        emit(SignUpState(error: e));
      }
    });

    on<SignInWithGoogle>((event, emit) async {
      try {
        // Show a loading indicator
        emit(SignInState(isLoading: true));

        // Start the Google sign-in process
        final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

        if (gUser == null) {
          // User cancelled the sign-in process
          throw Exception("Not logged in");
        }

        final GoogleSignInAuthentication gAuth = await gUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken,
          idToken: gAuth.idToken,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);
        emit(SignInState(isSignInSuccess: true));
      } catch (e) {
        // Handle exceptions
        emit(SignInState(error: e));
      } finally {
        // Hide the loading indicator
        emit(SignInState(isLoading: false));
      }
    });
  }
}
