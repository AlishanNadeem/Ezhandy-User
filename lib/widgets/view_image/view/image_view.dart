import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:photo_view/photo_view.dart';

// import 'package:ezhandy_user/utils/asset_path.dart';
// ignore: must_be_immutable
class FullScreenImageViewer extends StatefulWidget {
  String type, path;

  FullScreenImageViewer({required this.path, required this.type});

  @override
  State<FullScreenImageViewer> createState() => _FullScreenImageViewerState();
}

class _FullScreenImageViewerState extends State<FullScreenImageViewer> {
  ImageProvider imageProvider = AssetImage(AssetPath.userIcon);
  @override
  void initState() {
    // TODO: implement initState

    switch (widget.type) {
      case "network":
        imageProvider = NetworkImage(widget.path);
        break;
      case "asset":
        imageProvider = AssetImage(AssetPath.userIcon);
        break;
      case "file":
        imageProvider = FileImage(File(widget.path));
        break;
      default:
        throw Exception('Unknown image type');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Center(
          child: PhotoView(
            imageProvider: imageProvider,
            backgroundDecoration: BoxDecoration(
              color: AppColors.black,
            ),
          ),
        ),
      ),
    );
  }
}
