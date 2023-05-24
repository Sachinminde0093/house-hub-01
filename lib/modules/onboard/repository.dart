import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:house_hub/core/failure.dart';
import 'package:house_hub/core/typedef.dart';
import 'package:house_hub/services/app/app_service.dart';

import '../../models/user.dart';

final onBoardRepositoryProvider = Provider((ref) => OnBoardRepository(appService: ref.read(appServiceProvider)));

class OnBoardRepository{

  final AppService appService;

  OnBoardRepository( {required this.appService});

  FutureEather<UserModel> onboardUser(String name, String date, String address, String occupation, int gender) async{
    try{
      var data = {
        'name':name,
        'birthdate':date,
        'address':address,
        'gender':gender,
        'occupation':occupation
      };
      var res = await appService.api.userAPI.onboardUser(data);
        var resJson = res.data['data'];
        return right(UserModel.fromJson(resJson['user']));
    }catch(e){
      return left(Failure(e.toString()));
    }
  }
}