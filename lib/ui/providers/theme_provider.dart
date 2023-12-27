import 'package:hello_flutter/ui/theme/app_theme.dart';
import 'package:riverpod/riverpod.dart';

// Color list immutable
final colorListProvider = Provider((ref) => colorList);

// AppTheme Object
final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, AppTheme>((ref) => ThemeNotifier());

class ThemeNotifier extends StateNotifier<AppTheme> {
  ThemeNotifier() : super(AppTheme());

  void toggleDarkMode() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }

  void changeColorIndex(int index) {
    state = state.copyWith(selectedColor: index);
  }
}
