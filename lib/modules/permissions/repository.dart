

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:house_hub/core/failure.dart';
import 'package:house_hub/core/typedef.dart';
import 'package:house_hub/services/app/app_service.dart';

import '../../models/user.dart';

final permissionRepositoryProvider = Provider((ref) => PermissionRepository(appService: ref.read(appServiceProvider)));

class PermissionRepository{

  final AppService appService;

  PermissionRepository( {required this.appService});

  FutureEather<UserModel> updateType(String type) async{
    try{
      var res = await appService.api.userAPI.updateType({'type': type});
        var resJson = res.data['data'];
        return right(UserModel.fromJson(resJson['user']));
    }catch(e){
      return left(Failure(e.toString()));
    }
  }
}