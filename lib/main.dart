import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hello_flutter/ui/providers/theme_provider.dart';
import 'package:hello_flutter/ui/screens/home.dart';
import 'package:hello_flutter/ui/theme/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, ref) {
    final appTheme = ref.watch(themeNotifierProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme(
              selectedColor: appTheme.selectedColor,
              isDarkMode: appTheme.isDarkMode)
          .getTheme(),
      home: const MyHomePage(title: 'Flutter Counter'),
    );
  }
}
