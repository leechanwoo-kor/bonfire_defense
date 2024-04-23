import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  void _back(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              _topAction(context, screenWidth),
              Expanded(child: Container()),
              Text(
                'A',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.grey[600]),
              ),
              Expanded(child: Container()),
              const Text(
                'Work',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                    color: Colors.black),
              ),
              Expanded(child: Container()),
              Text(
                'by',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.grey[600]),
              ),
              Expanded(child: Container()),
              Image.asset(
                'assets/images/logo/ai.jpg',
                width: screenWidth * 0.75,
              ),
              Expanded(
                flex: 10,
                child: _homeSite(),
              ),
              _madeWithLove(screenWidth),
              Expanded(child: Container()),
              _bottomAction(screenWidth),
              Expanded(child: Container()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _homeSite() {
    const url = 'https://github.com/leechanwoo-kor/bonfire_defense';
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: const Text(
        url,
        style: TextStyle(color: Colors.blue),
      ),
    );
  }

  void _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
  }

  Widget _topAction(BuildContext context, double screenWidth) => Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.chevron_left,
                  size: screenWidth * 0.1, color: Colors.black),
              onPressed: () => _back(context),
            ),
            Expanded(child: Container()),
          ],
        ),
      );

  Widget _madeWithLove(double screenWidth) => Row(
        children: [
          Expanded(child: Container()),
          Text(
            'Made with ',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.grey[600]),
          ),
          Icon(
            Icons.favorite,
            size: screenWidth * 0.05,
            color: Colors.red,
          ),
          Expanded(child: Container()),
        ],
      );

  Widget _bottomAction(double screenWidth) => Row(
        children: [
          Expanded(child: Container()),
          Text(
            'Powered by',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.grey[600]),
          ),
          SizedBox(width: screenWidth * 0.05),
          FlutterLogo(size: screenWidth * 0.08),
          Icon(
            Icons.close,
            size: screenWidth * 0.05,
            color: Colors.black54,
          ),
          Image.asset(
            'assets/images/logo/bonfire.gif',
            width: screenWidth * 0.08,
          ),
          Expanded(child: Container()),
        ],
      );
}
