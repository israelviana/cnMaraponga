import 'package:app_transito/router.dart';
import 'package:flutter/material.dart';

Future<void> main() async{
   runApp(
       MaterialApp(home: MyApp())
   );
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
       title: 'App CN',
      onGenerateRoute: RouterCn().mainRoutes(),
      initialRoute: loginRoute,
    );
  }
}
