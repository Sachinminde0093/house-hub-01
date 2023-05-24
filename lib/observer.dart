import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_hub/services/app/app_service.dart';


class AppLifecycleObserver extends WidgetsBindingObserver {
    @override
      void didChangeAppLifecycleState(AppLifecycleState state) {
          final container = ProviderContainer(); // Create a ProviderContainer
          if (state == AppLifecycleState.paused) {
            final appserviceProvider = container.read(appServiceProvider);
            appserviceProvider.onClose();
          }
          container.dispose(); 
      }
}