import 'package:material_ui/material_ui.dart';

import 'features/home/ui/home_screen.dart';

class MyApp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scanner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.blue)),
      home: const HomeScreen(),
    );
  }
}
