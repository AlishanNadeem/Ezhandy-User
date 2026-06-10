import 'package:ezhandy_user/module/core/all_services/routing_arguments/service_routing_arguments.dart';
import 'package:ezhandy_user/module/core/profile/controller/provider_profile_controller.dart';
import 'package:ezhandy_user/module/core/rating_review_report/routing_arguments/review_routing_arguments.dart';
import 'package:ezhandy_user/widgets/Container/custom_container.dart';
import 'package:ezhandy_user/widgets/profile_widget/user_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ezhandy_user/utils/api_enums.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

class ProviderProfile extends StatefulWidget {
  final String? type;
  final int? serviceId;
  final String? providerId;

  const ProviderProfile(
      {this.type, this.serviceId, this.providerId, super.key});

  @override
  State<ProviderProfile> createState() => _ProviderProfileState();
}

class _ProviderProfileState extends State<ProviderProfile> {
  static const _tagPrefix = 'provider_profile_';

  String get _controllerTag => '$_tagPrefix${widget.providerId ?? 'none'}';

  /// Lazy registration avoids [LateInitializationError] (e.g. after hot reload).
  ProviderProfileController get _controller {
    if (Get.isRegistered<ProviderProfileController>(tag: _controllerTag)) {
      return Get.find<ProviderProfileController>(tag: _controllerTag);
    }
    return Get.put(
      ProviderProfileController(providerId: widget.providerId),
      tag: _controllerTag,
    );
  }

