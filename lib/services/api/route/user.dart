
import 'package:dio/dio.dart';

class UserAPI{

  final Dio dio;
  UserAPI(this.dio);
  
  Future<Response<dynamic>> onboardUser(Object body) async {
    try {
      return await dio.patch(
        '/user',
        data: body,
      );
    } catch (e) {
      rethrow;
    }
  }


  Future<Response<dynamic>> updateType(Object body) async {
      try {
        return await dio.patch(
          '/user/role',
          data: body,
        );
      }catch (e) {
        rethrow;
      }
    }

    Future<Response<dynamic>> updateLocation({required Object location}) async {
      try {
        return await dio.post(
          '/user/location',
          data: location,
        );
      }catch (e) {
        rethrow;
      }
    }
}