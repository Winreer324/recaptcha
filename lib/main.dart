import 'package:flutter/material.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

void main() {
  runApp(const WebViewPlusExample());
}

class WebViewPlusExample extends StatelessWidget {
  const WebViewPlusExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WebViewPlusExampleMainPage(),
    );
  }
}

class WebViewPlusExampleMainPage extends StatefulWidget {
  const WebViewPlusExampleMainPage({Key? key}) : super(key: key);

  @override
  _WebViewPlusExampleMainPageState createState() => _WebViewPlusExampleMainPageState();
}

class _WebViewPlusExampleMainPageState extends State<WebViewPlusExampleMainPage> {
  WebViewPlusController? _controller;
  double _height = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('webview_flutter_plus Example'),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            // height: _height,
            height: 500,
            child: WebViewPlus(
              initialUrl: 'assets/index.html',
              onWebViewCreated: (controller) {
                _controller = controller;
              },
              javascriptChannels: Set.from([
                JavascriptChannel(
                    name: 'Captcha',
                    onMessageReceived: (JavascriptMessage message) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Scaffold(
                              body: Center(
                                child: Text(
                                  "Welcome",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            )),
                      );
                    })
              ]),
              onPageFinished: (url) {
                _controller?.getHeight().then((double height) {
                  debugPrint("Height: " + height.toString());
                  setState(() {
                    _height = height;
                  });
                });
              },
              javascriptMode: JavascriptMode.unrestricted,
            ),
          )
        ],
      ),
    );
  }
}
