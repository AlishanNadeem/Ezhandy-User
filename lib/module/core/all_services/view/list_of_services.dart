import 'package:ezhandy_user/module/auth/controller/auth_controller.dart';
import 'package:ezhandy_user/module/core/all_services/controller/list_of_services_controller.dart';
import 'package:ezhandy_user/module/core/all_services/routing_arguments/service_routing_arguments.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/widgets/Container/custom_container.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:ezhandy_user/widgets/text_fields/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

class ListOfServices extends StatefulWidget {
  final String? type;
  final bool isQuick;

  const ListOfServices({this.type, required this.isQuick, super.key});

  @override
  State<ListOfServices> createState() => _ListOfServicesState();
}

class _ListOfServicesState extends State<ListOfServices> {
  late final ListOfServicesController _listController;

  @override
  void initState() {
    super.initState();
    if (Get.isRegistered<ListOfServicesController>()) {
      Get.delete<ListOfServicesController>();
    }
    _listController =
        Get.put(ListOfServicesController(isQuick: widget.isQuick));
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
        leading: AssetPath.backIcon,
        onclickLead: () {
          Get.back();
        },
        title: AppStrings.listOfServices,
        appBarheight: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
          child: Column(
            children: [
              searchTextField(),
              10.verticalSpace,
              Expanded(
                child: Obx(() {
                  if (_listController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (_listController.servicesList.isEmpty) {
                    return Center(
                      child: CustomText(
                        text: "No services found",
                        color: AppColors.greyLight,
                      ),
                    );
                  }
                  return ListView.separated(
                    padding: EdgeInsets.only(bottom: AppPadding.padding25),
                    shrinkWrap: true,
                    itemCount: _listController.servicesList.length,
                    itemBuilder: (context, index) {
                      final service = _listController.servicesList[index];
                      return singleContainer(
                        service: service,
                        onTap: () {
                          !AuthController.i.isLoginSignUp.value
                              ? signinSignUpPopup()
                              : AppNavigation.navigateTo(
                                  context, AppRoutes.servicesScreenRoute,
                                  arguments: ServiceRoutingArgument(
                                      serviceName: service['name']?.toString(),
                                      type: widget.type,
                                      serviceId: _parseServiceId(service['id']),
                                    ));
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

  void signinSignUpPopup() {
    AppDialogs.showSuccessDialog(
      context,
      barrierDismissible: true,
      description: AppStrings.inOrderToAccessThis,
      image: AssetPath.tumbIcon,
      isDoneShow: false,
      btnTxt1: AppStrings.logIn.toUpperCase(),
      onTap1: () {
        AppNavigation.navigateToRemovingAll(
            context, AppRoutes.loginScreenRoute);
      },
      btnTxt2: AppStrings.signUp.toUpperCase(),
      onTap2: () {
        AppNavigation.navigateToRemovingAll(
            context, AppRoutes.loginScreenRoute);
        AppNavigation.navigateTo(context, AppRoutes.signupScreenRoute);
      },
    );
  }

  Widget singleContainer({required dynamic service, required VoidCallback onTap}) {
    final backgroundUrl = _resolveMediaUrl(service['imagePath']);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: .3.sh,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: backgroundUrl.isNotEmpty
                    ? NetworkImage(backgroundUrl)
                    : AssetImage(AssetPath.tempCleaningImage) as ImageProvider)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [10.verticalSpace, detailsContainer(service)],
        ),
      ),
    );
  }

  Widget detailsContainer(dynamic service) {
    final iconUrl = _resolveMediaUrl(service['iconImagePath']);
    return Padding(
      padding: EdgeInsets.all(AppPadding.padding12),
      child: CustomContainer(
          child: Row(
        children: [
          CircleAvatar(
            radius: 30.r,
            backgroundColor: AppColors.greyLight.withValues(alpha: 0.3),
            backgroundImage:
                iconUrl.isNotEmpty ? NetworkImage(iconUrl) : null,
            child: iconUrl.isEmpty
                ? Icon(Icons.category_outlined, size: 28.sp)
                : null,
          ),
          10.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: service['name']?.toString() ?? ''),
                5.verticalSpace,
                CustomText(
                  text: service['description']?.toString() ?? '',
                  maxLines: 3,
                )
              ],
            ),
          ),
        ],
      )),
    );
  }

  Widget searchTextField() {
    return CustomTextField(
      label: false,
      prefxicon: AssetPath.searchIcon,
      hint: AppStrings.searchAnything,
      inputFormatters: [LengthLimitingTextInputFormatter(35)],
    );
  }

  String _resolveMediaUrl(dynamic path) {
    final s = path?.toString() ?? '';
    if (s.isEmpty) return '';
    if (s.startsWith('http://') || s.startsWith('https://')) {
      return s;
    }
    return '${NetworkStrings.IMAGE_BASE_URL}$s';
  }

  int? _parseServiceId(dynamic id) {
    if (id == null) return null;
    if (id is int) return id;
    if (id is num) return id.toInt();
    return int.tryParse(id.toString());
  }
}
