import 'dart:io';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/utils.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerBottomSheet extends StatelessWidget {
  final Function(File)? setFile;
  final bool isVideo;

  ImagePickerBottomSheet({this.setFile, this.isVideo = false});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        // decoration: const BoxDecoration(
        //   gradient: LinearGradient(
        //       begin: Alignment.topCenter,
        //       end: Alignment.bottomCenter,
        //       colors: [
        //     AppColors.GREEN_COLOR,
        //     AppColors.BLUE_COLOR,
        //   ])),
        // height: 0.13.sh,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(
                Icons.photo_camera,
                color: AppColors.black,
              ),
              title: CustomText(
                text: "CAMERA",
                color: AppColors.black,
                // textAlign: TextAlign.start,
                fontWeight: FontWeight.w500,
              ),
              onTap: () => isVideo
                  ? Utils.openVideoPicker(
                      source: ImageSource.camera,
                      context: context,
                      setFile: setFile,
                    )
                  : Utils.openImagePicker(
                      source: ImageSource.camera,
                      context: context,
                      setFile: setFile,
                    ),
            ),
            Divider(
              // color: AppColors.gradient_1,
              height: 0,
            ),
            ListTile(
              leading: Icon(
                Icons.photo_library,
                color: AppColors.black,
              ),
              title: CustomText(
                text: "GALLERY",
                color: AppColors.black,
                // textAlign: TextAlign.start,
                fontWeight: FontWeight.w500,
              ),
              onTap: () => isVideo
                  ? Utils.openVideoPicker(
                      source: ImageSource.gallery,
                      context: context,
                      setFile: setFile,
                    )
                  : Utils.openImagePicker(
                      source: ImageSource.gallery,
                      context: context,
                      setFile: setFile,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
