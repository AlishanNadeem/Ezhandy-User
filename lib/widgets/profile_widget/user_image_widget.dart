// ignore_for_file: must_be_immutable

import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:flutter/material.dart';
import 'package:ezhandy_user/utils/enums.dart';
import 'package:ezhandy_user/utils/utils.dart';

class UserImageWidget extends StatelessWidget {
  String? image;
  double size;
  Color? color;
  final Function()? onAvatarTap;
  UserImageWidget(
      {Key? key, this.image, this.color, this.size = 30, this.onAvatarTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onAvatarTap ??
            () {
              Utils.onTapViewImage(
                  context: context,
                  image: AssetPath.userIcon,
                  //mediaType: MediaPathType.network.name,
                  mediaType: MediaPathType.asset.name);
            },
        child: CircleAvatar(
          radius: size,
          backgroundColor: color ?? AppColors.white,
          child: image == null || image!.trim().isEmpty
              ? CircleAvatar(
                  radius: size - 2,
                  backgroundImage: const AssetImage(AssetPath.avatarIcon))
              : ClipOval(
                  child: Image.network(
                    image!,
                    width: size * 2,
                    height: size * 2,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => CircleAvatar(
                      radius: size - 2,
                      backgroundImage:
                          const AssetImage(AssetPath.avatarIcon),
                    ),
                  ),
                ),
        ));
  }
}
