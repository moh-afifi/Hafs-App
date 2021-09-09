import 'package:flutter/material.dart';
import 'package:hafs/web_view/view.dart';

class ReusableArticleCard extends StatelessWidget {
  ReusableArticleCard({this.title,this.url});
  final String title,url;
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => View(
              title: title,
              url:
              url,
            ),
          ),
        );
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    'By Meshkah4',
                    style: TextStyle(
                      color:
                      Color(0xff4385A7),
                      fontSize: 12,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                  Text(
                    ' - 1 month ago',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Read More',
                style: TextStyle(
                  color: Color(0xff004E6E),
                  fontSize: 12,
                  decoration: TextDecoration
                      .underline,
                  fontWeight:
                  FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        color: Color(0xffEFFAFF),
      ),
    );
  }
}
