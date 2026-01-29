import 'dart:io';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/utils.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class ShowImageSourceDialog extends StatefulWidget {
  final Function(File)? setFile;
  final Function(File)? setThumbnail; // <<< add this
  final bool isVideo;

  ShowImageSourceDialog({
    this.setFile,
    this.setThumbnail, // <<< add this
    this.isVideo = false,
  });
  @override
  State<ShowImageSourceDialog> createState() => _ShowImageSourceDialogState();
}

class _ShowImageSourceDialogState extends State<ShowImageSourceDialog>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation =
        CurvedAnimation(parent: _animationController!, curve: Curves.easeInOut);
    _animationController!.forward();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation!,
      child: Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 40.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        backgroundColor: AppColors.sourceWhiteBg,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                text: "Choose Option",
                is_alignLeft: false,
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
                color: AppColors.black,
              ),
              SizedBox(height: 30.h),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  10.horizontalSpace,
                  _buildOptionButton(
                    icon: Icons.photo_library,
                    label: "Gallery",
                    onTap: () => widget.isVideo
                        ? Utils.openVideoPicker(
                            source: ImageSource.gallery,
                            context: context,
                            setFile: widget.setFile,
                            setThumbnail: widget.setThumbnail)
                        : Utils.openImagePicker(
                            source: ImageSource.gallery,
                            context: context,
                            setFile: widget.setFile,
                          ),
                  ),
                  Spacer(),
                  _buildOptionButton(
                    icon: Icons.photo_camera,
                    label: "Camera",
                    onTap: () => widget.isVideo
                        ? Utils.openVideoPicker(
                            source: ImageSource.camera,
                            context: context,
                            setFile: widget.setFile,
                            setThumbnail: widget.setThumbnail)
                        : Utils.openImagePicker(
                            source: ImageSource.camera,
                            context: context,
                            setFile: widget.setFile,
                          ),
                  ),
                  10.horizontalSpace,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100.w,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColors.sourceWhiteBtn,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.grey.withOpacity(0.7),
              blurRadius: 5,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 36.sp, color: AppColors.black),
            SizedBox(height: 10.h),
            CustomText(
              text: label,
              is_alignLeft: false,
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              color: AppColors.black,
            ),
          ],
        ),
      ),
    );
  }
}
