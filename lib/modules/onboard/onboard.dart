import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:house_hub/modules/onboard/controller.dart';
import 'package:house_hub/modules/widgets/input_box.dart';
import 'package:intl/intl.dart';


class OnBoard extends ConsumerStatefulWidget {
  const OnBoard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OnBoardState();
}

class _OnBoardState extends ConsumerState<OnBoard> {

  @override
  void initState() {
    // super.initState();
    // print(ref.read(appServiceProvider).db.accessToken);
    // print(ref.read(appServiceProvider).db.user!.birthdate!.toIso8601String());
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(onBoardControllerProvider);
    return Center(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40).copyWith(top: 100),
              child: Form(
                key: controller.onboardFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(child:  Text("Let's OnBoard" , style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)),
                    const SizedBox(height: 20,),
                    Container(
                      padding:const EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Name',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                    TextFormField(
                        controller: controller.nameController,
                            decoration:const InputDecoration(
                          isCollapsed: true,
                          filled: true,
                          // fillColor: Color(0xFF18191C),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          // helperText: 'Your birth date is by default hidden from public',
                          hintText: 'Enter Your Name',
                        ),
                            keyboardType: TextInputType.name,
                            // obscureText: true,
                            validator: (value) {
                              if(value==null){
                                return "Please enter your Name";
                              }
                              if (value.isEmpty) {
                                return 'Please enter your Name';
                              }
                              if (value.length < 2 ) {
                                return 'name must be greater than 2';
                              }
                              // if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value)) {
                              //   return 'Password must contain at least one uppercase letter, one lowercase letter, one symbol, and one number';
                              // }
                              return null ;// return null if the input is valid
                            },
                          ),
                        const SizedBox(height: 16,),

                        Container(
                      padding:const EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Permanent Adderess',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                        TextFormField(
                              // maxLines: 2,
                          controller:controller.addressController,
                          decoration:const InputDecoration(
                            isCollapsed: true,
                            filled: true,
                            // fillColor: Color(0xFF18191C),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            // helperText: 'Your birth date is by default hidden from public',
                            hintText: 'Enter Your Address',
                          ),
                          keyboardType: TextInputType.name,
                          // obscureText: true,
                          validator: (value) {
                            if(value==null){
                              return "Please enter your address";
                            }
                            if (value.isEmpty) {
                              return 'Please enter your address';
                            }
                            if (value.length < 5 ) {
                              return 'Address must be grater than 5 characters';
                            }
                            // if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value)) {
                            //   return 'Password must contain at least one uppercase letter, one lowercase letter, one symbol, and one number';
                            // }
                            return null ;// return null if the input is valid
                          },
                        ),
                        const SizedBox(height: 16,),
                        Container(
                          padding:const EdgeInsets.only(bottom: 8),
                          child: Text(
                            'Occupation',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                        DropdownButtonFormField(
                          dropdownColor: Theme.of(context).colorScheme.background,
                          items: const [
                            DropdownMenuItem(
                              value: 1,
                              child: Text('Student'),
                            ),
                            DropdownMenuItem(
                              value: 2,
                              child: Text('Owner'),
                            ),
                            DropdownMenuItem(
                              value: 3,
                              child: Text('Other'),
                            ),
                            // DropdownMenuItem(
                            //   value: -1,
                            //   child: Text('Prefer not to say'),
                            // ),
                          ],
                          onChanged: controller.onOccupationChanged,
                          value: controller.occupationCode,
                          decoration:const InputDecoration(
                            isCollapsed: true,
                            filled: true,
                            // fillColor: Color(0xFF18191C),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            // helperText: 'Your gender is hidden by default',
                            hintText: 'Pick your Occupation'
                          ),
                          validator: (value) {
                            if (value == null) {
                              return 'Please pick a Occupation';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16,),
                        Container(
                          padding:const EdgeInsets.only(bottom: 8),
                          child: Text(
                            'Gender',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                        DropdownButtonFormField(
                          dropdownColor: Theme.of(context).colorScheme.background,
                          items: const [
                            DropdownMenuItem(
                              value: 1,
                              child: Text('Male'),
                            ),
                            DropdownMenuItem(
                              value: 2,
                              child: Text('Female'),
                            ),
                            DropdownMenuItem(
                              value: 3,
                              child: Text('Other'),
                            ),
                            DropdownMenuItem(
                              value: -1,
                              child: Text('Prefer not to say'),
                            ),
                          ],
                          onChanged: controller.onGenderChanged,
                          value: controller.genderCode,
                          decoration:const InputDecoration(
                            isCollapsed: true,
                            filled: true,
                            // fillColor: Color(0xFF18191C),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            // helperText: 'Your gender is hidden by default',
                            hintText: 'Pick your gender'
                          ),
                          validator: (value) {
                            if (value == null) {
                              return 'Please pick a gender';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16,),
                        Container(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            'Birthdate',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      Container(
                        child: TextFormField(
                          controller: controller.birthdateController,
                          textCapitalization: TextCapitalization.words,
                          onTap: () {
                            Get.bottomSheet(
                              Container(
                                height: Get.height / 2.5, 
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children:  <Widget>[
                                          TextButton(
                                            child: const Text(
                                              "Cancel",
                                            ),
                                            onPressed: () => Get.back(),
                                          ),
                                          TextButton(
                                            child: const Text(
                                              "Done",
                                            ),
                                            onPressed: () {
                                              controller.birthdate = controller.tempBirthdate;
                                              controller.birthdateController.text =  DateFormat('dd MMMM yyyy').format(controller.birthdate);
                                              Get.back();
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  
                      Expanded(
                          child: DefaultTextStyle(
                          style: const TextStyle(color: Colors.blue), // Customize date picker text color
                            child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.date,
                            maximumYear: 2010,
                            initialDateTime: controller.birthdate,
                            onDateTimeChanged: (date) {
                              controller.tempBirthdate = date; 
                            }
                          ),),
                          )
                          ],
                        )  
                      ),
                            backgroundColor: const Color(0xFF18191C),
                          );
                        },
                        readOnly: true,
                        decoration: const InputDecoration(
                          isCollapsed: true,
                          filled: true,
                          // fillColor: Color(0xFF18191C),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          // helperText: 'Your birth date is by default hidden from public',
                          hintText: 'Pick your birthdate',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please pick your birthdate';
                          }
                          return null;
                        },
                      ),
                    ),
                        const SizedBox(height: 16,),
                        Stack(
                          children:[
                            Image.asset("assets1/png/onboard.png",),
                              Positioned(
                                right:45,
                                bottom: 130,
                                child: ElevatedButton(onPressed: (){
                                  if(controller.onboardFormKey.currentState!.validate()){
                                    controller.updateType();
                                  }
                                    }, child:const Text("Next")),
                              ),
                          ]
                        )
                        // Image.asset('assets1/png/login.png')
                  ],
                
              )),
            ),
          ),
        ),
      )
    );
  }
}