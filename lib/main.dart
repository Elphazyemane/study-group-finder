import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'injection_container.dart';
import 'presentation/screens/welcome_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const StudyGroupApp());
}

class StudyGroupApp extends StatelessWidget {
  const StudyGroupApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => InjectionContainer.studyGroupProvider,
      child: MaterialApp(
        title: 'Study Group Finder',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF0A66C2),
            brightness: Brightness.light,
          ),
          useMaterial3: true,
         scaffoldBackgroundColor: const Color(0xFFF3F2EF),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF0A66C2),
            foregroundColor: Colors.white,
            elevation: 0,
            centerTitle: false,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1565C0),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        home: const WelcomeScreen(),
      ),
    );
  }
}