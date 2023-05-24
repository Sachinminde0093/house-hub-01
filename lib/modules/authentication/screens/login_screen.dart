import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:house_hub/services/route/route_paths.dart';
import 'package:house_hub/modules/authentication/controller/auth_controller.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {

@override
void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
  final authController = ref.read(AuthControllerProveder);
  final size =  MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Divider(height: size.height * 0.12,),
                
              const Text("Login", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
              const SizedBox(height: 20,),

              CountryCodePicker(
                  onChanged: (value) {
                    authController.selectedCountryCode = value.toString();
                  },
                  // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                  initialSelection: 'IN',
                  favorite: ['+91','FR'],
                  // optional. Shows only country name and flag
                  showCountryOnly: false,
                  // optional. Shows only country name and flag when popup is closed.
                  showOnlyCountryWhenClosed: false,
                  // optional. aligns the flag and the Text left
                  alignLeft: false,
                ),
              Row(
                children: [
                  
                  Form(
                    key:authController.phonFormKey ,
                    child: Expanded(
                      child: TextFormField(
                        controller: authController.phoneController,
                        decoration: InputDecoration(
                          labelText: 'Number',
                          hintText: 'Enter your Number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        // obscureText: true,
                        validator: (value) {
                          if(value==null){
                            return "Please enter your Number";
                          }
                          if (value.isEmpty) {
                            return 'Please enter your Number';
                          }
                          if (value.length < 10 ) {
                            return 'Number must be at least 10 characters long';
                          }
                          // if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value)) {
                          //   return 'Password must contain at least one uppercase letter, one lowercase letter, one symbol, and one number';
                          // }
                          return null ;// return null if the input is valid
                        },
                      ),
                    ),
                  ),
                ],
              ),
          
              Container(
                margin:const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  width: double.infinity,
                  height: 50, // sets width to maximum screen width
                  child: ElevatedButton(
                    onPressed: () {
                      // do something
                    if(authController.phonFormKey.currentState!.validate()){
                      authController.getOtp();
                    }

                      // Get.toNamed(Routes.verifyOtp);
                    },
                    child: const Text('Get Otp', style: TextStyle(fontSize: 18),),
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