import 'package:buy_me_a_coffee_widget/buy_me_a_coffee_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Smash Keil Disassembly Clipboard Generator"),
      ),
      body: CupertinoScrollbar(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Hello"),
            ],
          ),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () async {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "opening www.buymeacoff.ee/rithviknishad in a new tab",
              ),
            ),
          );
          var urlString = "https://www.buymeacoff.ee/rithviknishad";
          if (await canLaunch(urlString)) {
            await launch(urlString);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Coffee out-of-stock"),
              ),
            );
          }
        },
        child: Container(
          width: 217.0,
          child: BuyMeACoffeeWidget(
            sponsorID: "rithviknishad",
            theme: OrangeTheme(),
          ),
        ),
      ),
    );
  }
}
