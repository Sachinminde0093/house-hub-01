import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:house_hub/core/enums.dart';
import 'package:house_hub/modules/permissions/controller.dart';
import 'package:lottie/lottie.dart';

class Permissions extends ConsumerStatefulWidget {
  const Permissions({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PermissionsState();
}

class _PermissionsState extends ConsumerState<Permissions> {
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final controller = ref.read(permissionControllerProvider);
    return Center(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30.0).copyWith(top: 120),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(child:  Text("Few More Things" , style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)),
                    const SizedBox(height: 20,),
                    Container(
                          padding:const EdgeInsets.only(bottom: 8),
                          child: Text(
                            'Who you are?',
                            style: Theme.of(context).textTheme.bodyLarge,
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
                          onChanged:(value) {
                            setState(() {
                            controller.onRoleChange(value);
                            });
                          },
                          value: controller.selectedOption,
                          decoration:const InputDecoration(
                            isCollapsed: true,
                            filled: true,
                            // fillColor: Color(0xFF18191C),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            // helperText: 'Your gender is hidden by default',
                            hintText: 'Pick your Role'
                          ),
                          validator: (value) {
                            if (value == null) {
                              return 'Please pick a Role';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16,),
                    const SizedBox(height: 100,),
                    
                        Image.asset("assets1/png/onboard.png",),
                        const SizedBox(height: 10,),
                        Row(children: [
                        Checkbox(
                        value: controller.isChecked,
                        onChanged: (newValue) {
                          setState(() {
                            controller.isChecked = newValue;
                          });
                        }),
                        const SizedBox(width: 2,),
                        const Text('Agree to accept Terms and Conditions'),
                        ],),
                        const SizedBox(height: 2,),
                        Center(child:controller.selectedOption == null ?  const ElevatedButton(onPressed:null, child: Text("Select your role")) : ElevatedButton(onPressed: () => controller.validate(), child: Text("Continue as ${userRole[controller.selectedOption!-1].capitalize}"))),
                        const SizedBox(height: 15,),  // Image.asset('assets1/png/login.png')
                        
                  ],)
                ),
            ),
          ),
        ),
      )
    );
  }
}