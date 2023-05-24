import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_hub/modules/location_permission.dart/controller.dart';
import 'package:lottie/lottie.dart';


class Location extends ConsumerWidget {
  const Location({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(getLocationControllerProvider);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0).copyWith(bottom: 30),
          child: Column(
            children: [
              const  SizedBox(height: 100,),
              const Text("Welcome to House Hub", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 30, 121, 100)),),
              Lottie.asset(
                  'assets1/animation_icons/location.json',
                  reverse: true,
                  animate: true,
                ),
                const Spacer(),
                ElevatedButton(onPressed: ()=> controller.onGrantPermissionTap(), child: const Text("Allow Permission")),
                const SizedBox(height: 30,),

                Text("We would like to request your permission to access your location. By granting us access to your location, we can offer personalized features and services tailored to your current whereabouts. Rest assured that we prioritize your privacy and will only use your location data for the intended purposes mentioned in our privacy policy.",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,),  
            ],
          ),
        ),
      ),
    );
  }
}