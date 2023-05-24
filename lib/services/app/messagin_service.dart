import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:house_hub/models/notification.dart';


final messagingService = Provider((ref) => MessagingService());


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  print("Handling a background message: ${message.messageId}");
}

void onDidReceiveLocalNotificationResponse(NotificationResponse response) {
  if(response.payload != null) {
    var firebaseNotification = FirebaseNotificationModel.fromRawJson(response.payload!);
    
    if (firebaseNotification.path != null) {
      Get.toNamed(firebaseNotification.path!);
    }
  }
}

void onMessageOpenedApp(RemoteMessage message) {
  var firebaseNotification = FirebaseNotificationModel.fromJson(message.data);

  if (firebaseNotification.path != null) {
    Get.toNamed(firebaseNotification.path!);
  }
}

class MessagingService  {

  Future<MessagingService> init() async {

    await initializeLocalNotifications();

    manageNotificationChannel();

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await FirebaseMessaging.instance.getToken();

    FirebaseMessaging.onMessage.listen(_onForegroundMessage);

    FirebaseMessaging.onMessageOpenedApp.listen(onMessageOpenedApp);

    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(android: AndroidInitializationSettings('notification_icon')),
      onDidReceiveNotificationResponse: onDidReceiveLocalNotificationResponse,
      onDidReceiveBackgroundNotificationResponse: onDidReceiveLocalNotificationResponse,
    );

    return this;
  }

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<String?> getFirebaseToken() async => await messaging.getToken();

  Future<RemoteMessage?> getIntialMessage() async => await messaging.getInitialMessage();

  void requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');
  }

  void _onForegroundMessage(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    // If `onMessage` is triggered with a notification, construct our own
    // local notification to show to users using the created channel.
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'foreground_notifications',
            'App Foreground Notification',
            icon: 'assets/icons/notification_icon.png',
            // color: Color(0xff4F545C)
          ),
        ),
        payload: FirebaseNotificationModel.fromJson(message.data).toRawJson()
      );
    }
  }

  Future<void> initializeLocalNotifications() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false
    );
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings, 
      onDidReceiveNotificationResponse: onDidReceiveLocalNotificationResponse
    );
  }

  void manageNotificationChannel() async {
    
      // Channel to show notification when app is in foreground
      const AndroidNotificationChannel foregroundNotificationChannel = AndroidNotificationChannel(
        'foreground_notifications',
        'App Foreground Notification',
        description: 'Show notifications when app is in foreground',
        importance: Importance.max,
      );

      await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(foregroundNotificationChannel);
    }

}