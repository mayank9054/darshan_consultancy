import 'package:darshan_consultancy/helper/phoneauth.dart';
import 'package:darshan_consultancy/page/test.dart';
import 'package:flutter/material.dart';

class DrawerSide extends StatefulWidget {
  const DrawerSide({Key? key}) : super(key: key);

  @override
  _DrawerSideState createState() => _DrawerSideState();
}

class _DrawerSideState extends State<DrawerSide> {
  AuthClass authClass = AuthClass();
  Widget listTile({String? title, IconData? icon, onTap}) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        size: 32,
        color: Colors.black,
      ),
      title: Text(
        title!,
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Image.asset(
                    'assets/images/darshan_logo1.jpg',
                    width: size * .25,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Image.asset(
                    'assets/images/darshan_logo.jpg',
                    width: size * .40,
                  ),
                ),
                SizedBox(height: 10.0),
              ],
            ),
          ),
          listTile(
              icon: Icons.person_outline,
              title: "Profile",
              onTap: () {
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => MyProfile(),
                // ));
              }),
          listTile(icon: Icons.notifications_outlined, title: "Notification",onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => TestWi(),));
          }),
          listTile(icon: Icons.chat, title: "Chat"),
          listTile(
              icon: Icons.logout_rounded,
              title: "Logout",
              onTap: () {
                showDialog<void>(
                  context: context,
                  barrierDismissible: true, // user must tap button!
                  builder: (BuildContext context) {
                    return AlertDialog(
                      // title: Text(''),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text(
                              'Do you want to Log out ?',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Cancle'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            authClass.signOut(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              }),
        ],
      ),
    );
  }
}