  @override
  void dispose() {
    if (Get.isRegistered<ProviderProfileController>(tag: _controllerTag)) {
      Get.delete<ProviderProfileController>(tag: _controllerTag);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      leading: AssetPath.backIcon,
      onclickLead: () => Get.back(),
      title: AppStrings.providerProfile,
      appBarheight: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
        child: Obx(() {
          if (_controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (widget.providerId == null || widget.providerId!.trim().isEmpty) {
            return Center(
              child: CustomText(
                text: "Missing provider. Go back and select a freelancer.",
                color: AppColors.greyLight,
                is_alignLeft: false,
              ),
            );
          }
          if (_controller.profileData.value == null) {
            return Center(
              child: CustomText(
                text: "Unable to load profile",
                color: AppColors.greyLight,
                is_alignLeft: false,
              ),
            );
          }

          final user = _controller.userDetails;
          final services = _controller.providerServices;
          final certs = _controller.certifications;
          final isFav = _controller.isProviderFavorite.value;
          final favBusy = _controller.isFavoriteToggling.value;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                profileRowWidget(
                  user,
                  isFavorite: isFav,
                  onHeartTap: favBusy ? null : _controller.toggleProviderFavorite,
                ),
                15.verticalSpace,
                CustomText(
                  text: AppStrings.aboutUs,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                ),
                CustomText(text: _aboutUsDisplay(user)),
                15.verticalSpace,
                Row(
                  children: [
                    keyValueWidget(
                      key: AppStrings.experience,
                      value: _experienceDisplay(user),
                    ),
                    10.horizontalSpace,
                    keyValueWidget(
                      key: AppStrings.language,
                      value: _languageDisplay(user),
                    ),
                    10.horizontalSpace,
                    keyValueWidget(
                      key: AppStrings.gender,
                      value: _genderDisplay(user?['gender']),
                    ),
                  ],
                ),
                15.verticalSpace,
                CustomText(
                  text: AppStrings.certificateDetails,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                ),
                10.verticalSpace,
                _certificationsSection(certs),
                10.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: AppStrings.services,
                        onclick: () {},
                      ),
                    ),
                    10.horizontalSpace,
                    Expanded(
                      child: CustomButton(
                        text: AppStrings.reviews,
                        borderColor: AppColors.orange,
                        color: AppColors.white,
                        textcolor: AppColors.black,
                        onclick: () {
                          AppNavigation.navigateTo(
                            context,
                            AppRoutes.ratingScreenRoute,
                            arguments: ReviewRoutingArgument(
                              providerId: widget.providerId,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                10.verticalSpace,
                ...services
                    .map(_asServiceMap)
                    .where(_matchesRouteServiceType)
                    .map((service) {
                  return Column(
                    children: [
                      _providerServiceCard(
                        height: 200.h,
                        service: service,
                        onOpenDetails: () => _openServiceDetails(service),
                      ),
                      10.verticalSpace,
                    ],
                  );
                }),
                ..._buildAdditionalServicesSection(services),
                25.verticalSpace,
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _certificationsSection(List<dynamic> certs) {
    if (certs.isEmpty) {
      return CustomText(
        text: "No certifications listed.",
        color: AppColors.grey,
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final c in certs)
          if (c is Map)
            _certificationCard(_asServiceMap(c))
          else
            CustomText(text: c.toString()),
      ],
    );
  }

  Widget _certificationCard(Map<String, dynamic> m) {
    final certImageUrl = _resolveMediaUrl(_certificationImagePath(m));

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.r),
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: AppColors.greyLight.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: AppColors.greyLight.withValues(alpha: 0.7),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${AppStrings.insituteName}:',
            style: TextStyle(
              fontSize: 11.sp,
              color: AppColors.orange,
              fontWeight: FontWeight.w600,
            ),
          ),
          4.verticalSpace,
          Text(
            _displayOrDash(_certificationInstitution(m)),
            style: TextStyle(
              fontSize: 13.sp,
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          12.verticalSpace,
          Text(
            '${AppStrings.certificateTitle}:',
            style: TextStyle(
              fontSize: 11.sp,
              color: AppColors.orange,
              fontWeight: FontWeight.w600,
            ),
          ),
          4.verticalSpace,
          Text(
            _displayOrDash(_certificationTitleFromCert(m)),
            style: TextStyle(
              fontSize: 13.sp,
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (certImageUrl.isNotEmpty) ...[
            12.verticalSpace,
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: Image.network(
                  certImageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: AppColors.greyLight.withValues(alpha: 0.3),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.broken_image_outlined,
                      size: 40.sp,
                      color: AppColors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// API: `certificatePath` (relative) or full URL.
  String _certificationImagePath(Map<String, dynamic> m) {
    for (final key in [
      'certificatePath',
      'certificate_path',
      'certImagePath',
      'imageUrl',
      'imagePath',
    ]) {
      final v = m[key];
      if (v == null) continue;
      final s = v.toString().trim();
      if (s.isNotEmpty) return s;
    }
    return '';
  }

  String _certificationInstitution(Map<String, dynamic> c) {
    for (final key in [
      'institutionName',
      'instituteName',
      'institution_name',
      'institute',
    ]) {
      final v = c[key];
      if (v == null) continue;
      final s = v.toString().trim();
      if (s.isNotEmpty) return s;
    }
    return '';
  }

  String _certificationTitleFromCert(Map<String, dynamic> c) {
    for (final key in [
      'certificationTitle',
      'certificateTitle',
      'title',
      'name',
    ]) {
      final v = c[key];
      if (v == null) continue;
      final s = v.toString().trim();
      if (s.isNotEmpty) return s;
    }
    return '';
  }

  Map<String, dynamic> _asServiceMap(dynamic e) {
    if (e is Map<String, dynamic>) return e;
    if (e is Map) return Map<String, dynamic>.from(e);
    return {};
  }

  bool _matchesRouteServiceType(Map<String, dynamic> service) {
    final sid = widget.serviceId;
    if (sid == null) return true;
    final typeId = _resolveServiceTypeId(service);
    return typeId != null && typeId == sid;
  }

  bool _doesNotMatchRouteServiceType(Map<String, dynamic> service) {
    final sid = widget.serviceId;
    if (sid == null) return false;
    return !_matchesRouteServiceType(service);
  }

  List<Widget> _buildAdditionalServicesSection(List<dynamic> services) {
    final additional = services
        .map(_asServiceMap)
        .where(_doesNotMatchRouteServiceType)
        .toList();
    if (additional.isEmpty) return [];

    return [
      10.verticalSpace,
      CustomText(
        text: AppStrings.additionalServices,
        fontWeight: FontWeight.w700,
        fontSize: 16.sp,
      ),
      10.verticalSpace,
      ...additional.map((service) {
        return Column(
          children: [
            _providerServiceCard(
              height: 200.h,
              service: service,
              onOpenDetails: () => _openServiceDetails(service),
            ),
            10.verticalSpace,
          ],
        );
      }),
    ];
  }

  static int? _resolveServiceTypeId(Map<String, dynamic> m) {
    for (final key in ['serviceTypeId', 'service_type_id', 'ServiceTypeId']) {
      final v = m[key];
      if (v is int) return v;
      if (v is num) return v.toInt();
      final parsed = int.tryParse(v?.toString() ?? '');
      if (parsed != null) return parsed;
    }
    final st = m['serviceType'] ?? m['ServiceType'];
    if (st is Map) {
      final sm = st is Map<String, dynamic> ? st : Map<String, dynamic>.from(st);
      for (final key in ['id', 'Id', 'serviceTypeId']) {
        final v = sm[key];
        if (v is int) return v;
        if (v is num) return v.toInt();
        final parsed = int.tryParse(v?.toString() ?? '');
        if (parsed != null) return parsed;
      }
    }
    return null;
  }

  void _openServiceDetails(Map<String, dynamic> service) {
    final psId =
        ProviderProfileController.favoriteApiIdForProviderService(service);
    AppNavigation.navigateTo(
      context,
      AppRoutes.serviceDetailsScreenRoute,
      arguments: ServiceRoutingArgument(
        type: widget.type,
        serviceId: widget.serviceId,
        providerId: widget.providerId,
        providerServiceId: psId,
      ),
    );
  }

  Widget _providerServiceCard({
    required double height,
    required Map<String, dynamic> service,
    required VoidCallback onOpenDetails,
  }) {
    return Obx(() {
      final sid =
          ProviderProfileController.favoriteApiIdForProviderService(service);
      if (sid == null) {
        return singleContainer(
          height: height,
          service: service,
          isFav: false,
          showFavoriteToggle: false,
          ontapLike: () {},
          onTap: onOpenDetails,
        );
      }
      final fav = _controller.serviceFavoriteById[sid] ?? false;
      final busy = _controller.serviceFavoriteTogglingId.value == sid;
      return singleContainer(
        height: height,
        service: service,
        isFav: fav,
        showFavoriteToggle: true,
        ontapLike:
            busy ? () {} : () => _controller.toggleServiceFavorite(sid),
        onTap: onOpenDetails,
      );
    });
  }

  String _aboutUsDisplay(Map<String, dynamic>? user) {
    final s = user?['aboutUs']?.toString().trim() ?? '';
    if (s.isEmpty) return "No details provided.";
    return s;
  }

  String _displayOrDash(dynamic v) {
    final s = v?.toString().trim() ?? '';
    return s.isEmpty ? '—' : s;
  }

  String _experienceDisplay(Map<String, dynamic>? user) {
    return _displayOrDash(user?['experience']);
  }

  String _languageDisplay(Map<String, dynamic>? user) {
    if (user == null) return '—';
    final raw = user['language'] ?? user['languageId'];
    final s = raw?.toString().trim() ?? '';
    if (s.isEmpty) return '—';
    for (final option in languageOptions) {
      if (option.value == s) return option.label;
    }
    return _displayOrDash(raw);
  }

  String _genderDisplay(dynamic gender) {
    final code = gender?.toString().trim().toUpperCase() ?? '';
    switch (code) {
      case 'M':
        return AppStrings.male;
      case 'F':
        return AppStrings.female;
      case 'O':
        return AppStrings.other;
      default:
        final parsed = Gender.fromValue(gender?.toString());
        if (parsed != null) {
          final label = parsed.value;
          return '${label[0].toUpperCase()}${label.substring(1)}';
        }
        return _displayOrDash(gender);
    }
  }

  Widget singleContainer({
    required VoidCallback onTap,
    required Map<String, dynamic> service,
    required bool isFav,
    required VoidCallback ontapLike,
    required double height,
    bool showFavoriteToggle = true,
  }) {
    final imageUrl = _resolveMediaUrl(_serviceTypeImagePath(service));
    final amount = service['hourlyRate'] ?? service['visitCharges'] ?? '0';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: 0.95.sw,
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: imageUrl.isNotEmpty
                ? NetworkImage(imageUrl)
                : AssetImage(AssetPath.tempCleaningImage) as ImageProvider,
          ),
        ),
        child: Column(
          children: [
            10.verticalSpace,
            Row(
              children: [
                if (showFavoriteToggle)
                  GestureDetector(
                    onTap: ontapLike,
                    child: Icon(
                      isFav
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      size: 30.sp,
                    ),
                  )
                else
                  Icon(Icons.favorite_border_rounded, size: 30.sp),
                const Spacer(),
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
            const Spacer(),
            detailsContainer(service),
          ],
        ),
      ),
    );
  }

  Widget detailsContainer(Map<String, dynamic> service) {
    final iconUrl = _resolveMediaUrl(_serviceTypeIconPath(service));
    return Padding(
      padding: EdgeInsets.all(AppPadding.padding12),
      child: CustomContainer(
        child: Row(
          children: [
            if (iconUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  iconUrl,
                  width: 30.w,
                  height: 30.h,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Image.asset(
                    AssetPath.cleaningIcon,
                    width: 30.w,
                    height: 30.h,
                  ),
                ),
              )
            else
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
                  CustomText(
                    text: service['title']?.toString() ?? '',
                    fontWeight: FontWeight.w500,
                  ),
                  5.verticalSpace,
                  CustomText(
                    text: service['description']?.toString() ?? '',
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget keyValueWidget({required String value, required String key}) {
    return Expanded(
      child: CustomContainer(
        borderColor: AppColors.orange,
        child: Column(
          children: [
            CustomText(
              text: value,
              is_alignLeft: false,
              color: AppColors.orange,
            ),
            CustomText(
              text: key,
              is_alignLeft: false,
            ),
          ],
        ),
      ),
    );
  }

  Row profileRowWidget(
    Map<String, dynamic>? user, {
    required bool isFavorite,
    VoidCallback? onHeartTap,
  }) {
    final name = user?['fullName']?.toString() ?? AppStrings.dummyName;
    final mob = user?['mobileNumber']?.toString().trim() ?? '';
    final em = user?['email']?.toString().trim() ?? '';
    final subtitle = mob.isNotEmpty
        ? mob
        : (em.isNotEmpty ? em : AppStrings.activeNow);
    final imageUrl = _resolveMediaUrl(user?['profileImage']);

    final heart = Container(
      margin: EdgeInsets.only(left: AppPadding.padding12),
      padding: EdgeInsets.all(7.sp),
      decoration: const BoxDecoration(
        color: AppColors.orange,
        shape: BoxShape.circle,
      ),
      child: Image.asset(
        isFavorite ? AssetPath.heartFillIcon : AssetPath.heartIcon,
        color: AppColors.white,
        width: 18.w,
        height: 18.h,
      ),
    );

    return Row(
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
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
              CustomText(
                text: subtitle,
                color: AppColors.orange,
                maxLines: 1,
              ),
            ],
          ),
        ),
        if (onHeartTap != null)
          GestureDetector(onTap: onHeartTap, behavior: HitTestBehavior.opaque, child: heart)
        else
          heart,
      ],
    );
  }

  static String _firstNonEmptyPath(Map<String, dynamic> m, List<String> keys) {
    for (final key in keys) {
      final v = m[key];
      if (v == null) continue;
      final s = v.toString().trim();
      if (s.isNotEmpty && s.toLowerCase() != 'null') return s;
    }
    return '';
  }

  String _serviceTypeImagePath(Map<String, dynamic> service) {
    final direct = _firstNonEmptyPath(service, [
      'serviceTypeImageUrl',
      'serviceTypeImage',
      'imageUrl',
      'imagePath',
      'mainImagePath',
    ]);
    if (direct.isNotEmpty) return direct;

    final st = service['serviceType'] ?? service['ServiceType'];
    if (st is Map) {
      final sm = st is Map<String, dynamic> ? st : Map<String, dynamic>.from(st);
      return _firstNonEmptyPath(sm, [
        'imageUrl',
        'image',
        'iconUrl',
        'icon',
      ]);
    }
    return '';
  }

  String _serviceTypeIconPath(Map<String, dynamic> service) {
    final direct = _firstNonEmptyPath(service, [
      'serviceTypeIconUrl',
      'serviceTypeIcon',
      'iconUrl',
      'imageUrl',
    ]);
    if (direct.isNotEmpty) return direct;

    final st = service['serviceType'] ?? service['ServiceType'];
    if (st is Map) {
      final sm = st is Map<String, dynamic> ? st : Map<String, dynamic>.from(st);
      return _firstNonEmptyPath(sm, [
        'iconUrl',
        'icon',
        'imageUrl',
        'image',
      ]);
    }
    return '';
  }

  String _resolveMediaUrl(dynamic path) {
    final s = path?.toString().trim() ?? '';
    if (s.isEmpty || s.toLowerCase() == 'null') return '';
    if (s.startsWith('http://') || s.startsWith('https://')) return s;
    return '${NetworkStrings.IMAGE_BASE_URL}$s';
  }
}
