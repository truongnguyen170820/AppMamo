// import 'package:flutter/material.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
// import 'package:mamo/widget/common_appbar.dart';
//
// class HelpWebView extends StatefulWidget {
//   @override
//   _HelpWebViewState createState() => _HelpWebViewState();
// }
//
// class _HelpWebViewState extends State<HelpWebView> {
//   final flutterWebViewPlugin = FlutterWebviewPlugin();
//   @override
//   Widget build(BuildContext context) {
//     return WebviewScaffold(
//       appBar: backAppBar(context, 'Hướng dẫn'),
//       url: 'http://sutichcaykhe.com/index.php',
//       // url: 'http://topthuthuat.vn/',
//       mediaPlaybackRequiresUserGesture: false,
//       withZoom: true,
//       withLocalStorage: true,
//       hidden: true,
//       initialChild: Container(
//         color: Colors.white,
//         child: Center(
//           child: Text('Đang tải...', style: TextStyle(color: Colors.black54),),
//         ),
//       ),
//       bottomNavigationBar: BottomAppBar(
//         child: Row(
//           children: <Widget>[
//             IconButton(
//               icon: const Icon(Icons.arrow_back_ios),
//               onPressed: () {
//                 flutterWebViewPlugin.goBack();
//               },
//             ),
//             IconButton(
//               icon: const Icon(Icons.arrow_forward_ios),
//               onPressed: () {
//                 flutterWebViewPlugin.goForward();
//               },
//             ),
//             IconButton(
//               icon: const Icon(Icons.autorenew),
//               onPressed: () {
//                 flutterWebViewPlugin.reload();
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   @override
//   void dispose(){
//     flutterWebViewPlugin.dispose();
//     super.dispose();
//   }
// }
