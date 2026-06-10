import 'package:ezhandy_user/module/core/all_services/controller/single_service_controller.dart';
import 'package:ezhandy_user/module/core/all_services/routing_arguments/service_routing_arguments.dart';
import 'package:ezhandy_user/utils/enums.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/widgets/Container/custom_container.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:ezhandy_user/widgets/profile_widget/user_image_widget.dart';
import 'package:ezhandy_user/widgets/text_fields/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

class SingleService extends StatefulWidget {
  final String? serviceName;
  final String? type;
  final int? serviceId;

  const SingleService(
      {this.serviceName, this.type, this.serviceId, super.key});

  @override
  State<SingleService> createState() => _SingleServiceState();
}

class _SingleServiceState extends State<SingleService> {
  String get _controllerTag => 'single_service_${widget.serviceId ?? 'none'}';

  SingleServiceController get _controller {
    if (Get.isRegistered<SingleServiceController>(tag: _controllerTag)) {
      return Get.find<SingleServiceController>(tag: _controllerTag);
    }
    return Get.put(
      SingleServiceController(
        serviceId: widget.serviceId,
        isQuick: widget.type == ServiceType.instant.name,
      ),
      tag: _controllerTag,
    );
  }

  @override
  void dispose() {
    if (Get.isRegistered<SingleServiceController>(tag: _controllerTag)) {
      Get.delete<SingleServiceController>(tag: _controllerTag);
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
        title: widget.serviceName,
        appBarheight: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
          child: Column(
            children: [
              searchTextField(),
              10.verticalSpace,
              Expanded(
                child: Obx(() {
                  if (_controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (widget.serviceId == null) {
                    return Center(
                      child: CustomText(
                        text: "Missing service. Go back and pick a service.",
                        color: AppColors.greyLight,
                        is_alignLeft: false,
                      ),
                    );
                  }
                  final freelancers = _controller.filteredFreelancersList;
                  if (freelancers.isEmpty) {
                    return Center(
                      child: CustomText(
                        text: "No users found",
                        color: AppColors.greyLight,
                      ),
                    );
                  }
                  return ListView.separated(
                    padding: EdgeInsets.only(bottom: AppPadding.padding25),
                    shrinkWrap: true,
                    itemCount: freelancers.length,
                    itemBuilder: (context, index) {
                      final freelancer = freelancers[index];
                      return singleWidget(
                        freelancer: freelancer,
                        ontap: () {
                          AppNavigation.navigateTo(
                            context,
                            AppRoutes.providerProfileScreenRoute,
                            arguments: ServiceRoutingArgument(
                              type: widget.type,
                              serviceId: widget.serviceId,
                              providerId: _providerUserId(freelancer),
                            ),
                          );
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return 20.verticalSpace;
                    },
                  );
                }),
              ),
            ],
          ),
        ));
  }

  Widget searchTextField() {
    return CustomTextField(
      label: false,
      prefxicon: AssetPath.searchIcon,
      hint: AppStrings.searchAnything,
      inputFormatters: [LengthLimitingTextInputFormatter(35)],
      onchange: _controller.updateSearch,
    );
  }

  Widget singleWidget(
      {required dynamic freelancer, required VoidCallback ontap}) {
    final user = _freelancerUserMap(freelancer);
    final providerService = _primaryProviderService(freelancer);
    final name = _stringFrom(user, 'fullName') ?? '';
    final serviceTitle = _stringFrom(providerService, 'title');
    final hourly = _firstProviderHourlyRate(freelancer) ??
        user?['serviceHourlyRate'] ??
        freelancer['serviceHourlyRate'];
    final amountText = hourly == null ? '\$0/hr' : '\$$hourly/hr';
    final rating = providerService?['rating'] ??
        user?['rating'] ??
        freelancer['rating'];
    final ratingText = rating == null ? '0' : rating.toString();
    final reviewCount =
        user?['ratingCount']?.toString() ?? freelancer['ratingCount']?.toString() ?? '0';
    final imageUrl = _resolveProfileUrl(_profileImagePath(freelancer));
    final certifications = _certificationsList(freelancer);

    return CustomContainer(
      onTap: ontap,
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
                  if (serviceTitle != null && serviceTitle.isNotEmpty) ...[
                    4.verticalSpace,
                    CustomText(
                      text: serviceTitle,
                      maxLines: 2,
                      fontSize: 11.sp,
                      color: AppColors.grey,
                    ),
                  ],
                  5.verticalSpace,
                  Row(
                    children: [
                      CustomText(
                        text: '$reviewCount reviews',
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
                  if (certifications.isNotEmpty) ...[
                    8.verticalSpace,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Wrap(
                        spacing: 6.w,
                        runSpacing: 6.h,
                        children: certifications.map((c) {
                          final m = _asStringKeyedMap(c);
                          final title =
                              m?['certificationTitle']?.toString().trim() ?? '';
                          if (title.isEmpty) return SizedBox.shrink();
                          final institution =
                              m?['institutionName']?.toString().trim() ?? '';
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: AppColors.greyLight.withValues(alpha: 0.25),
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(
                                color: AppColors.greyLight.withValues(alpha: 0.6),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomText(
                                  text: title,
                                  maxLines: 2,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                if (institution.isNotEmpty) ...[
                                  2.verticalSpace,
                                  CustomText(
                                    text: institution,
                                    maxLines: 1,
                                    fontSize: 9.sp,
                                    color: AppColors.grey,
                                  ),
                                ],
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(width: 10.w),
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
                text: amountText,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Provider avatar from API key [profileImage] only.
  String? _profileImagePath(dynamic freelancer) {
    final user = _freelancerUserMap(freelancer);
    final outer = _asStringKeyedMap(freelancer);
    return _stringFrom(user, 'profileImage') ??
        _stringFrom(outer, 'profileImage');
  }

  String _resolveProfileUrl(String? path) {
    final s = path?.trim() ?? '';
    if (s.isEmpty || s.toLowerCase() == 'null') return '';
    if (s.startsWith('http://') || s.startsWith('https://')) return s;
    return '${NetworkStrings.IMAGE_BASE_URL}$s';
  }

  Map<String, dynamic>? _asStringKeyedMap(dynamic v) {
    if (v is Map<String, dynamic>) return v;
    if (v is Map) return Map<String, dynamic>.from(v);
    return null;
  }

  String? _stringFrom(Map<String, dynamic>? m, String key) {
    if (m == null) return null;
    final v = m[key];
    if (v == null) return null;
    final s = v.toString().trim();
    return s.isEmpty ? null : s;
  }

  /// Payload is `{ userDetails, certifications, providerServices }` (see [SingleServiceController]).
  Map<String, dynamic>? _freelancerUserMap(dynamic freelancer) {
    final outer = _asStringKeyedMap(freelancer);
    if (outer == null) return null;
    final nested = outer['userDetails'];
    if (nested != null) return _asStringKeyedMap(nested);
    return outer;
  }

  List<dynamic> _certificationsList(dynamic freelancer) {
    final outer = _asStringKeyedMap(freelancer);
    if (outer == null) return [];
    final c = outer['certifications'];
    if (c is List) return c;
    return [];
  }

  Map<String, dynamic>? _primaryProviderService(dynamic freelancer) {
    final outer = _asStringKeyedMap(freelancer);
    if (outer == null) return null;
    final list = outer['providerServices'];
    if (list is! List || list.isEmpty) return null;
    return _asStringKeyedMap(list.first);
  }

  dynamic _firstProviderHourlyRate(dynamic freelancer) {
    return _primaryProviderService(freelancer)?['hourlyRate'];
  }

  String? _providerUserId(dynamic freelancer) {
    final user = _freelancerUserMap(freelancer);
    final id = user?['id'] ?? _asStringKeyedMap(freelancer)?['id'];
    return id?.toString();
  }
}
