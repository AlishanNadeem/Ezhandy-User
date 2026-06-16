import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ProviderLocationMap extends StatelessWidget {
  const ProviderLocationMap({
    super.key,
    this.latitude,
    this.longitude,
    this.height,
  });

  final String? latitude;
  final String? longitude;
  final double? height;

  static double? _parseCoordinate(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    return double.tryParse(value.trim());
  }

  LatLng? get _position {
    final lat = _parseCoordinate(latitude);
    final lng = _parseCoordinate(longitude);
    if (lat == null || lng == null) return null;
    return LatLng(lat, lng);
  }

  @override
  Widget build(BuildContext context) {
    final position = _position;
    final mapHeight = height ?? 200.h;

    if (position == null) {
      return SizedBox(
        height: mapHeight,
        width: double.infinity,
        child: Center(
          child: CustomText(
            text: 'Provider location not available',
            color: AppColors.grey,
          ),
        ),
      );
    }

    return SizedBox(
      height: mapHeight,
      width: double.infinity,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: position,
          zoom: 14,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('provider_location'),
            position: position,
          ),
        },
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        mapToolbarEnabled: false,
      ),
    );
  }
}
