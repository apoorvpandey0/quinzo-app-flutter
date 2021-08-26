import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/providers/auth.dart';
import 'package:url_launcher/url_launcher.dart';

// import 'package:fluttertoast/fluttertoast.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.70,
      child: ClipRRect(
        child: Drawer(
          child: Column(
            children: <Widget>[
              MyDrawerHeader(),
              // Internships and settings tab section
              DrawerOptionsColumn()
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerOptionsColumn extends StatefulWidget {
  @override
  _DrawerOptionsColumnState createState() => _DrawerOptionsColumnState();
}

class _DrawerOptionsColumnState extends State<DrawerOptionsColumn> {
  @override
  int _selectedTile = -1;

  void _setSelectedTile(int tile) {
    setState(() {
      _selectedTile = tile;
    });
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            Icons.book,
            size: 26,
          ),
          title: Text('Notes',
              style: TextStyle(
                fontSize: 20,
              )),
          onTap: () {
            _setSelectedTile(0);
            // Navigator.of(context)
            //     .pushReplacementNamed(TabsScreen.routeName);
          },
          selected: _selectedTile == 0 ? true : false,
        ),
        ListTile(
          leading: Icon(
            Icons.library_books_outlined,
            size: 26,
          ),
          title: Text('Syllabus',
              style: TextStyle(
                fontSize: 20,
              )),
          onTap: () {
            _setSelectedTile(1);

            // Navigator.of(context)
            //     .pushReplacementNamed(FiltersScreen.routeName);
          },
          selected: _selectedTile == 1 ? true : false,
        ),
        ListTile(
          leading: Icon(
            Icons.wallet_giftcard,
            size: 26,
          ),
          title: Text('Refer and earn',
              style: TextStyle(
                fontSize: 20,
              )),
          onTap: () {
            _setSelectedTile(2);

            // Navigator.of(context)
            //     .pushReplacementNamed(FiltersScreen.routeName);
          },
          selected: _selectedTile == 2 ? true : false,
        ),
        ListTile(
          leading: Icon(Icons.contact_support),
          title: Text('Contact Us',
              style: TextStyle(
                fontSize: 19,
              )),
          onTap: () {
            _setSelectedTile(3);
          },
          selected: _selectedTile == 3 ? true : false,
          subtitle: Text(
            'Mon-Fri,10 AM-5PM',
            style: TextStyle(fontSize: 13),
          ),
        ),
      ],
    );
  }
}

class MyDrawerHeader extends StatelessWidget {
  const MyDrawerHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (ctx, value, child) => Container(
          height: 200,
          child: DrawerHeader(
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            child: Stack(children: [
              Container(
                height: 200,
                child: Image.network(
                  'https://image.freepik.com/free-vector/abstract-wallpaper_23-2148663179.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                      radius: 45,
                      backgroundImage: NetworkImage(
                          'https://randomuser.me/api/portraits/lego/0.jpg')),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FittedBox(
                        child: Text(
                          value.user.username,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      FittedBox(
                        child: Text(
                          value.user.phone,
                          style: TextStyle(fontSize: 10, color: Colors.white70),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ]),
          )),
    );
  }
}

class OldHeader extends StatelessWidget {
  const OldHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.7),
              Theme.of(context).primaryColor
            ]),
      ),
      child: Container(
        // color: Colors.amber,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Profile pic
            CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                    'https://randomuser.me/api/portraits/lego/0.jpg')),

            // Users name
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Majnu Bhaai',
                      style: TextStyle(
                          fontSize: 20, color: Colors.white, letterSpacing: 1)),
                ],
              ),
            ),
            Container(
              // color: Colors.amber,
              child: Row(
                children: [
                  Spacer(),
                  Text('apoorvpandey0@gmail.com',
                      style: TextStyle(
                          fontSize: 10, color: Colors.white, letterSpacing: 1)),
                  IconButton(
                      icon: Icon(
                        Icons.edit,
                        size: 13,
                        color: Colors.white,
                      ),
                      onPressed: null),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DrawerListItem extends StatelessWidget {
  int id;
  Function _setSelectedTile;
  bool _selected;

  @override
  Widget build(BuildContext context) {
    return _selected
        ? Card(
            child: ListTile(
              leading: Icon(
                Icons.wallet_giftcard,
                size: 26,
              ),
              title: Text('Refer and earn',
                  style: TextStyle(
                    fontSize: 20,
                  )),
              onTap: () {
                _setSelectedTile(id);
                // Navigator.of(context)
                //     .pushReplacementNamed(FiltersScreen.routeName);
              },
              selected: _selected,
            ),
          )
        : ListTile(
            leading: Icon(
              Icons.wallet_giftcard,
              size: 26,
            ),
            title: Text('Refer and earn',
                style: TextStyle(
                  fontSize: 20,
                )),
            onTap: () {
              _setSelectedTile(id);
              // Navigator.of(context)
              //     .pushReplacementNamed(FiltersScreen.routeName);
            },
            selected: _selected,
          );
  }
}
