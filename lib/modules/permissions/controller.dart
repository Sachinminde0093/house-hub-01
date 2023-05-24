import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:house_hub/core/enums.dart';
import 'package:house_hub/core/providers/toast.dart';
import 'package:house_hub/modules/permissions/repository.dart';
import 'package:house_hub/modules/widgets/dialog/dialog.dart';
import 'package:house_hub/services/app/app_service.dart';
import '../../services/route/route_paths.dart';

final permissionControllerProvider = Provider((ref) => PermissionController(ref.read(appServiceProvider),repository: ref.read(permissionRepositoryProvider)));

class PermissionController{

  PermissionController(this.ap, {required this.repository});
  final PermissionRepository repository;
  final AppService ap;

  int? selectedOption;
  bool? isChecked = false;
  


  void onRoleChange(int? value){
    selectedOption = value;
  }

  void updateType()async{
      AppDialog.loading();
      var res = await repository.updateType(userRole[selectedOption!]);
    res.fold((l) 
    {
      Get.back();
      Toast.show(l.message);
    }
      , (r) {
          ap.db.putUser(r);
          print(ap.db.user);
          Get.toNamed(Routes.home);
        }
      );
  }

void validate(){
    if(selectedOption == null){
      Toast.show("Select your role");
    }
    else if(isChecked == false){
      Toast.show("Accept terms and condition"); 
    }else{
      updateType();
    }
  }
}