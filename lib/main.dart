import 'dart:ui';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio/constants.dart';
import 'package:portfolio/projects.dart';

void main() => runApp(MaterialApp(
      title: "App",
      home: MyApp(),
    ));

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;

    /*if(kIsWeb) {
      if (orientation == Orientation.landscape) {
        return _portraitMode(context);
      } else {
        return _landscapeMode(context);
      }
    }

    try {
      if (Platform.isAndroid || Platform.isIOS) {
        if (orientation == Orientation.portrait) {
          return _portraitMode(context);
        } else {
          return _landscapeMode(context);
        }
      } else {
        return _portraitMode(context);
      }
    } catch (e) {
      return _portraitMode(context);
    }*/

    return _portraitMode(context);

  }

  MaterialApp _portraitMode(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: new Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage(Constants.backgroundImageURl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            new Column(
              children: <Widget>[
                _profileImage(context),
                _about(context),
                _links(context),
                _bottomCredits(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  MaterialApp _landscapeMode(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: new Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage(Constants.backgroundImageURl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            new Row(
              children: [
                Expanded(
                  child: new Column(
                    children: <Widget>[
                      _profileImageForLandscape(context),
                      _aboutForLandscape(context)
                    ],
                  ),
                ),
                Expanded(
                  child: new Column(
                    children: <Widget>[_links(context)],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileImage(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: <Widget>[
          new Container(
              margin: const EdgeInsets.all(10),
              width: _size.width < 410 ? 100.0 : 150.0,
              height: _size.width < 410 ? 100.0 : 150.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new AssetImage(Constants.profileImageUrl)))),
        ],
      ),
    );
  }

  Widget _profileImageForLandscape(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
              margin: const EdgeInsets.all(10),
              width: _size.height < 371 ? 100.0 : 150.0,
              height: _size.height < 371 ? 100.0 : 150.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new AssetImage(Constants.profileImageUrl)))),
        ],
      ),
    );
  }

  Widget _about(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Hello',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: _size.width < 300 ? 20.0 : 30.0,
                    ),
                  ),
                ),
                Text(
                  "I'm Piyush Kumar",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: _size.width < 300 ? 16.0 : 20.0,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Text(
                    'Android Application Developer',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: _size.width < 305 ? 12.0 : 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          /*3*/
        ],
      ),
    );
  }

  Widget _aboutForLandscape(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(32),
      child: Stack(
        children: [
          Expanded(
            /*1*/
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Hello',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: _size.height <= 320 ? 20.0 : 30.0,
                    ),
                  ),
                ),
                Text(
                  "I'm Piyush Kumar",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: _size.height < 308 ? 16.0 : 20.0,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Text(
                    'Android Application Developer',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: _size.height < 302 ? 12.0 : 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          /*3*/
        ],
      ),
    );
  }

  Widget _links(BuildContext context) {
    return Container(
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          _buildButtonColumn(Constants.RESUME, context),
          _buildButtonColumn(Constants.LINKEDIN, context),
          _buildButtonColumn(Constants.STACKOVERFLOW, context),
          _buildButtonColumn(Constants.FACEBOOK, context),
          _buildButtonColumn(Constants.INSTAGRAM, context),
          _buildButtonColumn(Constants.PROJECTS, context),
          _buildButtonColumn(Constants.GITHUB, context),
        ],
      ),
    );
  }

  Column _buildButtonColumn(String label, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(5.0)),
          child: InkWell(
            onTap: () {
              debugPrint('click on: ' + label);
              _goToPage(label, context);
            },
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                label,
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _goToPage(String label, BuildContext context) {
    switch (label) {
      case Constants.STACKOVERFLOW:
        {
          _launchInBrowser(Constants.STACKOVERFLOW_URL);
        }
        break;
      case Constants.GITHUB:
        {
          _launchInBrowser(Constants.GITHUB_URL);
        }
        break;
      case Constants.FACEBOOK:
        {
          _launchInBrowser(Constants.FACEBOOK_URL);
        }
        break;
      case Constants.INSTAGRAM:
        {
          _launchInBrowser(Constants.INSTAGRAM_URL);
        }
        break;
      case Constants.LINKEDIN:
        {
          _launchInBrowser(Constants.LINKEDIN_URL);
        }
        break;
      case Constants.RESUME:
        {
          _launchInBrowser(Constants.RESUME_URL);
        }
        break;
      case Constants.PROJECTS:
        {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => new Projects()));
        }
        break;
    }
  }

  Future<void> _launchInBrowser(String url) async {
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

  Widget _bottomCredits() {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
          child: Text(
            'Made with  ❤  in Flutter',
            style: TextStyle(fontSize: 10.0, color: Colors.white),
          ),
        ),
      ],
    );
  }

  showAlertDialog(BuildContext context, String message) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert of orientation"),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
