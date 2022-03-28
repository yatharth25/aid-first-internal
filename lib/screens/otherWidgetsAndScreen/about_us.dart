import 'package:flutter/material.dart';
import 'back_btn_and_image.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const BackBtn(),
            SizedBox(
              height: height * 0.02,
            ),
            Center(
              child: Column(
                children: <Widget>[
                  Text(
                    'About Us',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: height * 0.07),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset(
                        'assets/dscn.png',
                        height: height * 0.15,
                      ),
                      Text(
                        'DevsCafe',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: height * 0.03,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      const Text(
                        'Developed By: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Yatharth Chauhan'
                        '\nAndrew Joseph'
                        '\nAyush Katiyar'
                        '\nAyush Pandey',
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      const Text(
                        'Team Lead: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Text('Yatharth Chauhan'),
                      SizedBox(
                        height: height * 0.12,
                      ),
                      Image.asset(
                        'assets/abes_logo.png',
                        height: height * 0.1,
                      ),
                      Text('ABES Engineering College, Ghaziabad',
                          style: TextStyle(
                              fontSize: height * 0.02,
                              fontWeight: FontWeight.bold)),
                      Text('@Copyrights All Rights Reserved, 2021',
                          style: TextStyle(fontSize: height * 0.02))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
