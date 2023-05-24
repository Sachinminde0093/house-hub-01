import 'package:dio/dio.dart';

class PermissionAPI {

  final Dio dio;

  PermissionAPI(this.dio);
  
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
  }