
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';
import 'package:house_hub/modules/authentication/screens/login_screen.dart';
import 'package:house_hub/modules/authentication/screens/start_screen.dart';
import 'package:house_hub/modules/authentication/screens/verify_otp.dart';
import 'package:house_hub/modules/home/home.dart';
import 'package:house_hub/modules/location_permission.dart/location.dart';
import 'package:house_hub/modules/onboard/onboard.dart';
import 'package:house_hub/modules/permissions/permission.dart';
import 'package:house_hub/services/app/app_service.dart';
import 'package:house_hub/services/app/database_service.dart';

import 'middlewares/middlewares.dart';

List<GetPage> loggedInrout(AppService ap){
  return [


GetPage(name: '/', page: () => const StartScreen(),
),
// GetPage(name: '/start', page: () => const Start(),),
GetPage(name: '/login', page: () => const  Login()),
GetPage(name: '/verify-otp', page: () => const  VerifyOtp()),
GetPage(name: '/on-board', page: () => const  OnBoard()),
GetPage(name: '/permission', page: () => const  Permissions()),
GetPage(name: '/location', page: () => const  Location()),
GetPage(name: '/home', page: () => const  Home(),
middlewares: [
  EnsureAuthMiddleware(ap.db),
]),
// GetPage(name: '/home', page: () => const Home(),),
// GetPage(name: '/contests/:Id', page: () => const  MatchPreview()),
// GetPage(name: '/contest-preview/:Id', page: () => const  ContestPreview()),
// GetPage(name: '/mycontest-preview/:Id', page: () => const MyContestPreview()),
// GetPage(name: '/myteam-preview/:Id', page: () => const MyContestPreview()),
// GetPage(name: '/createTeam', page: () => const CreateTeam()),
];
} 

// final loggedInrout = [


// GetPage(name: '/', page: () => const StartScreen(),
// ),
// // GetPage(name: '/start', page: () => const Start(),),
// GetPage(name: '/login', page: () => const  Login()),
// GetPage(name: '/verify-otp', page: () => const  VerifyOtp()),
// GetPage(name: '/on-board', page: () => const  OnBoard()),
// GetPage(name: '/permission', page: () => const  Permissions()),
// GetPage(name: '/location', page: () => const  Location()),
// GetPage(name: '/home', page: () => const  Home(),
// middlewares: [
//   EnsureAuthMiddleware().init(),
// ]),
// // GetPage(name: '/home', page: () => const Home(),),
// // GetPage(name: '/contests/:Id', page: () => const  MatchPreview()),
// // GetPage(name: '/contest-preview/:Id', page: () => const  ContestPreview()),
// // GetPage(name: '/mycontest-preview/:Id', page: () => const MyContestPreview()),
// // GetPage(name: '/myteam-preview/:Id', page: () => const MyContestPreview()),
// // GetPage(name: '/createTeam', page: () => const CreateTeam()),
// ];


final middleware = [
  GetMiddleware(

  ),
];