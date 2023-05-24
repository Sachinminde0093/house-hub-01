
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:house_hub/core/failure.dart';
import 'package:house_hub/models/device_info.dart';
import 'package:house_hub/models/user.dart';
import 'package:house_hub/services/api/api_service.dart';
import 'package:house_hub/services/app/app_service.dart';
import 'package:house_hub/services/app/auth_service.dart';

import '../../../core/typedef.dart';

final AuthRepositoryProvider = Provider((ref) => AuthenticationRepository(ref.read(AuthenticationServiceProvider), ref.read(apiServiceProvider), ref.read(appServiceProvider)));

class AuthenticationRepository {
  final AuthenticationService authService;
  final ApiService apiService;
  final AppService appService;

  AuthenticationRepository(this.authService, this.apiService, this.appService,);
    FutureVoid  getOtp(String phone) async {
      try{
        return right(authService.getOtp(phone));
      }catch(e){
        return left(Failure(e.toString()));
      }
    }

  FutureEather<User?> verifyOtp(String otp, String phone) async{
      try{
        final res = await authService.verifyOtp(otp);
        return right(res.user);
      }catch(e){
      return left(Failure(e.toString()));
      }
    }

  FutureEather<UserModel> loginUser(String phone, String uid) async{
      try{
          DeviceInfoModel deviceInfoModel = await appService.di.getDeviceInfo();
          final data = {
            'uid':uid,
            'deviceId':deviceInfoModel.deviceId,
            'firebaseToken':deviceInfoModel.firebaseToken,
            'deviceModel':deviceInfoModel.deviceModel,
            'deviceOS':deviceInfoModel.deviceOs,
            'appVersion':deviceInfoModel.appVersion,
            'mobile':phone,
          };
          var response = await appService.api.authRoute.loginUser(data);
          var responseJson = response.data['data'];
      if(responseJson['accessToken'] != null) {
        await appService.db.putAccessToken(responseJson['accessToken']);
        await appService.db.putUser(UserModel.fromJson(responseJson['user']));
      }
      return right(UserModel.fromJson(responseJson['user']));
      }catch(e){
      return left(Failure(e.toString()));
      }
    }
}
