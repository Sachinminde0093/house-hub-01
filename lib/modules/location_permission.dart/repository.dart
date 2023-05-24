import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:house_hub/core/failure.dart';
import 'package:house_hub/core/typedef.dart';
import 'package:house_hub/services/api/api_service.dart';
import 'package:house_hub/services/app/app_service.dart';

import '../../core/providers/toast.dart';

final getLocationRepositoryProvider = Provider((ref) => GetLocationRepository(ref.read(appServiceProvider).api));

class GetLocationRepository {

  GetLocationRepository(this.api);

  final ApiService api;

  FutureEather<bool> updateLocation(String location) async {
    try {
      var response = await api.userAPI.updateLocation(location: {'location':location});
      if(response.data['data'] != null) {
        return right(true);
      } else {
        return right(false);
      }
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}