import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:mesadeayuda/src/page/login/login_page.dart';
import 'package:mesadeayuda/src/page/menu/tickets/list/list_tickets_page.dart';
import 'package:mesadeayuda/src/utils/my_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(new MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mesa de Ayuda',
      color: MyColors.primaryColor,
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash', // Cambiar la ruta inicial a SplashScreen
      routes: {
        '/splash': (BuildContext context) => const SplashScreen(), // Ruta de SplashScreen
        'login': (BuildContext context) =>  LoginPage(origen: ''),
        'menu/tickets/list': (BuildContext context) => const ListTicketsPage(),
      },
      theme: ThemeData(
        primaryColor: Colors.red,
        appBarTheme: AppBarTheme(
          backgroundColor: MyColors.primaryColor,
          elevation: 0,
        ),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Función que simula la carga de datos o inicialización de la aplicación
  _loadData() async {
    await Future.delayed(const Duration(seconds: 5)); // Retraso de 3 segundos
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage(origen: '')), // Navega al login
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color.fromARGB(255, 42, 40, 40),
      body: Center(
        child: Lottie.asset( 'assets/json/soporte.json',
            width: 200,
            height: 200,
            fit: BoxFit.fill


        ),
      ),
    );
  }
}
