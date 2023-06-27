import 'package:firebase_core/firebase_core.dart';
import 'package:hands/consts/consts.dart';
import 'package:hands/views/splash_screen/splash_screen.dart';

//For Firebase
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // for upper side corner banner close
      debugShowCheckedModeBanner: false,

      title: 'app',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: darkFontGrey),
          backgroundColor: Colors.transparent,
        ),
        fontFamily: regular,
      ),
      home: SafeArea(
        child: Scaffold(
          body: SplashScreen(),
        ),
      ),
    );A
  }
}
