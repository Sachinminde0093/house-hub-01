import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:house_hub/services/route/route_paths.dart';



class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size =  MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Divider(height: size.height * 0.3,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Image.asset('assets1/png/start.png'),
          ),
    
          const SizedBox(height: 100,),
          const Text("Get your shelter today!",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

          const SizedBox(height: 20,),
          const Text("Find your favorite and affordable homes today.", style: TextStyle(fontSize: 18),),
          const SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity, // sets width to maximum screen width
            child: ElevatedButton(
              onPressed: () {
                // do something
                Get.toNamed(Routes.login);
              },
              child: Text('Get Started'),
            ),
          )
        ],
      ),
    );
  }
}