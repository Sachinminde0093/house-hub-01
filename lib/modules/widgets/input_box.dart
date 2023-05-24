import 'package:flutter/material.dart';

class InputBox extends StatelessWidget {
  const InputBox({super.key,  this.lable,required this.textFormField, this.color,});
  final Color? color;
  final TextFormField textFormField;
  final Text?  lable;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: lable,
        ),
        const SizedBox(height: 8,),
        Container(            
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),
          // color:color?? const Color.fromARGB(255, 93, 247, 219),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 2),
            child: textFormField,
          ))
      ],
    );
  }
}