import 'package:airplane/core/utils/app_strings.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

import '../../../models/user_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  Future<void> loginWithEmailAddPassword(String email, String password) async {
    emit(LoginLoadingState());
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((user) {
      checkUserData(uId: user.user!.uid);

    })
        .catchError((onError) {
      emit(LoginFailureState(onError.toString()));
    });
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    try{
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((user) {
         checkUserData(uId: user.user!.uid);
      });
    }catch(error){

    }

  }

  Future<void> checkUserData({required String uId}) async {
    FirebaseFirestore.instance
        .collection(AppStrings.users)
        .doc(uId)
        .get()
        .then((value) {
          if(value.exists){
            UserModel userModel = UserModel.fromJson(value.data()!);
            if(userModel.isAdmin == true){
              emit(LoginSuccessState(true , true));
            }else{
              emit(LoginSuccessState(true,false));
            }
          }else{
            emit(LoginSuccessState(false,false));
          }
    });
  }
}
