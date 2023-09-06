import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app/view/home/home.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleScreen extends StatefulWidget {
  final blogUrl;

  const ArticleScreen({super.key, this.blogUrl});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  final Completer<WebViewController> _completer =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop(MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ));
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          backgroundColor: Colors.white,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'News',
                style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),
              ),
              Text(
                'App',
                style: TextStyle(color: Colors.red,fontWeight: FontWeight.w600),
              )
            ],
          ),
          actions: const [
            Opacity(
              opacity: 0,
              child: SizedBox(
                child:  Icon(Icons.abc),
              ),
            )
          ],
          elevation: 0,
        ),
        body: SizedBox(
            child: WebView(
          initialUrl: widget.blogUrl,
          onWebViewCreated: ((WebViewController webViewController) {
            _completer.complete(webViewController);
          }),
        )),
      ),
    );
  }
}
