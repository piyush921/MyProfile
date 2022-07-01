import 'package:flutter/material.dart';
import 'package:portfolio/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class Projects extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage(Constants.backgroundImageURl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              child: _buildExpandableTile(context),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableTile(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    int gridSize = 3;
    if (_size.width <= 420) {
      gridSize = 1;
    } else if (_size.width > 420 && _size.width <= 900) {
      gridSize = 2;
    }

    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemCount: Constants.projectIconArray.length,
      itemBuilder: (ctx, index) {
        return Card(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
            color: Colors.transparent,
            child: ExpansionTile(
              initiallyExpanded: true,
              leading: CircleAvatar(
                backgroundImage: AssetImage(Constants.projectIconArray[index]),
              ),
              trailing: Icon(Icons.arrow_drop_down, color: Colors.white),
              title: Text(Constants.projectNameArray[index],
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700)),
              children: <Widget>[
                ListTile(
                    title: Text("About",
                        style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.w700)),
                    subtitle: Text(
                        "${Constants.projectDescriptionArray[index]}\n\n${Constants.projectUrlArray[index]}\n",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700)),
                    hoverColor: Colors.white38,
                    onTap: () {
                      _launchPlayStore(Constants.projectUrlArray[index]);
                    })
              ],
            ));
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gridSize,
        childAspectRatio: 1.0,
        crossAxisSpacing: 0.0,
        mainAxisSpacing: 5,
        mainAxisExtent: 300,
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
