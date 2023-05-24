import 'package:dio/dio.dart';

class AuthAPI {
  
  final Dio dio;

  AuthAPI(this.dio);
  
  Future<Response<dynamic>> loginUser(Object body) async {
    try {
      return await dio.post(
        '/auth/new',
        data: body,
        options: Options(
          extra: {'skipToken': true}
        )
      );
    } catch (e) {
      rethrow;
    }
  }

  // Future<Response<dynamic>> authenticateWhatsapp(String waId, String body) async {
  //   try {
  //     return await dio.post(
  //       '/auth/whatsapp',
  //       data: body,
  //       queryParameters: {'waId': waId},
  //       options: Options(
  //         extra: {'skipToken': true}
  //       )
  //     );
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  // Future<Response<dynamic>> linkGoogle(String serverAuthCode) async {
  //   try {
  //     return await dio.get(
  //       '/auth/link/google',
  //       queryParameters: {'code': serverAuthCode},
  //     );
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  // Future<Response<dynamic>> linkWhatsapp(String waId) async {
  //   try {
  //     return await dio.get(
  //       '/auth/link/whatsapp',
  //       queryParameters: {'waId': waId},
  //     );
  //   } catch (e) {
  //     throw e;
  //   }
  // }
}