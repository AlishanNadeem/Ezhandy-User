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
    final imageUrl = image?.trim() ?? '';
    final hasNetworkImage = imageUrl.isNotEmpty;

    return GestureDetector(
        onTap: onAvatarTap ??
            () {
              if (hasNetworkImage) {
                Utils.onTapViewImage(
                  context: context,
                  image: imageUrl,
                  mediaType: MediaPathType.network.name,
                );
              } else {
                Utils.onTapViewImage(
                  context: context,
                  image: AssetPath.avatarIcon,
                  mediaType: MediaPathType.asset.name,
                );
              }
            },
        child: CircleAvatar(
          radius: size,
          backgroundColor: color ?? AppColors.white,
          child: !hasNetworkImage
              ? CircleAvatar(
                  radius: size - 2,
                  backgroundImage: const AssetImage(AssetPath.avatarIcon))
              : ClipOval(
                  child: Image.network(
                    imageUrl,
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
