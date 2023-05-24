import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:house_hub/core/providers/toast.dart';
import 'package:house_hub/core/typedef.dart';
import 'package:house_hub/modules/authentication/repository/auth_repository.dart';
import 'package:house_hub/modules/widgets/dialog/dialog.dart';
import 'package:riverpod/riverpod.dart';

import '../../../services/route/route_paths.dart';


final AuthControllerProveder = Provider((ref) =>AuthController(authRepository: ref.read(AuthRepositoryProvider)));

class AuthController{

  final AuthenticationRepository _authRepository;

  AuthController({required authRepository}): _authRepository = authRepository;

  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

final phonFormKey = GlobalKey<FormState>();
final otpFormKey = GlobalKey<FormState>();  
// final _formKey = GlobalKey<FormState>(); 
String selectedCountryCode = '+91';


void getOtp() async{
  AppDialog.loading();
  final res =  await  _authRepository.getOtp('$selectedCountryCode ${phoneController.text}');
  res.fold((l) {
    Get.back();
    Toast.show(l.message);
  }, (r) {
    Get.back();
    Toast.show("Otp is send on  check your mobile and enter 6 digit code");
    Get.toNamed(Routes.verifyOtp);
  });
}

void verifyOtp() async{
    AppDialog.loading();
    final user = await _authRepository.verifyOtp(otpController.text,'$selectedCountryCode ${phoneController.text}');

  user.fold((l) {
      Toast.show(l.message);
  }, (r) async{

    if(r != null){
      var res = await _authRepository.loginUser('$selectedCountryCode ${phoneController.text}', r.uid);
      res.fold((l) {
          Get.back();
          Toast.show(l.message);
        },(userModel) {
            // Get.back();
            if(userModel.isBirthdateAvailable){
              Get.toNamed(Routes.onBoard);
            }else{
              Get.toNamed(Routes.home);
            }
        });
    }else{
      Toast.show('User authentication failed.');
    }

      
  });

    
}

}


