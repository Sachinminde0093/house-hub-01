
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';
import 'package:house_hub/services/app/database_service.dart';
import 'package:house_hub/services/route/route_paths.dart';

class EnsureAuthMiddleware extends GetMiddleware {

  final DatabaseService db;

  EnsureAuthMiddleware(this.db);

  // Future<void> init() async{
  //   db = await DatabaseService().init();
    
  // }
  // late DatabaseService db;

  @override
  RouteSettings? redirect(String? route) {
    var isAccessTokenAvailable = db.accessToken != null;
    if(isAccessTokenAvailable) {
      var user = db.user;
      if(user == null) return const RouteSettings(name: Routes.start);
      if(user.isBirthdateAvailable) {
        if(user.type != null) {
          var isLocationPageShown = db.isLocationScreenShown;
          if(isLocationPageShown??false) {
            return null;
            // if(user.campusId != null) {
            //   return null;
            // }else {
            //   return RouteSettings(name: Routes.selectCampus);
            // }
          } else {
            return const RouteSettings(name: Routes.location);
          }
        }else {
          return const RouteSettings(name: Routes.permission);
        }
      }else {
        return const RouteSettings(name: Routes.onBoard);
      }
    }else {
      return const RouteSettings(name: Routes.start);
    }
  }
}
