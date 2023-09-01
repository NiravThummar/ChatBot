import 'package:chat_bot/controller/authentication_repository.dart';
import 'package:chat_bot/screens/splash_screen/splash_screen.dart';

import 'package:chat_bot/widgets/theme/theme_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp()
      .then((value) => Get.put(AuthenticationRepository()));
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // theme: MyTheme.lightTheme(context),
//       // darkTheme: MyTheme.darkTheme(context),
//       // themeMode: ThemeMode.system,
//       theme: ThemeData(useMaterial3: true),

//       debugShowCheckedModeBanner: false,
//       home: MySplashScreen(),
//       // home: SideMenu(),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeManager(
      /// WidgetsBinding.instance.window.platformBrightness is used because a
      /// Material BuildContext will not be available outside of the Material app
      defaultBrightnessPreference: BrightnessPreference.system,
      data: (Brightness brightness) => ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
        brightness: brightness,
      ),
      loadBrightnessOnStart: true,
      themedWidgetBuilder: (BuildContext context, ThemeData theme) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          // darkTheme: ThemeData(
          //   brightness: Brightness.dark,
          //   useMaterial3: true,
          // ),
          home: MySplashScreen(),
        );
      },
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Theme Manager'),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: IntrinsicWidth(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               ElevatedButton(
//                 onPressed: () => ThemeManager.of(context)
//                     .setBrightnessPreference(BrightnessPreference.system),
//                 child: const Text('System'),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 6),
//                 child: ElevatedButton(
//                   onPressed: () => ThemeManager.of(context)
//                       .setBrightnessPreference(BrightnessPreference.light),
//                   child: const Text('Light'),
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () => ThemeManager.of(context)
//                     .setBrightnessPreference(BrightnessPreference.dark),
//                 child: const Text('Dark'),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: showThemePicker,
//         child: const Icon(Icons.color_lens, color: Colors.white),
//       ),
//     );
//   }

//   void showThemePicker() {
//     showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return ThemePickerDialog(
//           onSelectedTheme: (BrightnessPreference preference) {
//             ThemeManager.of(context).setBrightnessPreference(preference);
//           },
//         );
//       },
//     );
//   }
// }
