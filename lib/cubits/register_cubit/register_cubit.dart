import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  Future<void> registerUser(
      {required String email, required String password}) async {
    emit(RegisterLoding());
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFauiler(eMessage: 'Weak password'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFauiler(eMessage:'Email is used'));
      }
    } on Exception catch (_) {
      emit(RegisterFauiler(eMessage: 'Something Wrong'));
    }
  }
}
