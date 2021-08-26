import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/providers/auth.dart';
import 'package:quiz_app/providers/papers.dart';
import 'package:quiz_app/providers/settings.dart';
// import 'package:audioplayers/audio_cache.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              UserCardWidget(),
              SizedBox(
                height: 8,
              ),
              ProfileOptionsListWidget(),
            ],
          )),
    ));
  }
}

class ProfileOptionsListWidget extends StatefulWidget {
  @override
  _ProfileOptionsListWidgetState createState() =>
      _ProfileOptionsListWidgetState();
}

class _ProfileOptionsListWidgetState extends State<ProfileOptionsListWidget> {
  bool quizReminders = true;

  bool darkMode;

  @override
  Widget build(BuildContext context) {
    final settingsData = Provider.of<Settings>(context);
    final auth = Provider.of<AuthProvider>(context);
    darkMode = settingsData.darkMode;
    return Card(
      child: Column(
        children: [
//------- Enable reminders button
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Enable Reminders'),
            trailing: CupertinoSwitch(
                // activeColor: Colors.amber,
                value: quizReminders,
                onChanged: (ctx) {
                  setState(() {
                    quizReminders = !quizReminders;
                  });
                  settingsData.toggleReminders();
                }),
          ),
          Divider(
            height: 5,
            color: Colors.black26,
            indent: 30,
            endIndent: 30,
          ),

//------- Dark mode button
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Dark Mode'),
            trailing: CupertinoSwitch(
                value: darkMode,
                onChanged: (ctx) {
                  setState(() {
                    darkMode = !darkMode;
                  });
                  settingsData.toggleAppMode();
                }),
          ),
          Divider(
            height: 5,
            color: Colors.black26,
            indent: 30,
            endIndent: 30,
          ),

//------- Privacy policy button
          ListTile(
              leading: Icon(Icons.policy_outlined),
              title: Text('Privacy policy'),
              onTap: () {},
              trailing: Icon(Icons.navigate_next)),
          Divider(
            height: 5,
            color: Colors.black26,
            indent: 30,
            endIndent: 30,
          ),

//------- Select papers button
          ListTile(
            onTap: () async {
              List<PaperModel> papers =
                  await Provider.of<PapersProvider>(context, listen: false)
                      .getAndSetPapers();
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        title: Text("Select paper:"),
                        content: Container(
                            height: 300,
                            width: 300,
                            child: ListView.builder(
                              itemCount: papers.length,
                              itemBuilder: (context, index) => ListTile(
                                onTap: () {
                                  //           await Provider.of<PapersProvider>(context,
                                  // listen: false).
                                },
                                title: Text(papers[index].title),
                              ),
                            )),
                      ));
            },
            leading: Icon(Icons.star_border),
            title: Text('SSC CGL'),
            trailing: Icon(Icons.navigate_next),
          ),
          Divider(
            height: 5,
            color: Colors.black26,
            indent: 30,
            endIndent: 30,
          ),

//------- Logout button
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () async {
              await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        content: Text('Do you really wish to log out?'),
                        actions: [
                          FlatButton(
                              onPressed: () {
                                if (settingsData.darkMode)
                                  settingsData.toggleAppMode();
                                auth.logout();
                                Navigator.of(context).pop();
                              },
                              child: Text('Yeah')),
                          FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Nopes'))
                        ],
                      ));
            },
          )
        ],
      ),
    );
  }
}

class UserCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, value, child) => Card(
        // color: Colors.amber,
        elevation: 10,
        // color: Colors.deepPurple,
        child: Stack(children: [
          Container(
            height: 120,
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              'https://image.freepik.com/free-vector/abstract-wallpaper_23-2148663179.jpg',
              fit: BoxFit.fitWidth,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: FadeInImage.assetNetwork(
                      height: 100,
                      placeholder: 'assets/images/placeholder.jpeg',
                      image: 'https://randomuser.me/api/portraits/lego/0.jpg'),
                ),
                VerticalDivider(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value.user.username ?? "Not found",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      value.user.phone ?? "Not found",
                      style: TextStyle(fontSize: 12, color: Colors.white70),
                    ),
                  ],
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
