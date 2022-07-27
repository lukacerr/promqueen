import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'helpers/config_helper.dart';
import 'helpers/remote_service.dart';

import 'home_container.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  await RemoteService.init();
  await ConfigHelper.init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Prom Queen',
      theme: ThemeData(
        brightness: Brightness.light,
        colorSchemeSeed: Colors.lightBlue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.lightBlueAccent,
      ),
      themeMode: ThemeMode.system,
      home: const HomeContainer(),
    );
  }
}
