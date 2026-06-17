import 'package:ezhandy_user/module/core/all_services/controller/favourites_services_controller.dart';
import 'package:ezhandy_user/module/core/all_services/routing_arguments/service_routing_arguments.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/enums.dart';
import 'package:ezhandy_user/utils/media_url_helper.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/widgets/Container/custom_container.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:ezhandy_user/widgets/profile_widget/user_image_widget.dart';
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

class _FavouritesServicesState extends State<FavouritesServices>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  FavouritesServicesController get _controller {
    if (Get.isRegistered<FavouritesServicesController>()) {
      return Get.find<FavouritesServicesController>();
    }
    return Get.put(FavouritesServicesController());
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
          child: Column(
            children: [
              15.verticalSpace,
              Container(
                decoration: BoxDecoration(
                  color: AppColors.greyBorder.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: AppColors.orange,
                  ),
                  dividerColor: AppColors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  overlayColor:
                      const WidgetStatePropertyAll(AppColors.transparent),
                  onTap: (index) {
                    setState(() {});
                    if (index == 1) {
                      _controller.fetchFavouriteProviders();
                    }
                  },
                  tabs: [
                    _tabLabel(AppStrings.services, 0),
                    _tabLabel(AppStrings.providers, 1),
                  ],
                ),
              ),
              10.verticalSpace,
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _servicesTab(),
                    _providersTab(),
                  ],
                ),
              ),
              25.verticalSpace,
            ],
          ),
        ));
  }

  Tab _tabLabel(String label, int index) {
    return Tab(
      child: ListenableBuilder(
        listenable: _tabController,
        builder: (context, _) {
          final selected = _tabController.index == index;
          return CustomText(
            text: label,
            is_alignLeft: false,
            fontSize: 14.sp,
            fontFamily: AppStrings.quicksand,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            color: selected ? AppColors.white : AppColors.black,
          );
        },
      ),
    );
  }

  Widget _servicesTab() {
    return Obx(() {
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
              itemCount: list.length,
              itemBuilder: (context, index) {
                final row = list[index];
                final service = row['service'];
                final sMap = service is Map
                    ? Map<String, dynamic>.from(service)
                    : <String, dynamic>{};
                final nestedServiceType = sMap['serviceType'];
                final serviceTypeMap = nestedServiceType is Map
                    ? Map<String, dynamic>.from(nestedServiceType)
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
                final imageUrl =
                    resolveMediaUrl(serviceTypeMap['imagePath']);
                final iconUrl =
                    resolveMediaUrl(serviceTypeMap['iconImagePath']);
                final user = sMap['user'];
                final userMap =
                    user is Map ? Map<String, dynamic>.from(user) : null;
                final providerId = userMap?['id']?.toString() ??
                    sMap['userId']?.toString();
                final stId =
                    serviceTypeMap['id'] ?? sMap['serviceTypeId'];
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
                  iconUrl: iconUrl,
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
          });
  }

  Widget _providersTab() {
    return Obx(() {
      final list = _controller.providerItems;
      final loading = _controller.isProvidersLoading.value;

      if (loading && list.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }
      if (list.isEmpty) {
        return Center(
          child: Padding(
            padding: EdgeInsets.only(top: 48.h),
            child: CustomText(
              text: AppStrings.noFavouriteProvidersFound,
              color: AppColors.greyLight,
              is_alignLeft: false,
            ),
          ),
        );
      }

      return ListView.separated(
        padding: EdgeInsets.only(
          top: AppPadding.padding20,
          bottom: AppPadding.padding25,
        ),
        itemCount: list.length,
        itemBuilder: (context, index) {
          final row = list[index];
          final provider =
              FavouritesServicesController.providerMapFromRow(row);
          final providerId =
              FavouritesServicesController.providerApiIdFromRow(row);
          final heartBusy =
              _controller.removingProviderId.value == providerId;

          return _providerCard(
            provider: provider,
            heartBusy: heartBusy,
            onTap: providerId.isEmpty
                ? () {}
                : () {
                    AppNavigation.navigateTo(
                      context,
                      AppRoutes.providerProfileScreenRoute,
                      arguments: ServiceRoutingArgument(
                        providerId: providerId,
                      ),
                    );
                  },
            onUnfavorite: providerId.isEmpty || heartBusy
                ? () {}
                : () => _controller.removeProviderFromFavourites(providerId),
          );
        },
        separatorBuilder: (context, index) => 20.verticalSpace,
      );
    });
  }

  Widget _providerCard({
    required Map<String, dynamic> provider,
    required VoidCallback onTap,
    required VoidCallback onUnfavorite,
    bool heartBusy = false,
  }) {
    final name = provider['fullName']?.toString().trim().isNotEmpty == true
        ? provider['fullName'].toString()
        : AppStrings.dummyName;
    final about = provider['aboutUs']?.toString().trim() ?? '';
    final address = provider['address']?.toString().trim() ?? '';
    final subtitle = about.isNotEmpty ? about : address;
    final rating = provider['rating'];
    final ratingText = rating == null ? '0' : rating.toString();
    final imageUrl = resolveMediaUrl(provider['profileImage']);

    return CustomContainer(
      onTap: onTap,
      isPadding: false,
      child: Padding(
        padding: const EdgeInsets.only(
          top: AppPadding.padding14,
          bottom: AppPadding.padding14,
          left: AppPadding.padding14,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UserImageWidget(
              image: imageUrl.isEmpty ? null : imageUrl,
              size: 28,
            ),
            5.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: name,
                    fontWeight: FontWeight.w500,
                    maxLines: 1,
                  ),
                  if (subtitle.isNotEmpty) ...[
                    4.verticalSpace,
                    CustomText(
                      text: subtitle,
                      maxLines: 2,
                      fontSize: 11.sp,
                      color: AppColors.grey,
                    ),
                  ],
                  5.verticalSpace,
                  Row(
                    children: [
                      CustomText(
                        text: '0 reviews',
                        maxLines: 1,
                        fontSize: 12.sp,
                      ),
                      10.horizontalSpace,
                      Icon(
                        Icons.star,
                        color: AppColors.orange,
                        size: 15.sp,
                      ),
                      CustomText(
                        text: ratingText,
                        color: AppColors.orange,
                        fontSize: 12.sp,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: GestureDetector(
                onTap: heartBusy ? null : onUnfavorite,
                child: Icon(
                  Icons.favorite_rounded,
                  size: 28.sp,
                  color: heartBusy
                      ? AppColors.grey.withValues(alpha: 0.5)
                      : AppColors.orange,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _cardAmount(Map<String, dynamic> service) {
    final v = service['hourlyRate'] ?? service['visitCharges'];
    if (v == null) return '0';
    return v.toString();
  }

  Widget _serviceIcon(String iconUrl) {
    if (iconUrl.isEmpty) {
      return Image.asset(
        AssetPath.cleaningIcon,
        width: 30.w,
        height: 30.h,
      );
    }
    return Image.network(
      iconUrl,
      width: 30.w,
      height: 30.h,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => Image.asset(
        AssetPath.cleaningIcon,
        width: 30.w,
        height: 30.h,
      ),
    );
  }

  Widget singleContainer(
      {required VoidCallback onTap,
      required int index,
      amount,
      ontapLike,
      isFav,
      bool heartBusy = false,
      required String imageUrl,
      required String iconUrl,
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
            detailsContainer(
              iconUrl: iconUrl,
              title: title,
              description: description,
            ),
          ],
        ),
      ),
    );
  }

  Widget detailsContainer({
    required String iconUrl,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: EdgeInsets.all(AppPadding.padding12),
      child: CustomContainer(
        child: Row(
          children: [
            _serviceIcon(iconUrl),
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
