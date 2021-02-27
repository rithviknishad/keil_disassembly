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
  final rawDisassemblyController = TextEditingController();

  String stage1Output;

  final stage2Controller = TextEditingController();
  final stage3Controller = TextEditingController();
  final stage4Controller = TextEditingController();

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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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

                      stage2Controller.text =
                          stage2Output ?? "No data provided";

                      stage3Controller.text =
                          stage3Output ?? "No data provided";

                      stage4Controller.text =
                          stage4Output ?? "No data provided";
                    }),
                  ),
                ),

                // Stage 1
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Text("Stage 1 :"),
                      Text(
                        r"replaceAll(r'^\s{0}\d{1}:.+\n', '')",
                        style: TextStyle(color: theme.unselectedWidgetColor),
                      ),
                    ],
                  ),
                ),
                CupertinoScrollbar(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: ShapeDecoration(
                          color: theme.accentColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          )),
                      constraints: BoxConstraints(maxHeight: 400),
                      child: CupertinoScrollbar(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Text(
                            stage1Output ?? "No data provided",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: theme.primaryColor.withOpacity(0.75)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Stage 2
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Text("Stage 2 :"),
                      Text(
                        r"stage1.replaceAll(r'\s{2}.+', '')",
                        style: TextStyle(color: theme.unselectedWidgetColor),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () async {
                      if (stage1Output == null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Hey! Give an input to stage 0!"),
                          backgroundColor: theme.errorColor,
                        ));

                        return;
                      }
                      final data = ClipboardData(text: stage2Output ?? "");
                      await Clipboard.setData(data);

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Stage 2 output copied!"),
                      ));
                    },
                    icon: Icon(CupertinoIcons.doc_on_clipboard),
                    label: Text('Copy to clipboard'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: stage2Controller,
                    readOnly: true,
                    minLines: 8,
                    maxLines: null,
                  ),
                ),

                // Stage 3
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Text("Stage 3 :"),
                      Text(
                        r"stage1.replaceAll(r'^C:0x\w{1}\s{0}', '').replaceAll(r'\s{1,}.+$(\n|)', '\n')",
                        style: TextStyle(color: theme.unselectedWidgetColor),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () async {
                      if (stage1Output == null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Hey! Give an input to stage 0!"),
                          backgroundColor: theme.errorColor,
                        ));

                        return;
                      }
                      final data = ClipboardData(text: stage3Output ?? "");
                      await Clipboard.setData(data);

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Stage 3 output copied!"),
                      ));
                    },
                    icon: Icon(CupertinoIcons.doc_on_clipboard),
                    label: Text('Copy to clipboard'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: stage3Controller,
                    readOnly: true,
                    minLines: 8,
                    maxLines: null,
                  ),
                ),

                // Stage 4
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Text("Stage 4 :"),
                      Text(
                        r"stage1.replaceAll(r'^C:0x\w{1}\s{0}\w{1}\s{0}', '')",
                        style: TextStyle(color: theme.unselectedWidgetColor),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () async {
                      if (stage1Output == null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Hey! Give an input to stage 0!"),
                          backgroundColor: theme.errorColor,
                        ));

                        return;
                      }
                      final data = ClipboardData(text: stage4Output ?? "");
                      await Clipboard.setData(data);

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Stage 4 output copied!"),
                      ));
                    },
                    icon: Icon(CupertinoIcons.doc_on_clipboard),
                    label: Text('Copy to clipboard'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: stage4Controller,
                    readOnly: true,
                    minLines: 8,
                    maxLines: null,
                  ),
                ),
              ],
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
