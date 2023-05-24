//Sdk Dependancy
import 'dart:ui';

import 'package:flutter/material.dart';

//Package Dependancy
import 'package:get/get.dart';

//Internal Dependancy
import '../dialog/alert/ui.dart';
import './loading/ui.dart';

class AppDialog{
  
  static Future<T?> dialog<T>({required Widget Function(BuildContext, Animation<double>, Animation<double>) pageBuilder}) async{
    return await Get.generalDialog(
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black38,
      transitionDuration: Duration(milliseconds: 50),
      pageBuilder: pageBuilder,
      transitionBuilder: (ctx, animation1, animation2, child) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1.5 * animation1.value, sigmaY: 1.5 * animation1.value),
        child: ScaleTransition(
          child: child,
          scale: animation1,
        ),
      ),
    );
  }

  static Future<bool> alert<bool>({required Widget title, required Widget content, String? confirmText, String? denyText}) async{
    return await dialog(
      pageBuilder: (context, animation1, animation2) => Alert(
        title: title,
        content: content,
        confirmText: confirmText,
        denyText: denyText,
      ),
    ) ?? false;
  }

  static Future<T?> loading<T>({String? title}) async{
    return await dialog(
      pageBuilder: (context, animation1, animation2) => Loading(
        title: title,
      ),
    );
  }

}