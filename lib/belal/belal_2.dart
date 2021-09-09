// import 'package:flutter/material.dart';
// import 'package:model_viewer/model_viewer.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'dart:async';
//
// class BelalTwo extends StatefulWidget {
//   @override
//   _BelalTwoState createState() => _BelalTwoState();
// }
//
// class _BelalTwoState extends State<BelalTwo> {
//   final Completer<WebViewController> _controller =
//   Completer<WebViewController>();
//   bool isLoading = true;
//   final _key = UniqueKey();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Model'),
//       ),
//       body: Column(
//         children: [
//           SizedBox(
//             height: 25,
//           ),
//           Expanded(
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Color(0xffF3F3F3),
//                 borderRadius: BorderRadius.only(
//                   topRight: Radius.circular(30),
//                   topLeft: Radius.circular(30),
//                 ),
//               ),
//               child: Stack(children: [
//                 WebView(
//                   key: _key,
//                   onPageFinished: (finish) {
//                     setState(() {
//                       isLoading = false;
//                     });
//                   },
//                   initialUrl: widget.url,
//                   javascriptMode: JavascriptMode.unrestricted,
//                   onWebViewCreated: (WebViewController webViewController) {
//                     _controller.complete(webViewController);
//                   },
//                 ),
//                 isLoading
//                     ? Center(
//                   child: CircularProgressIndicator(),
//                 )
//                     : Stack(),
//               ]),
//             ),
//           ),
//
//           Expanded(
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Color(0xffF3F3F3),
//                 borderRadius: BorderRadius.only(
//                   topRight: Radius.circular(30),
//                   topLeft: Radius.circular(30),
//                 ),
//               ),
//               child: Stack(children: [
//                 WebView(
//                   key: _key,
//                   onPageFinished: (finish) {
//                     setState(() {
//                       isLoading = false;
//                     });
//                   },
//                   initialUrl:'https://planner5d.com/v/?key=e748a3aeb258f736ea6ef4d1f6c49c9f&viewMode=3d',
//                   javascriptMode: JavascriptMode.unrestricted,
//                   onWebViewCreated: (WebViewController webViewController) {
//                     _controller.complete(webViewController);
//                   },
//                 ),
//                 isLoading
//                     ? Center(
//                   child: CircularProgressIndicator(),
//                 )
//                     : Stack(),
//               ]),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
