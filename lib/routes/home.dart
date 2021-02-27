import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_icons/flutter_icons.dart';
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
        actions: [
          if (kIsWeb)
            TextButton.icon(
              label: Text("See code at GitHub"),
              icon: Icon(AntDesign.github),
              onPressed: () async {
                var urlString =
                    "https://github.com/rithviknishad/keil_disassembly";

                if (await canLaunch(urlString))
                  await launch(urlString);
                else
                  throw "Something went wrong!";
              },
            ),
          if (kIsWeb) SizedBox(width: 30),
          if (kIsWeb)
            TextButton.icon(
              label: Text("Support"),
              icon: Icon(Feather.heart),
              onPressed: () async {
                var urlString = "https://buymeacoffee.com/rithviknishad/";

                if (await canLaunch(urlString))
                  await launch(urlString);
                else
                  throw "Something went wrong!";
              },
            ),
          if (kIsWeb) SizedBox(width: 30),
        ],
      ),
      body: CupertinoScrollbar(
        isAlwaysShown: true,
        thickness: 6,
        thicknessWhileDragging: 16,
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
              margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "How am I useful?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Repetitive useless tasks are not for humans. This tool helps you fill up that disassembly table within seconds.\n\n\n"
                      "Time complexity to fill that table without this tool: O(n).\n"
                      "Time complexity to fill that table without this tool: O(1).\n\n",
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Usage instructions: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "1. After debugging the program, select the first disassembly output line.\n\n"
                      "2. Hold the `Shift + Down Arrow` key, until the last line NOP.\n\n"
                      "3. `Ctrl + C` or right click and copy (if you are a mouse).\n\n"
                      "4. Paste it below in the text field before Stage 1.\n\n"
                      "5. Make sure you add the necessary empty rows in your table before proceeding.\n\n"
                      "6. Stage 2, 3 and 4 are the column-wise filtered output. Copy each of the columns required.\n\n"
                      "7. Drag and select the column cells for which to be pasted.\n\n"
                      "8. `Ctrl + V`\n\n"
                      "\n"
                      "Yipee! Now you got more time to sleep!\n\n",
                    ),
                  ),
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
                  if (stage1Output != null)
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "# of rows in export: ${stage1Output.split('\n').length}",
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

    return FadeInUp(
      preferences: animPref400,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
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
                  color: Colors.grey[50].withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
              child: CupertinoScrollbar(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(8),
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    output ?? "No data provided",
                    textAlign: TextAlign.left,
                    style:
                        TextStyle(color: theme.primaryColor.withOpacity(0.75)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
