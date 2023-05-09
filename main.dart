import 'package:chatapp_clone_whatsapp/common/utils/colors.dart';
import 'package:chatapp_clone_whatsapp/common/widgets/error.dart';
import 'package:chatapp_clone_whatsapp/common/widgets/loader.dart';
import 'package:chatapp_clone_whatsapp/features/auth/controller/auth_controller.dart';
import 'package:chatapp_clone_whatsapp/firebase_options.dart';
import 'package:chatapp_clone_whatsapp/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'common/screens/welcom_screen.dart';

// Variant: debugAndroidTest
// Config: debug
// Store: C:\Users\lucng\.android\debug.keystore
// Alias: AndroidDebugKey
// MD5: 30:57:10:F5:44:D6:4D:04:58:98:9A:F1:0F:BD:C0:96
// SHA1: BE:23:72:19:88:CE:B2:32:1A:EB:1D:49:D7:C7:ED:2D:52:99:FE:3D
// SHA-256: 38:11:7F:0B:0B:F9:1C:6C:BB:6F:C5:FE:E3:57:61:CD:9D:E0:5A:00:CB:C6:6A:8D:11:46:92:EB:A5:06:7E:8B
// Valid until: Sunday, January 5, 2053
// ----------
// > Task :app:signingReport
// Variant: debug
// Config: debug
// Store: C:\Users\lucng\.android\debug.keystore
// Alias: AndroidDebugKey
// MD5: 30:57:10:F5:44:D6:4D:04:58:98:9A:F1:0F:BD:C0:96
// SHA1: BE:23:72:19:88:CE:B2:32:1A:EB:1D:49:D7:C7:ED:2D:52:99:FE:3D
// SHA-256: 38:11:7F:0B:0B:F9:1C:6C:BB:6F:C5:FE:E3:57:61:CD:9D:E0:5A:00:CB:C6:6A:8D:11:46:92:EB:A5:06:7E:8B
// Valid until: Sunday, January 5, 2053
// ----------
// Variant: release
// Config: debug
// Store: C:\Users\lucng\.android\debug.keystore
// Alias: AndroidDebugKey
// MD5: 30:57:10:F5:44:D6:4D:04:58:98:9A:F1:0F:BD:C0:96
// SHA1: BE:23:72:19:88:CE:B2:32:1A:EB:1D:49:D7:C7:ED:2D:52:99:FE:3D
// SHA-256: 38:11:7F:0B:0B:F9:1C:6C:BB:6F:C5:FE:E3:57:61:CD:9D:E0:5A:00:CB:C6:6A:8D:11:46:92:EB:A5:06:7E:8B
// Valid until: Sunday, January 5, 2053
// ----------

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Chat Application',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: const AppBarTheme(color: appBarColor),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      debugShowCheckedModeBanner: false,
      home: ref.watch(userDataAuthProvider).when(
          data: (user) {
            if (user == null) {
              return const WelcomeScreen();
            } else {
              return const Scaffold(
                body: Center(
                  child: Text('Đã đăng nhập'),
                ),
              );
            }
          },
          error: (error, trace) {
            return ErrorScreen(error: error.toString());
          },
          loading: () => const Loader()),
    );
  }
}
