import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse(
            'Your-ghPage-Link-Here'), //Paste your github page containing documentation link here
        //get the help page hosted as github page at initial state for webview loading
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebViewWidget(
          controller: controller, //load the github page storead as Readme.md
        ),
      ),
    );
  }
}
