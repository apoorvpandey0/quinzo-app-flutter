import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
// import 'package:bezier_chart/bezier_chart.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/providers/subjects.dart';
import 'package:quiz_app/screens/quiz_start_screen.dart';
import 'package:quiz_app/widgets/home_screen_widgets/analysis_page.dart';
import 'package:quiz_app/widgets/home_screen_widgets/news_page.dart';
import 'package:quiz_app/widgets/home_screen_widgets/profile_page.dart';
import 'package:quiz_app/widgets/home_screen_widgets/savedForLater_page.dart';
import 'package:quiz_app/widgets/home_screen_widgets/subjects_grid.dart';
import 'package:quiz_app/widgets/home_screen_widgets/mydrawer.dart';
import 'package:quiz_app/widgets/slideShow.dart';

final GlobalKey _scaffoldKey = new GlobalKey();

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // int _page = 0;
  // GlobalKey _bottomNavigationKey = GlobalKey();

  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      automaticallyImplyLeading: false,
      leading: Builder(
        builder: (contex) => IconButton(
          icon: Icon(
            Icons.menu,
            // color: Colors.black,
            size: 25,
          ),
          onPressed: () => Scaffold.of(contex).openDrawer(),
        ),
      ),
      title: Text('Quinzo',
          style: TextStyle(
            fontSize: 25,
            // color: Colors.black,
          )),
      // backgroundColor: ThemeData().bottomAppBarColor,
      elevation: 0,
      centerTitle: true,
      titleSpacing: 0,
    );

    var mQSize = MediaQuery.of(context).size;
    var mQHeight = mQSize.height -
        appBar.preferredSize.height.toDouble() -
        MediaQuery.of(context).padding.top;
    // var allSubjects =
    // var analysis =
    // var profileView = CustomScrollView(slivers: [
    //   SliverAppBar(
    //     pinned: true,
    //     // stretch: true,
    //     leading: Container(),
    //     expandedHeight: 200,
    //     flexibleSpace: FlexibleSpaceBar(
    //       // centerTitle: true,
    //       titlePadding: EdgeInsets.fromLTRB(20, 5, 0, 15),
    //       title: Text("Majnu bhai"),
    //       background: Center(
    //           child: Image.network(
    //               'https://image.freepik.com/free-photo/3d-rendering-luxury-new-background-red-wireframe-mesh-circle-3d-illustration_117358-244.jpg')),
    //     ),
    //   ),
    //   SliverList(
    //       delegate: SliverChildListDelegate([
    //     Text(
    //       "TITLE",
    //       style: TextStyle(fontSize: 20),
    //     ),
    //     Divider(),
    //     Text(
    //       "Description Data with favs and add \nto cart button will come here",
    //       textAlign: TextAlign.center,
    //     ),
    //     Container(
    //       height: 800,
    //       color: Colors.amber,
    //     )
    //   ]))
    // ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Subject(),
        ),
      ],
      child: Scaffold(
        // key: _scaffoldKey,
        appBar: appBar,
        drawer: MyDrawer(),
        body: PageView(
          controller: _pageController,
          onPageChanged: (value) {
            // print(value);
            setState(() {
              _currentIndex = value;
              print('Inside onPageChanged $_currentIndex');
            });
          },
          children: [
            NewsScreen(),
            SubjectsGrid(mQHeight * .49),
            AnalysisPage(),
            // SavedForLater(),
            ProfilePage()
          ],
        ),
        bottomNavigationBar: BottomNavyBar(
          // showElevation: true,
          selectedIndex: _currentIndex,
          onItemSelected: (index) {
            print('In bottom nav bar $index');
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 500), curve: Curves.easeIn);
          },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              title: Text('Home'),
              icon: Icon(
                Icons.home,
                // size: 30,
              ),
            ),
            BottomNavyBarItem(
                title: Text('All subjects'), icon: Icon(Icons.apps)),
            BottomNavyBarItem(
                title: Text('Saved'), icon: Icon(Icons.saved_search)),
            BottomNavyBarItem(
                title: Text('Profile'), icon: Icon(Icons.perm_identity)),
          ],
        ),
      ),
    );
  }
}

// Widget sample3(BuildContext context) {
//   final fromDate = DateTime(2019, 05, 22);
//   final toDate = DateTime.now();

//   final date1 = DateTime.now().subtract(Duration(days: 2));
//   final date2 = DateTime.now().subtract(Duration(days: 3));

//   return Center(
//     child: Container(
//       color: Colors.red,
//       height: MediaQuery.of(context).size.height / 2,
//       width: MediaQuery.of(context).size.width,
//       child: BezierChart(
//         fromDate: fromDate,
//         bezierChartScale: BezierChartScale.WEEKLY,
//         toDate: toDate,
//         selectedDate: toDate,
//         series: [
//           BezierLine(
//             label: "Duty",
//             onMissingValue: (dateTime) {
//               if (dateTime.day.isEven) {
//                 return 10.0;
//               }
//               return 5.0;
//             },
//             data: [
//               DataPoint<DateTime>(value: 10, xAxis: date1),
//               DataPoint<DateTime>(value: 50, xAxis: date2),
//             ],
//           ),
//         ],
//         config: BezierChartConfig(
//           verticalIndicatorStrokeWidth: 3.0,
//           verticalIndicatorColor: Colors.black26,
//           showVerticalIndicator: true,
//           verticalIndicatorFixedPosition: false,
//           backgroundColor: Colors.red,
//           footerHeight: 30.0,
//         ),
//       ),
//     ),
//   );
// }
