import 'package:cherry/views/launch_list.dart';
import 'package:cherry/views/vehicle_list.dart';
import 'package:flutter/material.dart';

void main() => runApp(new CherryApp());

class CherryApp extends StatelessWidget {
  final ThemeData appTheme = ThemeData(
      accentColor: Colors.amberAccent,
      brightness: Brightness.dark,
      fontFamily: 'ProductSans',
      textTheme: TextTheme(
          title: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold)));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Project: Cherry',
        theme: appTheme,
        home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  List<StatelessWidget> homeLists = List(3);

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController.animateTo(1);
    updateLists();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void updateLists() {
    homeLists = [
      VehicleList('https://api.spacexdata.com/v2/rockets/'),
      LaunchList('https://api.spacexdata.com/v2/launches/upcoming'),
      LaunchList('https://api.spacexdata.com/v2/launches?order=desc')
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TabBar(
          controller: tabController,
          tabs: <Widget>[
            const Tab(text: 'VEHICLES'),
            const Tab(text: 'UPCOMING'),
            const Tab(text: 'LATEST')
          ],
        ),
      ),
      body: TabBarView(controller: tabController, children: homeLists),
    );
  }
}
