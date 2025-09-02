import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class AppLogo extends StatelessWidget {
  double? scale;
  String? assetPath;
  AppLogo({Key? key, this.scale, this.assetPath}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Image.asset(assetPath ?? AssetPath.appLogoImage, scale: scale ?? 5.5.sp);
  }
}
