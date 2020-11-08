import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/providers/auth.dart';
import 'package:quiz_app/providers/settings.dart';
import 'package:audioplayers/audio_cache.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool quizReminders = true;
  bool darkMode;
  final player = AudioCache();

  @override
  Widget build(BuildContext context) {
    final settingsData = Provider.of<Settings>(context);
    darkMode = settingsData.darkMode;
    final auth = Provider.of<Auth>(context);
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Card(
                color: Colors.amber,
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
                              image:
                                  'https://randomuser.me/api/portraits/lego/0.jpg'),
                        ),
                        VerticalDivider(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              auth.userName,
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              '+917898812907',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.white70),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: 8,
              ),
              Card(
                child: Column(
                  children: [
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
                            // player.play('assets/sounds/switch.mp3');
                            // SystemSound.play(SystemSoundType.click);
                            settingsData.toggleReminders();
                          }),
                    ),
                    Divider(
                      height: 5,
                      color: Colors.black26,
                      indent: 30,
                      endIndent: 30,
                    ),
                    // ListTile(
                    //   leading: Icon(Icons.notifications),
                    //   title: Text('Enable Reminders'),
                    //   trailing:
                    //       CupertinoSwitch(value: true, onChanged: (ctx) {}),
                    // ),
                    // Divider(
                    //   height: 5,
                    //   color: Colors.black26,
                    //   indent: 30,
                    //   endIndent: 30,
                    // ),
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
                    ListTile(
                        leading: Icon(Icons.policy_outlined),
                        title: Text('Privacy policy'),
                        // onTap: () {
                        //   showBottomSheet(
                        //       context: context,
                        //       builder: (ctx) => Padding(
                        //             padding: const EdgeInsets.all(10),
                        //             child: Text(
                        //                 "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"),
                        //           ));
                        // },
                        trailing: Icon(Icons.navigate_next)
                        // trailing: CupertinoSwitch(value: true, onChanged: (ctx) {}),
                        ),
                    Divider(
                      height: 5,
                      color: Colors.black26,
                      indent: 30,
                      endIndent: 30,
                    ),
                    ListTile(
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
                    ListTile(
                      leading: Icon(Icons.logout),
                      title: Text('Logout'),
                      onTap: () async {
                        await showDialog(
                            context: context,
                            child: AlertDialog(
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
                      // trailing: CupertinoSwitch(value: true, onChanged: (ctx) {}),
                    )
                  ],
                ),
              ),
            ],
          )),
    ));
  }
}
