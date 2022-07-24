import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/feature/auth/repositry/auth_repository.dart';
import 'dart:io';

import 'package:whatsapp_ui/model/usermodel.dart';
final authControllerProvider = Provider((ref) {
  final authProvider = ref.watch(authRepositoryProvider);
  ///watch is like Provider.of<AuthRepository>(context);
    return AuthController(authRepository: authProvider,ref: ref);
});

final userDataAuthProvider  = FutureProvider((ref) {
    final authController = ref.watch(authControllerProvider);
    return authController.getUserData();
});
class AuthController{
    final AuthRepository authRepository;
    final ProviderRef ref;
  AuthController( {required this.authRepository,required this.ref});


  Future<UserModel?> getUserData()async{
        UserModel? user = await authRepository.getCurrentUserData();
        return user;
  }

  void signInWithPhoneNumber(BuildContext context,String phoneNumber){
      authRepository.signInWithPhone(context, phoneNumber);
  }

  void verifyOtp(BuildContext context,String verficationId, String otp){
      authRepository.verify_Otp(
          context: context,
          userOtp: otp,
          verificationId: verficationId
      );
  }

  void saveUserToDatabase({BuildContext? context, String?name, File?profilePic}){
        authRepository.saveUserToDataBase(
            name: name.toString(),
            profilePic: profilePic,
            ref: ref,
            context: context!,
        );
  }

  Stream<UserModel> userDataById(String userId){
      return authRepository.userData(userId);
  }
}