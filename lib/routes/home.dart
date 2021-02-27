import 'package:buy_me_a_coffee_widget/buy_me_a_coffee_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:keil_disassembly/partials/animprefs.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: theme.primaryColor,
      statusBarIconBrightness: Brightness.light,
    ));

    return Scaffold(
      appBar: AppBar(
        title: FadeInLeft(
          preferences: animPref400,
          child: Text(
            'Keil Disassembly RegEx Clipboard Generator Tool',
            style: TextStyle(
                fontWeight: FontWeight.w400, color: theme.primaryColor),
          ),
        ),
      ),
      body: CupertinoScrollbar(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 800),
              child: Card(
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 400,
                        child: TextField(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        width: 217.0,
        child: BuyMeACoffeeWidget(
          sponsorID: "rithviknishad",
          theme: OrangeTheme(),
        ),
      ),
    );
  }
}
