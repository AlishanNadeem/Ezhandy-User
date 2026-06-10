import 'package:carousel_slider/carousel_slider.dart';
import 'package:ezhandy_user/module/core/products/controller/product_detail_controller.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {

  late final ProductDetailController _controller;
  int _current = 0;

  @override
  void initState() {
    _controller = Get.put(ProductDetailController());
    super.initState();
    final String productId = Get.arguments ?? '';
    print("📦 Product ID received: $productId");
    _controller.getProductDetail(productId: productId);
  }

  @override
  void dispose() {
    if (Get.isRegistered<ProductDetailController>()) {
      Get.delete<ProductDetailController>();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      extendBodyBehindAppBar: true,
      title: AppStrings.productDetails,
      titleColor: AppColors.white,
      leading: AssetPath.backIcon,
      onclickLead: () {
        Get.back();
      },
      child: Obx(() {
        if (_controller.isLoading.value && _controller.product.value == null) {
          return const Column(
            children: [
              Expanded(
                child: Center(child: CircularProgressIndicator()),
              ),
            ],
          );
        }

        final product = _controller.product.value ?? {};

        final imageUrl = product['mainImagePath'] != null
            ? "${product['mainImagePath']}"
            : null;
        final imageList = imageUrl != null ? [imageUrl] : <String>[];

        return Column(
          children: [
            slider_container(imageList),
            detailsContainerWidget(product),
          ],
        );
      }),
    );
  }

  // ── Details Container ──
  Widget detailsContainerWidget(Map<String, dynamic> product) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding14),
          child: Column(
            children: [
              30.verticalSpace,

              // ── Title & Price ──
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomText(
                      text: product['title'] ?? '',
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                      maxLines: 2,
                    ),
                  ),
                  10.horizontalSpace,
                  CustomText(
                    text: "\$ ${product['price'] ?? '0.00'}",
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                    color: AppColors.orange,
                  ),
                ],
              ),
              10.verticalSpace,

              // ── Category ──
              if (product['category'] != null)
                detailsRow(
                  image:  AssetPath.menuIcon,
                  title: product['category']?['name'] ?? '',
                ),
              10.verticalSpace,

              // ── Rating ──
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 18.sp),
                  5.horizontalSpace,
                  CustomText(
                    text: product['avgRating'] != null
                        ? "${product['avgRating']}"
                        : "No ratings yet",
                    color: AppColors.grey,
                  ),
                  10.horizontalSpace,
                  CustomText(
                    text: "(${product['reviewsCount'] ?? 0} reviews)",
                    color: AppColors.grey,
                    fontSize: 12.sp,
                  ),
                ],
              ),
              10.verticalSpace,

              // ── Description ──
              CustomText(
                text: AppStrings.description,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
              10.verticalSpace,
              CustomText(
                text: product['description'] ?? '',
              ),
              20.verticalSpace,

              // ── Seller Details ──
              CustomText(
                text: "Seller Details:",
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
              Divider(),
              detailsRow(
                image: AssetPath.profileCircleIcon,
                title: product['owner']?['fullName'] ?? '',
              ),
              if ((product['owner']?['email']?.toString().trim() ?? '').isNotEmpty)
                detailsRow(
                  image: AssetPath.emailIcon,
                  title: product['owner']?['email']?.toString() ?? '',
                ),
              if ((product['owner']?['phone']?.toString().trim() ?? '')
                  .isNotEmpty)
                detailsRow(
                  image: AssetPath.callIcon,
                  title: product['owner']?['phone']?.toString() ?? '',
                ),
              10.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  // ── Details Row ──
  Padding detailsRow({required String image, required String title}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: 20.w,
            height: 20.h,
            color: AppColors.orange,
          ),
          10.horizontalSpace,
          Expanded(
            child: CustomText(
              text: title,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

  // ── Slider ──
  Widget slider_container(List<String> images) {
    // fallback images if API has no image
    List<String> displayImages = images.isNotEmpty
        ? images
        : [
            "https://via.placeholder.com/400x300?text=No+Image",
          ];

    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            enlargeCenterPage: true,
            viewportFraction: 1,
            height: 0.3.sh,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          items: displayImages.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  decoration: BoxDecoration(
                    color: AppColors.transparent,
                    image: DecorationImage(
                      image: NetworkImage(i),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        Positioned(
          bottom: 10,
          right: 0,
          left: 0,
          child: slider_dots(displayImages),
        ),
      ],
    );
  }

  // ── Slider Dots ──
  Widget slider_dots(List<String> images) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: images.asMap().entries.map((entry) {
        return Container(
          width: 20.0.w,
          height: 5.0.h,
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: _current == entry.key
                  ? AppColors.transparent
                  : AppColors.white,
            ),
            borderRadius: BorderRadius.circular(5.sp),
            color: _current == entry.key ? AppColors.orange : AppColors.white,
          ),
        );
      }).toList(),
    );
  }
}