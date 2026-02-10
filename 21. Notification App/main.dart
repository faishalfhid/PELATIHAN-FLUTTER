import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Awesome Notifications
  AwesomeNotifications().initialize(
    null, // pakai icon app default
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: Colors.deepPurple,
        ledColor: Colors.white,
        importance: NotificationImportance.High,
      ),
      NotificationChannel(
        channelKey: 'important_channel',
        channelName: 'Important Notifications',
        channelDescription: 'Notification channel for important tests',
        defaultColor: Colors.deepPurple,
        ledColor: Colors.white,
        importance: NotificationImportance.Max,
      ),
    ],
    debug: true,
  );

  runApp(MyApp());
}

// ===================== APP ROOT =====================
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    // Set notification listeners
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
    );

    // Request permission (simple version)
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: MyApp.navigatorKey,
      title: 'Awesome Notification Demo',
      initialRoute: '/',
      routes: {
        '/': (_) => const HomePage(),
        '/notification-page': (_) => const NotificationPage(),
      },
    );
  }
}

// ===================== HOME PAGE =====================
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                AwesomeNotifications().createNotification(
                  content: NotificationContent(
                    id: 1,
                    channelKey: 'basic_channel',
                    title: 'Hello World!',
                    body: 'This is my first notification!',
                    badge: 5,
                  ),
                );
              },
              child: const Text('Show Notification'),
            ),
            ElevatedButton(
              onPressed: () {
                AwesomeNotifications().createNotification(
                  content: NotificationContent(
                    id: 2,
                    channelKey: 'important_channel',
                    title: 'Hello World!',
                    body: 'This is important notification!',
                  ),
                );
              },
              child: const Text('Show Important Notification'),
            ),
          ],
        ),
      ),
    );
  }
}

// ===================== NOTIFICATION PAGE =====================
class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notification Page')),
      body: const Center(child: Text('Opened from notification')),
    );
  }
}

// ===================== CONTROLLER =====================
class NotificationController {
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    // Navigate when notification is tapped
    MyApp.navigatorKey.currentState?.pushNamed('/notification-page');
  }
}
