// import 'dart:async';
// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:path_provider/path_provider.dart';

// class PDFViewerScreen extends StatefulWidget {
//   final String pdfUrl;
//   bool is_asset;

//   PDFViewerScreen({required this.pdfUrl,required this.is_asset});

//   @override
//   _PDFViewerScreenState createState() => _PDFViewerScreenState();
// }

// class _PDFViewerScreenState extends State<PDFViewerScreen> {
//    final Completer<PDFViewController> _controller =
//       Completer<PDFViewController>();
//   int? pages = 0;
//   int? currentPage = 0;
//   bool isReady = false;
//   String errorMessage = '';
//   String remotePDFpath = "";

// @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     if(widget.is_asset==true){
//         fromAsset(widget.pdfUrl).then((f) {
//       setState(() {
//         remotePDFpath = f.path;
//       });
//     });
//     }else{

//     createFileOfPdfUrl().then((f) {
//       setState(() {
//         remotePDFpath = f.path;
//       });
//     });
//     }

//   }

//    Future<File> createFileOfPdfUrl() async {
//     Completer<File> completer = Completer();
//     print("Start download file from internet!");
//     try {
//       final url = widget.pdfUrl;
//       final filename = url.substring(url.lastIndexOf("/") + 1);
//       var request = await HttpClient().getUrl(Uri.parse(url));
//       var response = await request.close();
//       var bytes = await consolidateHttpClientResponseBytes(response);
//       var dir = await getApplicationDocumentsDirectory();
//       print("Download files");
//       print("${dir.path}/$filename");
//       File file = File("${dir.path}/$filename");

//       await file.writeAsBytes(bytes, flush: true);
//       completer.complete(file);
//       remotePDFpath = file.path;
//       if(remotePDFpath.isEmpty){
//       }else{
//         setState(() {
//           isReady=true;
//         });
//       }
//     } catch (e) {
//       throw Exception('Error parsing asset file!');
//     }

//     return completer.future;
//   }


//     Future<File> fromAsset(String asset) async {
//     Completer<File> completer = Completer();

//     try {
//       var dir = await getApplicationDocumentsDirectory();
//       final filename = asset.substring(asset.lastIndexOf("/") + 1);
//       File file = File("${dir.path}/$filename");
//       var data = await rootBundle.load(asset);
//       var bytes = data.buffer.asUint8List();
//       await file.writeAsBytes(bytes, flush: true);
//       completer.complete(file);
//       remotePDFpath = file.path;
//       if(remotePDFpath.isEmpty){
//       }else{
//         setState(() {
//           isReady=true;
//         });
//       }
//     } catch (e) {
//       throw Exception('Error parsing asset file!');
//     }

//     return completer.future;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('PDF Viewer'),
//       ),
//       body:  Stack(
//         children: <Widget>[
//           Visibility(
//             visible: isReady,
//             child: PDFView(
//               filePath: remotePDFpath,
//               enableSwipe: true,
//               swipeHorizontal: true,
//               autoSpacing: false,
//               pageFling: true,
//               pageSnap: true,
//               defaultPage: 1,
//               fitPolicy: FitPolicy.BOTH,
//               preventLinkNavigation:
//                   false, // if set to true the link is handled in flutter
//               onRender: (_pages) {
//                 setState(() {
//                   pages = _pages;
//                   isReady = true;
//                 });
//               },
//               onError: (error) {
//                 setState(() {
//                   errorMessage = error.toString();
//                 });
//                 print(error.toString());
//               },
//               onPageError: (page, error) {
//                 setState(() {
//                   errorMessage = '$page: ${error.toString()}';
//                 });
//                 print('$page: ${error.toString()}');
//               },
//               onViewCreated: (PDFViewController pdfViewController) {
//                 _controller.complete(pdfViewController);
//               },
//               onLinkHandler: (String? uri) {
//                 print('goto uri: $uri');
//               },
//               onPageChanged: (int? page, int? total) {
//                 print('page change: $page/$total');
//                 setState(() {
//                   currentPage = page;
//                 });
//               },
//             ),
//           ),
//           errorMessage.isEmpty
//               ? !isReady
//                   ? Center(
//                       child: CircularProgressIndicator(),
//                     )
//                   : Container()
//               : Center(
//                   child: Text(errorMessage),
//                 )
//         ],
//       ),

//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerScreen extends StatelessWidget {
  final File? file; // For local PDF
  final String? url,title; // For online PDF

   PdfViewerScreen({super.key,this.title ,this.file, this.url});

  @override
  Widget build(BuildContext context) {
    return 
    
    
    BackgroundImage(
        leading: AssetPath.backIcon,
        onclickLead: () {
          Get.back();
        },
        // appBarheight: 50.h,
        title: AppStrings.pitchTemplate,
        child: 
    
    
    
   file != null
          ? SfPdfViewer.file(file!) // 📂 Local file
          : SfPdfViewer.network(url!), // 🌐 Online URL
    );
  }
}
