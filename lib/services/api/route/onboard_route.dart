import 'package:dio/dio.dart';

class OnBoardAPI {
  final Dio dio;
  OnBoardAPI(this.dio);
  
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
}