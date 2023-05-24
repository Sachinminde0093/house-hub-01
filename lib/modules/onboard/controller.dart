import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:house_hub/core/enums.dart';
import 'package:house_hub/models/user.dart';
import 'package:house_hub/modules/onboard/repository.dart';
import '../../core/providers/toast.dart';
import '../../services/route/route_paths.dart';
import '../widgets/dialog/dialog.dart';

final onBoardControllerProvider = Provider((ref) => OnBoardController(repository: ref.read(onBoardRepositoryProvider)));

class OnBoardController{


  OnBoardController({required this.repository});
  final OnBoardRepository repository;

  int? genderCode;
  int? occupationCode;

  final nameController = TextEditingController();
  final birthdateController = TextEditingController();
  final addressController = TextEditingController();
  // final occupationController = TextEditingController();
  final onboardFormKey = GlobalKey<FormState>();

  void onGenderChanged(int? value) {
    genderCode = value;
  } 
  
  void onOccupationChanged(int? value) {
    occupationCode = value;
  }

  final _birthdate = DateTime(2000).obs;
  set birthdate(value) => _birthdate.value = value;
  DateTime get birthdate => _birthdate.value;

  var tempBirthdate = DateTime(2000);

  void updateType()async{
      AppDialog.loading();
      var res = await repository.onboardUser(nameController.text,birthdate.toIso8601String(),addressController.text,userRole[occupationCode!],genderCode!);
      res.fold((l) {
        Get.back();
        Toast.show(l.message);
      } , (r) => Get.toNamed(Routes.permission) );
  }

  bool isDateValid(String dateStr) {
  try {
    // DateTime.parse(dateStr);
    return true;
  } catch (e) {
    return false;
  }
}

}