//Sdk Dependancy
import 'package:flutter/material.dart';
import 'package:house_hub/core/translations/strings.dart';

//Internal Dependancy


class Loading extends StatelessWidget {
  final String? title;
  const Loading({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          SizedBox(height: 20, width: 20, child: CircularProgressIndicator()),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Text(
              (title ?? Strings.Loading) + '...',
              style: TextStyle(
                fontSize: 16
              ),
            ),
          ),
        ],
      ),
    );
  }
}