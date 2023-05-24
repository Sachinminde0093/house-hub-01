import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_hub/modules/authentication/controller/auth_controller.dart';

class VerifyOtp extends ConsumerWidget {
  const VerifyOtp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size =  MediaQuery.of(context).size;
    final controller = ref.read(AuthControllerProveder);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Divider(height: size.height * 0.2,),
                
              const Text("Verification code", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
              const SizedBox(height: 20,),
              Form(
                key: controller.otpFormKey,
                child: TextFormField(
                  controller: controller.otpController,
                  decoration: InputDecoration(
                    labelText: 'Otp Verification',
                    hintText: 'Enter your Otp',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  // obscureText: true,
                  validator: (value) {
                    if(value==null){
                      return "Enter your 6 digit otp";
                    }
                    if (value.isEmpty) {
                      return 'Enter your Otp';
                    }
                    if (value.length != 6 ) {
                      return 'Otp should be of 6 digit';
                    }
                    // if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value)) {
                    //   return 'Password must contain at least one uppercase letter, one lowercase letter, one symbol, and one number';
                    // }
                    return null ;// return null if the input is valid
                  },
                ),
              ),
          
              Container(
                margin:const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  width: double.infinity,
                  height: 50, // sets width to maximum screen width
                  child: ElevatedButton(
                    onPressed: () {
                      // do something
                      if(controller.otpFormKey.currentState!.validate()){
                          controller.verifyOtp();
                      }
                    },
                    child: const Text('Verify Otp', style: TextStyle(fontSize: 18),),
                  ),
                ),
                const SizedBox(height: 50,),
                Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Image.asset('assets1/png/login.png'),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}