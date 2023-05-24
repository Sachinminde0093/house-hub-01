//Sdk Dependancy
import 'package:flutter/material.dart';

//Package Dependancy
import 'package:get/get.dart';

//Internal Dependancy
import 'package:house_hub/core/translations/strings.dart';


class Alert extends StatelessWidget {
  final Widget title;
  final Widget content;
  final String? confirmText;
  final String? denyText;
  const Alert({Key? key, required this.title, required this.content, this.confirmText, this.denyText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: content,
      actions: [
        Visibility(
          visible: denyText != '',
          child: TextButton(
            child: Text(
              denyText ?? Strings.Cancel.toUpperCase(),
            ),
            onPressed: ()=> Get.back(result: false),
          ),
        ),
        TextButton(
          child: Text(
            confirmText ?? Strings.Ok.toUpperCase(),
          ),
          onPressed: ()=> Get.back(result: true),
        )
      ],
    );
  }
}