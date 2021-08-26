import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/providers/auth.dart';
import 'package:quiz_app/providers/news.dart';
import 'package:quiz_app/providers/papers.dart';
import 'package:quiz_app/providers/quiz.dart';
import 'package:quiz_app/providers/subjects.dart';
import 'package:quiz_app/providers/settings.dart';
import 'package:quiz_app/screens/article_detail_screen.dart';
import 'package:quiz_app/screens/auth_screen.dart';
import 'package:quiz_app/screens/home_screen.dart';
// import 'package:quiz_app/screens/profile_screen.dart';
import 'package:quiz_app/screens/quiz_screen.dart';
import 'package:quiz_app/screens/quiz_start_screen.dart';
import 'package:quiz_app/screens/results_screen.dart';

void main() {
  runApp(InterMediate());
}

class InterMediate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (ctx) => Settings(),
      ),
      ChangeNotifierProvider(
        create: (ctx) => AuthProvider(),
      ),
    ], child: MyApp());
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<Settings>(context);
    final auth = Provider.of<AuthProvider>(context);
    print(auth.isAuth);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Quiz(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Subjects(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Articles(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => PapersProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, Subjects>(
          create: (ctx) => Subjects(),
          update: (ctx, auth, previousOrderObject) => Subjects()
            ..updateProxyMethod(
                auth.token, previousOrderObject.subjects, auth.user.username),
        ),
        ChangeNotifierProxyProvider<AuthProvider, Quiz>(
          create: (ctx) => Quiz(),
          update: (ctx, auth, previousOrderObject) => Quiz()
            ..updateProxyMethod(
                auth.token, previousOrderObject.questions, auth.user.username),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: appTheme.appMode,
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.amber,
          accentTextTheme: TextTheme(headline1: TextStyle(color: Colors.white)),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // home: HomeScreen(),
        // home: AuthScreen(),
        home: auth.isAuth ? HomeScreen() : AuthScreen(),
        routes: {
          HomeScreen.routeName: (ctx) => HomeScreen(),
          QuizScreen.routeName: (ctx) => QuizScreen(),
          // ProfileScreen.routeName: (ctx) => HomeScreen(),
          ResultScreen.routeName: (ctx) => ResultScreen(),
          QuizStartScreen.routeName: (ctx) => QuizStartScreen(),
          ArticleDetailScreen.routeName: (ctx) => ArticleDetailScreen(),
        },
      ),
    );
  }
}
