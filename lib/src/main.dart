import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moove_dance_studio/moove_dance_studio.dart';

const MaterialColor _primaryWhite = MaterialColor(
  0xFFFFFFFF,
  <int, Color>{
    50: Color(0xFFFFFFFF),
    100: Color(0xFFFFFFFF),
    200: Color(0xFFFFFFFF),
    300: Color(0xFFFFFFFF),
    400: Color(0xFFFFFFFF),
    500: Color(0xFFFFFFFF),
    600: Color(0xFFFFFFFF),
    700: Color(0xFFFFFFFF),
    800: Color(0xFFFFFFFF),
    900: Color(0xFFFFFFFF),
  },
);

const MaterialColor _primaryBlack = MaterialColor(
  0xFF000000,
  <int, Color>{
    50: Color(0xFF000000),
    100: Color(0xFF000000),
    200: Color(0xFF000000),
    300: Color(0xFF000000),
    400: Color(0xFF000000),
    500: Color(0xFF000000),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  },
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: _primaryBlack,
        primaryColor: Colors.white,
      ),
      darkTheme: ThemeData(
        primarySwatch: _primaryWhite,
        brightness: Brightness.dark,
        primaryColor: Colors.grey[800]!,
        toggleableActiveColor: _primaryWhite[500]!,
        accentColor: _primaryWhite[500]!,
        backgroundColor: Colors.black,
      ),
      themeMode: ThemeMode.system,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    NewsFeedPage(),
    SchedulePage(),
    OthersPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final database = FirebaseDatabase.instance;

    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsPostBloc>(
          create: (BuildContext context) => NewsPostBloc(
            database: database,
          )..add(NewsPostStarted()),
        ),
        BlocProvider<DanceClassBloc>(
          create: (BuildContext context) => DanceClassBloc(
            database: database,
          )..add(DanceClassStarted()),
        ),
        BlocProvider<WeekDayBloc>(
          create: (BuildContext context) => WeekDayBloc(
            danceClassBloc: BlocProvider.of<DanceClassBloc>(context),
          )..add(GetCurrentWeekDay()),
        ),
        BlocProvider<WeekSelectorBloc>(
          create: (BuildContext context) => WeekSelectorBloc(
            danceClassBloc: BlocProvider.of<DanceClassBloc>(context),
          )..add(GetCurrentWeek()),
        ),
      ],
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 0.5,
                blurRadius: 15.0,
              ),
            ],
          ),
          height: 100,
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.event),
                label: 'Schedule',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_rounded),
                label: 'Others',
              ),
            ],
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            iconSize: 30.0,
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
