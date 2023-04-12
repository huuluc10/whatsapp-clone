import 'package:chatapp_clone_whatsapp/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
