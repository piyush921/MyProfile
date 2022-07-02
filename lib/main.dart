import 'package:flutter/material.dart';
import 'package:portfolio/constants.dart';
import 'package:portfolio/projects.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MaterialApp(
      title: "Portfolio",
      home: MyApp(),
    ));

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
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

  Widget _links(BuildContext context) {
    return Container(
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          _buildButtonColumn(Constants.RESUME, context),
          _buildButtonColumn(Constants.PROJECTS, context),
          _buildButtonColumn(Constants.LINKEDIN, context),
          _buildButtonColumn(Constants.GITHUB, context),
          _buildButtonColumn(Constants.STACKOVERFLOW, context),
          _buildButtonColumn(Constants.TWITTER, context),
          _buildButtonColumn(Constants.FACEBOOK, context),
          _buildButtonColumn(Constants.INSTAGRAM, context),
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
          _launchInBrowser(Uri.parse(Constants.STACKOVERFLOW_URL));
        }
        break;
      case Constants.GITHUB:
        {
          _launchInBrowser(Uri.parse(Constants.GITHUB_URL));
        }
        break;
      case Constants.FACEBOOK:
        {
          _launchInBrowser(Uri.parse(Constants.FACEBOOK_URL));
        }
        break;
      case Constants.INSTAGRAM:
        {
          _launchInBrowser(Uri.parse(Constants.INSTAGRAM_URL));
        }
        break;
      case Constants.LINKEDIN:
        {
          _launchInBrowser(Uri.parse(Constants.LINKEDIN_URL));
        }
        break;
      case Constants.RESUME:
        {
          _launchInBrowser(Uri.parse(Constants.RESUME_URL));
        }
        break;
      case Constants.TWITTER:
        {
          _launchInBrowser(Uri.parse(Constants.TWITTER_URL));
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

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  Widget _bottomCredits() {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.fromLTRB(0, 20.0, 0, 0),
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
    Widget okButton = TextButton(
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
