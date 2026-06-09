import 'package:ezhandy_user/module/core/all_services/controller/favourites_services_controller.dart';
import 'package:ezhandy_user/module/core/all_services/routing_arguments/service_routing_arguments.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/enums.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/widgets/Container/custom_container.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

class FavouritesServices extends StatefulWidget {
  const FavouritesServices({super.key});

  @override
  State<FavouritesServices> createState() => _FavouritesServicesState();
}

class _FavouritesServicesState extends State<FavouritesServices> {
  FavouritesServicesController get _controller {
    if (Get.isRegistered<FavouritesServicesController>()) {
      return Get.find<FavouritesServicesController>();
    }
    return Get.put(FavouritesServicesController());
  }

  @override
  void dispose() {
    if (Get.isRegistered<FavouritesServicesController>()) {
      Get.delete<FavouritesServicesController>();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
        leading: AssetPath.backIcon,
        onclickLead: () {
          Get.back();
        },
        // appBarheight: 50.h,
        title: AppStrings.myFavorites,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
          child: Obx(() {
            final list = _controller.items;
            final loading = _controller.isLoading.value;

            if (loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (list.isEmpty) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 48.h),
                  child: CustomText(
                    text: AppStrings.noFavouriteServicesFound,
                    color: AppColors.greyLight,
                    is_alignLeft: false,
                  ),
                ),
              );
            }

            return ListView.separated(
              padding: EdgeInsets.only(
                  top: AppPadding.padding20, bottom: AppPadding.padding25),
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, index) {
                final row = list[index];
                final service = row['service'];
                final sMap = service is Map
                    ? Map<String, dynamic>.from(service)
                    : <String, dynamic>{};
                final title =
                    sMap['title']?.toString().trim().isNotEmpty == true
                        ? sMap['title'].toString()
                        : AppStrings.titleName;
                final desc = sMap['description']?.toString().trim().isNotEmpty ==
                        true
                    ? sMap['description'].toString()
                    : AppStrings.lorem5;
                final amount = _cardAmount(sMap);
                final imageUrl = _resolveMediaUrl(sMap['imageUrl']);
                final user = sMap['user'];
                final userMap =
                    user is Map ? Map<String, dynamic>.from(user) : null;
                final providerId = userMap?['id']?.toString() ??
                    sMap['userId']?.toString();
                final stId = sMap['serviceTypeId'];
                final serviceTypeId = stId is int
                    ? stId
                    : int.tryParse(stId?.toString() ?? '');
                final providerServiceId = sMap['id']?.toString() ??
                    row['serviceId']?.toString();
                final isQuick = sMap['isQuickService'] == true;
                final deleteServiceId =
                    FavouritesServicesController.serviceApiIdFromRow(row);
                final heartBusy =
                    _controller.removingServiceId.value == deleteServiceId;

                return singleContainer(
                  amount: amount,
                  index: index,
                  isFav: true,
                  heartBusy: heartBusy,
                  imageUrl: imageUrl,
                  title: title,
                  description: desc,
                  ontapLike: deleteServiceId.isEmpty || heartBusy
                      ? () {}
                      : () => _controller
                          .removeServiceFromFavourites(deleteServiceId),
                  onTap: () {
                    AppNavigation.navigateTo(
                      context,
                      AppRoutes.serviceDetailsScreenRoute,
                      arguments: ServiceRoutingArgument(
                        type: isQuick
                            ? ServiceType.instant.name
                            : ServiceType.schedule.name,
                        serviceId: serviceTypeId,
                        providerId: providerId,
                        providerServiceId: providerServiceId,
                      ),
                    );
                  },
                );
              },
              separatorBuilder: (context, index) {
                return 10.verticalSpace;
              },
            );
          }),
        ));
  }

  String _cardAmount(Map<String, dynamic> service) {
    final v = service['hourlyRate'] ?? service['visitCharges'];
    if (v == null) return '0';
    return v.toString();
  }

  String _resolveMediaUrl(dynamic path) {
    final s = path?.toString().trim() ?? '';
    if (s.isEmpty) return '';
    if (s.startsWith('http://') || s.startsWith('https://')) return s;
    return '${NetworkStrings.IMAGE_BASE_URL}$s';
  }

  Widget singleContainer(
      {required VoidCallback onTap,
      required int index,
      amount,
      ontapLike,
      isFav,
      bool heartBusy = false,
      required String imageUrl,
      required String title,
      required String description}) {
    final DecorationImage bgImage = imageUrl.isNotEmpty
        ? DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(imageUrl),
          )
        : const DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(AssetPath.tempCleaningImage),
          );

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 1.sw,
        height: 200.h, // fixed width for horizontal scrolling
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r), image: bgImage),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            10.verticalSpace,
            Row(
              children: [
                GestureDetector(
                    onTap: heartBusy ? null : ontapLike,
                    child: Icon(
                      isFav
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      size: 30.sp,
                      color: heartBusy
                          ? AppColors.grey.withValues(alpha: 0.5)
                          : null,
                    )),
                // Icon(Icons.favorite_border_rounded),

                Spacer(),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppColors.orange,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35.r),
                      bottomLeft: Radius.circular(35.r),
                    ),
                  ),
                  child: CustomText(
                    text: "\$$amount",
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
            Spacer(),
            detailsContainer(title: title, description: description),
          ],
        ),
      ),
    );
  }

  Widget detailsContainer(
      {required String title, required String description}) {
    return Padding(
      padding: EdgeInsets.all(AppPadding.padding12),
      child: CustomContainer(
        child: Row(
          children: [
            Image.asset(
              AssetPath.cleaningIcon,
              width: 30.w,
              height: 30.h,
            ),
            10.horizontalSpace,
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: title),
                  5.verticalSpace,
                  CustomText(
                    text: description,
                    maxLines: 3,
                    // overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
