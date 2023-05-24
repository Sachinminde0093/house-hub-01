import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:house_hub/services/app/app_service.dart';
import 'package:house_hub/services/route/routes.dart';

import 'firebase_options.dart';
import 'observer.dart';


Future<void> main() async {

final observer = AppLifecycleObserver();

  WidgetsFlutterBinding.ensureInitialized().addObserver(observer);
  
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);

  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
    androidProvider: AndroidProvider.debug,
  );

  // SystemChrome.setSystemUIOverlayStyle( const SystemUiOverlayStyle(
  //   statusBarColor: Colors.transparent // Set the color of the status bar
  // ));

 // Create a ProviderContainer and initialize the DeviceInfoService
  final container = ProviderContainer();
  await container.read(appServiceProvider).init();
  // await container.read(apiServiceProvider).init();

  // final appService = container.read(appServiceProvider);
  // final apiService = container.read(apiServiceProvider(appService: appService));

  runApp(ProviderScope(
    parent: container,
    child:  Phoenix(
      child: const MyApp(),
    ),
  ));
}

class TempContext {
  static late BuildContext context;
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
        getPages:loggedInrout(ref.read(appServiceProvider)),
    );
}
}


// class MyApp extends ConsumerWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {

//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/',
//         getPages:loggedInrout,
//     );
//   }
// }



// class MyApp extends StatelessWidget {
//     MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/',
//         getPages:loggedInrout,
//     );
    
// home: Scaffold(
  
//   body: SafeArea(

//       child:Container(
//            height: MediaQuery.of(context).size.height * 0.5, // Set the height to half of the screen height
//             color: Colors.blue, // Set the background color
//           ),
      
      
//       //  Column(children: [
          
//       // ElevatedButton(onPressed: (){
//       //   authenticationService.getOtp('+919373170518');
//       // }, child: Text("Get otp")),
//       // ElevatedButton(onPressed: (){
//       //   authenticationService.verifyOtp('355367');
//       // }, child: Text("verify otp")),
      
//       // ],),
//     )),
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(child: MyArc(diameter: 300,));
//   }
// }


// class MyArc extends StatelessWidget {
//   final double diameter;

//   const MyArc({super.key, this.diameter = 200});

//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       painter: MyPainter(),
//       size: Size(diameter, diameter),
//     );
//   }
// }


// // This is the Painter class
// class MyPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()..color = Colors.blue;
//     canvas.drawArc(
//       Rect.fromCenter(
//         center: Offset(size.height / 2, size.width / 2),
//         height: size.height,
//         width: size.width,
//       ),
//       math.pi,
//       math.pi,
//       false,
//       paint,
//     );
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }