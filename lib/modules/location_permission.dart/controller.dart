import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:house_hub/core/providers/toast.dart';
import 'package:house_hub/modules/location_permission.dart/repository.dart';
import 'package:house_hub/services/app/app_service.dart';
import 'package:house_hub/services/app/location.dart';

import '../../services/route/route_paths.dart';
import '../widgets/dialog/dialog.dart';


final getLocationControllerProvider = Provider<GetLocationController>((ref) {
  return GetLocationController()..onInit(ref.read(appServiceProvider), ref.read(getLocationRepositoryProvider));
});

class GetLocationController extends StateNotifier<bool>{

  GetLocationController(): super(true);

  late AppService as;
  late GetLocationRepository repository;
  
  GeolocationService geolocationService = GeolocationService();


  Future<GetLocationController> onInit(AppService as,GetLocationRepository repository) async {
    // geolocationService = GeolocationService();
    this.as = as;
    this.repository = repository;
    // listener = Geolocator.getServiceStatusStream().listen(onStatusChanged);
    permissionGranted = await as.gl.isPermissionGranted();
    state = false;
    return this;
    // if(permissionGranted) onContinueTap();
  }

  void onClose() {
    listener?.cancel();
  }

  // var gl = Get.find<GeolocationService>();

  var permissionGranted = false;
  StreamSubscription<ServiceStatus>? listener;
  var loadingLocation = false;

  void onGrantPermissionTap() async {
    var hasPermission = await as.gl.getPermission();
    permissionGranted = hasPermission;
    state = true;
    if(permissionGranted) onContinueTap();
  }

  void onContinueTap() async {
    loadingLocation = true;
    state = false;
    // an.sendEvent('location_permission_tap');
    var position = await as.gl.determinePosition(forceTurnOnLocation: true);
    AppDialog.loading();
    if(position != null) {
      var res = await repository.updateLocation([position.latitude, position.longitude].join(','));
      res.fold((l) => Toast.show(l.message), (r) =>null);
      // an.sendEvent('location_permission_success');
    }
    Get.back();
    loadingLocation = false;
    state = false;
    // an.sendEvent('location_permission_faiilure');
    await as.db.putIsLocationScreenShown(true);
    Get.offAndToNamed(Routes.home);
  }

  void onStatusChanged(ServiceStatus status) {
    if(status == ServiceStatus.enabled) {
      onContinueTap();
    }
  }

}