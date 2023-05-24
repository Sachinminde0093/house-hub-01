//Package Dependancy

// import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart' as gt;
import 'package:dio/dio.dart';
import 'package:house_hub/services/api/route/auth_route.dart';
import 'package:house_hub/services/api/route/user.dart';
// import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
// import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:house_hub/services/app/app_service.dart';

import '../../core/providers/toast.dart';
import '../../main.dart';
// import 'package:wechat_assets_picker/wechat_assets_picker.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

class ApiService {

late AppService appService;

  Future<ApiService> init(AppService appService) async {
    debugPrint("Api service is initialized");
    this.appService = appService;
    dio = createDio();
    externalDio = createDio(isExternal: true);
    initiateRoutes();
    return this;
  }

  late Dio dio;
  late Dio externalDio;

  // var serverUrl = 'https://c892-2409-4081-2d00-6f17-b5a8-c39b-ce41-555e.in.ngrok.io';
  var serverUrl = 'https://househub.onrender.com';

  Dio createDio({bool isExternal = false}) {
    var customServerURL = appService.db.customServerURL;
    var dio = Dio(
      BaseOptions(
        baseUrl: isExternal ? '' : customServerURL ?? serverUrl,
      )
    );
    // ..interceptors.add(DioCacheInterceptor(options: options))
    dio.interceptors.addAll({
      AppInterceptors(dio,appService, isExternal: isExternal),
    });
    return dio;
  }

  late AuthAPI authRoute;
  late UserAPI userAPI;
  // late CampusAPI campusRoute;
  // late CommunityAPI communityRoute;
  // late PostAPI postRoute;
  // late FeedAPI feedRoute;
  // late CommentAPI commentRoute;
  // late FileAPI fileRoute;

  void initiateRoutes() {
    print("intialized routes");

    authRoute = AuthAPI(dio);
    userAPI = UserAPI(dio);
    // userRoute = UserAPI(dio);
    // campusRoute = CampusAPI(dio);
    // communityRoute = CommunityAPI(dio);
    // postRoute = PostAPI(dio);
    // feedRoute = FeedAPI(dio);
    // commentRoute = CommentAPI(dio);
    // fileRoute = FileAPI(dio, externalDio);
  }

  // // Global options
  // final options = CacheOptions(
  //   // A default store is required for interceptor.
  //   store: HiveCacheStore(null),

  //   // All subsequent fields are optional.
    
  //   // Default.
  //   policy: CachePolicy.request,
  //   // Returns a cached response on error but for statuses 401 & 403.
  //   // Also allows to return a cached response on network errors (e.g. offline usage).
  //   // Defaults to [null].
  //   hitCacheOnErrorExcept: [401, 403],
  //   // Overrides any HTTP directive to delete entry past this duration.
  //   // Useful only when origin server has no cache config or custom behaviour is desired.
  //   // Defaults to [null].
  //   maxStale: const Duration(days: 7),
  //   // Default. Allows 3 cache sets and ease cleanup.
  //   priority: CachePriority.normal,
  //   // Default. Body and headers encryption with your own algorithm.
  //   cipher: null,
  //   // Default. Key builder to retrieve requests.
  //   keyBuilder: CacheOptions.defaultCacheKeyBuilder,
  //   // Default. Allows to cache POST requests.
  //   // Overriding [keyBuilder] is strongly recommended when [true].
  //   allowPostMethod: false,
  // );

}


class AppInterceptors extends Interceptor {
  //  AppInterceptors({required appService}): _appService= appService;
  //  AppInterceptors({required appService}): _appService= appService;

  final AppService appService;
  final Dio dio;
  final bool isExternal;

  AppInterceptors(this.dio,this.appService,  {this.isExternal = false});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {

    printInfo(info: '\nAPI request: ${options.uri}');

    if(isExternal) return handler.next(options);

    var accessToken = appService.db.accessToken;
    bool? skipToken = options.extra['skipToken'];

    if (accessToken != null) {
      if(skipToken ?? true) options.headers['Authorization'] = 'Bearer $accessToken';
    }

    return handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw DeadlineExceededException(err.requestOptions);
      case DioErrorType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions, err);
          case 401:
            throw UnauthorizedException(err.requestOptions, appService);
          case 404:
            throw NotFoundException(err.requestOptions);
          case 409:
            throw ConflictException(err.requestOptions);
          case 500:
            throw InternalServerErrorException(err.requestOptions);
          case 504:
            throw DeadlineExceededException(err.requestOptions);
        }
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.connectionTimeout:
        break;
      case DioErrorType.badCertificate:
        break;
      case DioErrorType.connectionError:
        throw NoInternetConnectionException(err.requestOptions);
      case DioErrorType.unknown:
        break;
    }
    return handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('Request Success: ${response.statusCode}\ndata: ${response.data}');
    if(response.statusCode.toString().startsWith('2')) response.extra['done'] = true;
    super.onResponse(response, handler);
  }
}

class BadRequestException extends DioError {
  final DioError error;
  BadRequestException(RequestOptions r, this.error) : super(requestOptions: r);

  @override
  String toString() {
    String message = '';
    try {
      message = error.response!.data['message'];
    } catch (e) {
      message = 'Invalid request';
    }
    debugPrint(errorToString(requestOptions, message));
    return message;
  }
}

class InternalServerErrorException extends DioError {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);
  @override
  String toString() {
    const message = 'Unknown error occurred, please try again later.';
    debugPrint(errorToString(requestOptions, message));
    return message;
  }
}

class ConflictException extends DioError {
  ConflictException(RequestOptions r) : super(requestOptions: r);
  @override
  String toString() {
    const message = 'Conflict occurred';
    debugPrint(errorToString(requestOptions, message));
    return message;
  }
}

class UnauthorizedException extends DioError {
  UnauthorizedException(RequestOptions r, this.appService) : super(requestOptions: r);
  AppService appService;
  @override
  String toString() {
    const message = 'Access denied';
    debugPrint(errorToString(requestOptions, message));
    logout();
    return message;
  }

  void logout() async {
    try {
      await appService.db.clearPreference();
      await  appService.init();
      // ignore: use_build_context_synchronously
      Phoenix.rebirth(TempContext.context);
      Toast.show('Authentication Failed.');
    } catch (e) {
      debugPrint(e.toString());
      Toast.show("Authentication Failed. Please restart the app and try again.");
    }
  }
}

class NotFoundException extends DioError {
  NotFoundException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    const message = 'Failed to find the server route';
    print(errorToString(requestOptions, message));
    return message;
  }
}

class NoInternetConnectionException extends DioError {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    const message = 'No internet connection detected, please try again.';
    print(errorToString(requestOptions, message));
    return message;
  }
}

class DeadlineExceededException extends DioError {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    const message = 'The connection has timed out, please try again.';
    print(errorToString(requestOptions, message));
    return message;
  }
}

String errorToString(RequestOptions ro, String message) {
  return '\nAPI Error: ${ro.uri}\nMessage: $message';
}