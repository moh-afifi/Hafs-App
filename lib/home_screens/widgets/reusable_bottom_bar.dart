import 'package:flutter/material.dart';
import 'package:hafs/home_screens/screens/home_new.dart';
import 'package:hafs/messages/messages.dart';
import 'package:hafs/notifications/notifications.dart';
import 'package:hafs/profile/profile_page.dart';

class ReusableBottomBar extends StatelessWidget {
  ReusableBottomBar(
      {this.notifications, this.messages, this.homeNew, this.profile});

  final bool homeNew, messages, notifications, profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(0xff04131A),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                IconButton(
                  color: (homeNew) ? Colors.blue : Colors.white,
                  iconSize: (homeNew) ? 30 : 20,
                  icon: Icon(Icons.home_filled),
                  onPressed: (homeNew)
                      ? (){}
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeNew(),
                            ),
                          );
                        },
                ),
                (homeNew)
                    ? Text(
                        'Home',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : SizedBox()
              ],
            ),
            Column(
              children: [
                IconButton(
                  color: (messages) ? Colors.blue : Colors.white,
                  iconSize: (messages) ? 30 : 20,
                  icon: Icon(
                    Icons.mail_outline,
                  ),
                  onPressed: (messages)
                      ?  (){}
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Messages(),
                            ),
                          );
                        },
                ),
                (messages)
                    ? Text(
                        'Messages',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : SizedBox()
              ],
            ),
            IconButton(
              color: Colors.white,
              iconSize: 20,
              icon: Icon(Icons.shopping_bag_outlined),
              onPressed: () {},
            ),
            Column(
              children: [
                IconButton(
                  color: (notifications) ? Colors.blue : Colors.white,
                  iconSize: (notifications) ? 30 : 20,
                  icon: Icon(
                    Icons.notifications,
                  ),
                  onPressed: (notifications)
                      ?  (){}
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Notifications(),
                            ),
                          );
                        },
                ),
                (notifications)
                    ? Text(
                        'Notifications',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : SizedBox()
              ],
            ),
            Column(
              children: [
                IconButton(
                  color: (profile) ? Colors.blue : Colors.white,
                  iconSize: (profile) ? 30 : 20,
                  icon: Icon(
                    Icons.person,
                  ),
                  onPressed: (profile)
                      ?  (){}
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfilePage(),
                            ),
                          );
                        },
                ),
                (profile)
                    ? Text(
                        'Profile',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : SizedBox()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
