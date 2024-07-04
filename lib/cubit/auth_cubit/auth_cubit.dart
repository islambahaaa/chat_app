import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> registerUser(
      {required String email, required String password}) async {
    emit(RegisterLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        emit(RegisterFailure(errMessage: 'Email already in use'));
      } else if (e.code == 'weak-password') {
        emit(RegisterFailure(
            errMessage: 'Weak passoword ,try something stronger :)'));
      } else {
        emit(RegisterFailure(errMessage: e.code));
      }
    }
  }
  ////////////////////////////////////////////////////////////////////////////

  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailure(errMessage: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(
            LoginFailure(errMessage: 'Wrong password provided for that user.'));
      } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        emit(LoginFailure(errMessage: 'Wrong Email or Password'));
      } else {
        emit(LoginFailure(errMessage: e.code));
      }
    } catch (ex) {
      emit(LoginFailure(errMessage: 'there was an error'));
    }
  }
}
