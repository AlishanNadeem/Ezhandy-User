// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/utils/enums.dart';
import 'package:ezhandy_user/utils/utils.dart';
import 'package:ezhandy_user/utils/app_shadows.dart';

class ProfilePictureWidget extends StatelessWidget {
  final File? profileImage;
  final Function(File)? setFile;
  final String? profileImageUrl;
  bool? is_pickImage;
  Color? borderColor;
  double? size;
  String? assetPath;
  bool showUpload;

  ProfilePictureWidget({
    super.key,
    this.profileImage,
    this.setFile,
    this.profileImageUrl,
    this.is_pickImage = true,
    this.showUpload = false,
    this.borderColor,
    this.assetPath,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => is_pickImage == true
          ? AppDialogs.showImageSourceDialog( context, setFile: setFile)
          : Utils.onTapViewImage(
              context: context,
              image: AssetPath.userIcon,
              //mediaType: MediaPathType.network.name,
              mediaType: MediaPathType.asset.name,
            ),
      child: _cameraIcon(context),
    );
  }

  Widget _cameraIcon(context) {
    return Stack(clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
            boxShadow: AppShadows.shadow1,
            shape: BoxShape.circle,
            border: Border.all(color: borderColor ?? AppColors.orange, width: 2.sp),
          ),
          child: Container(
            height: size ?? 100.h,
            width: size ?? 100.w,
            decoration: BoxDecoration(
              color: AppColors.green,
              shape: BoxShape.circle,
              image: profileImage != null
                  ? DecorationImage(image: FileImage(profileImage!), fit: BoxFit.cover)
                  : profileImageUrl != null && profileImageUrl != ""
                      ? DecorationImage(image: NetworkImage(
                          // NetworkStrings.BASE_URL +
                          profileImageUrl!), fit: BoxFit.cover)
                      : DecorationImage(
                          image: AssetImage(assetPath ?? AssetPath.userIcon),
                          scale: assetPath != null ? 2 : 4.0,
                          fit: assetPath == null ? null : BoxFit.cover),
            ),
          ),
        ),
        Visibility(
          visible: showUpload,
          child: Positioned(
            top: 10,
            right: -10,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.white, width: 2.sp),
                  shape: BoxShape.circle,
                  // gradient: AppGradients.backgroundGradient,
                  color: AppColors.orange,
                  image: DecorationImage(image: AssetImage(AssetPath.cameraUploadIcon), scale: 3.sp)),
            ),
          ),
        )
      ],
    );
  }
}
