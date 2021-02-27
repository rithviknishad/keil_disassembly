import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keil_disassembly/partials/animprefs.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final rawDisassemblyController = TextEditingController();

  String stage1Output;

  String get stage2Output =>
      (stage1Output ?? "").replaceAll(RegExp(r'\s{2,}.+', multiLine: true), '');

  String get stage3Output => (stage1Output ?? "")
      .replaceAll(RegExp(r'^C:0x\w{1,}\s{0,}', multiLine: true), '')
      .replaceAll(RegExp(r'\s{1,}.+$(\n|)', multiLine: true), '\n');

  String get stage4Output => (stage1Output ?? "").replaceAll(
      RegExp(r'^C:0x\w{1,}\s{0,}\w{1,}\s{0,}', multiLine: true), '');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      appBar: AppBar(
        title: FadeInLeft(
          preferences: animPref400,
          child: Text(
            'Keil Disassembly RegEx Tool',
            style: TextStyle(
                fontWeight: FontWeight.w400, color: theme.primaryColor),
          ),
        ),
      ),
      body: CupertinoScrollbar(
        isAlwaysShown: true,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: 800),
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  )),
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Paste your program's disassembly output here"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: rawDisassemblyController,
                      cursorRadius: Radius.circular(10),
                      cursorHeight: 24,
                      minLines: 8,
                      maxLines: null,
                      onChanged: (_) => setState(() {
                        stage1Output = rawDisassemblyController.text.replaceAll(
                            RegExp(r'^\s{0,}\d{1,}:.+\n', multiLine: true), '');
                      }),
                    ),
                  ),
                  StageOutput(
                    stageNumber: 1,
                    method: r"replaceAll(r'^\s{0}\d{1}:.+\n', '')",
                    output: stage1Output,
                  ),
                  StageOutput(
                    stageNumber: 2,
                    method: r"stage1.replaceAll(r'\s{2}.+', '')",
                    output: stage2Output,
                  ),
                  StageOutput(
                    stageNumber: 3,
                    method:
                        r"stage1.replaceAll(r'^C:0x\w{1}\s{0}', '').replaceAll(r'\s{1,}.+$(\n|)', '\n')",
                    output: stage3Output,
                  ),
                  StageOutput(
                    stageNumber: 4,
                    method:
                        r"stage1.replaceAll(r'^C:0x\w{1}\s{0}', '').replaceAll(r'\s{1,}.+$(\n|)', '\n')",
                    output: stage4Output,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          "Buy me a coffee!",
          style: GoogleFonts.cookie(
            color: Colors.black,
            fontSize: 28.0,
            letterSpacing: 0.6,
          ),
        ),
        icon: Material(
          color: Colors.white,
          child: Image.asset(
            'assets/bmc_icon.png',
            width: 30,
          ),
        ),
        backgroundColor: Color(0xFFFFDB38),
        tooltip: "https://buymeacoff.ee/rithviknishad",
        onPressed: () async {
          var urlString = "https://buymeacoff.ee/rithviknishad";

          if (await canLaunch(urlString))
            await launch(urlString);
          else
            throw "Something went wrong!";
        },
      ),
      // Container(
      //   width: 217.0,
      // child: BuyMeACoffeeWidget(
      //     sponsorID: "rithviknishad",
      //     theme: OrangeTheme(),
      //   ),
      // ),
    );
  }
}

class StageOutput extends StatelessWidget {
  final int stageNumber;
  final String method;
  final String output;

  const StageOutput({
    @required this.stageNumber,
    @required this.method,
    @required this.output,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: 8,
              runSpacing: 8,
              children: [
                Text("Stage $stageNumber :"),
                Text(
                  method,
                  style: TextStyle(color: theme.unselectedWidgetColor),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () async {
                      if (output == null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Nothing to copy!"),
                          backgroundColor: theme.errorColor,
                        ));

                        return;
                      }
                      final data = ClipboardData(text: output ?? "");
                      await Clipboard.setData(data);

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Stage $stageNumber output copied!"),
                      ));
                    },
                    icon: Icon(CupertinoIcons.doc_on_clipboard),
                    label: Text('Copy output'),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            )),
            constraints: BoxConstraints(maxHeight: 200),
            child: CupertinoScrollbar(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8),
                scrollDirection: Axis.horizontal,
                child: CupertinoScrollbar(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      output ?? "No data provided",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: theme.primaryColor.withOpacity(0.75)),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
