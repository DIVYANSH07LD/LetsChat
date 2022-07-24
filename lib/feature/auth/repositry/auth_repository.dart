import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/common/firebase_repository/firebase_storage_repository.dart';
import 'package:whatsapp_ui/model/usermodel.dart';
import 'package:whatsapp_ui/screens/mobile_layout_screen.dart';
import 'package:whatsapp_ui/screens/otpscreen.dart';
import 'package:whatsapp_ui/screens/user_screen.dart';

import '../../../common/utils/snackbar.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
    auth: FirebaseAuth.instance,
    firebaseFirestore: FirebaseFirestore.instance
    )
);

class AuthRepository{
        final FirebaseAuth  auth;
        final FirebaseFirestore firebaseFirestore;
        AuthRepository({
          required this.auth,
          required this.firebaseFirestore
        });

      Future<UserModel?> getCurrentUserData()async{
          var userData = await firebaseFirestore.collection('users').doc(auth.currentUser?.uid).get();
          UserModel? user;
          if(userData.data()!=null){
              user = UserModel.fromMap(userData.data()!);
          }
          return user;
      }

        void signInWithPhone(BuildContext context,String phonenumber)async{
          try{
                await auth.verifyPhoneNumber(
                    phoneNumber: phonenumber,
                    verificationCompleted: (PhoneAuthCredential credential)async{
                          await auth.signInWithCredential(credential);
                    },
                    verificationFailed: (PhoneVerificationFailed){
                      throw Exception(PhoneVerificationFailed.message);
                    },timeout: Duration(seconds: 30),
                    codeSent:(String verificationId,int? resendtoken) async {
                      Navigator.pushNamed(context,OtpScreen.routeName,arguments: verificationId);
                    },
                    codeAutoRetrievalTimeout: (String verificationId){

                    });
          }
          on FirebaseAuthException catch(e){
            showSnackBar(context: context, content: e.message.toString());
          }
              catch(e){
                showSnackBar(context: context,content: e.toString());
              }
        }

        void verify_Otp({required BuildContext context,required String verificationId,required String userOtp})async{
              try{
                PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: userOtp,);
                      await auth.signInWithCredential(phoneAuthCredential);

                      await Navigator.pushNamedAndRemoveUntil(context, UserScreen.routeName,(route)=>false);
              }
                  on FirebaseAuthException catch(e){
                              showSnackBar(context: context, content: e.message.toString());
                  }
        }

        void saveUserToDataBase({
          required String name,
          required File? profilePic,
          required ProviderRef ref,
          required BuildContext context
          })async{
          try{
              String uid = auth.currentUser!.uid;
              String photoUrl = "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png";

              if(profilePic!=null)
          {
             String photoUrl = await ref.read(commonFirebaseStorageRepositoryProvider).storeFileToStorage('ProfilePic/$uid',profilePic);

          }
              var user = UserModel(
                  proficPic: photoUrl.toString(),
                  username: name,
                  uid: uid,
                  isOnline: true,
                  userPhone: auth.currentUser!.phoneNumber.toString(),
                  groupId: []
              );
              // firebaseFirestore.collection('users').doc(uid).set(user.toMap());
              firebaseFirestore.collection('users').doc(uid).set(user.toMap());
                  Navigator.pushNamedAndRemoveUntil(context, MobileLayoutScreen.routeName, (route) => false );
          }
          catch(e){
            showSnackBar(context: context, content: e.toString());
          }
        }


      Stream<UserModel> userData(String userId){
          return firebaseFirestore.collection('users').doc(userId).snapshots().map((event) => UserModel.fromMap(event.data()!));
        }
}