import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:portfolio/constants.dart';
import 'package:portfolio/home.dart';
import 'package:url_launcher/url_launcher.dart';

class Projects extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Projects';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(title),
        ),
        body: ListView(
          children: new List.generate(Constants.projectNameArray.length, (index) => new ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(Constants.projectIconArray[index]), // no matter how big it is, it won't overflow
            ),
            title: Text(Constants.projectNameArray[index]),
            onTap: () {
              _launchPlayStore(Constants.projectUrlArray[index]);
            },
            subtitle: Text(Constants.projectUrlArray[index]),
          )),
        ),
      ),
    );
  }

  Future<void> _launchPlayStore(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'header_key': 'header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
