import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_hub/services/api/api_service.dart';
import 'package:house_hub/services/app/database_service.dart';
import 'package:house_hub/services/app/device_info.dart';

import '../route/route_paths.dart';
import 'location.dart';
import 'messagin_service.dart';

final appServiceProvider = Provider((ref) => AppService(ref));

class AppService {

  AppService(this.ref);

  final Ref ref;

  Future<AppService> init() async {
    await initiateServices();
    return this;
  }
  
  Future<void> initiateServices() async {

    // ms = await MessagingService().init();
    db = await  DatabaseService().init();
    di = await DeviceInfoService().init();
    api = await ApiService().init(this);
    gl = await GeolocationService().init(api: api, db: db);


  //   cf = await Get.putAsync(() => ConfigurationService().init());

  //   th = await Get.putAsync(() => ThemeService().init());
    
  //   lc = await Get.putAsync(() => LocaleService().init());

  //   an = await Get.putAsync(() => AnalyticsService().init());

      // await ms.init();
      // await di.init();   
      // await db.init();
  //   at = await Get.putAsync(() => AuthenticationService().init());
      // await as.init(this);
  }
  // late MessagingService ms;
  late DatabaseService db;
  late ApiService api;
  late DeviceInfoService di;
  late Routes routes;
  late GeolocationService gl;
  
  // late ConfigurationService cf;
  // late ThemeService th;
  // late LocaleService lc;
  // late AnalyticsService an;
  // late GeolocationService gl;
  
  // late AuthenticationService at;

  void onClose(){

  }

}