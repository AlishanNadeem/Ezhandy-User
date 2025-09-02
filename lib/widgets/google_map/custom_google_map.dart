// import 'package:elpistoken/module/core/controller/map_controller.dart';
// import 'package:elpistoken/utils/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class CustomGoogleMap extends StatefulWidget {
//   bool withRadius;
//   CustomGoogleMap({super.key, this.withRadius = false});

//   @override
//   State<CustomGoogleMap> createState() => _CustomGoogleMapState();
// }

// class _CustomGoogleMapState extends State<CustomGoogleMap> {
//   @override
//   void initState() {
//     // MapController.i.getcurrentlocation();
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   void dispose() {
//     // MapController.i.mapController?.dispose();
//     // TODO: implement dispose
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<MapController>(builder: (_) {
//       return Stack(
//         children: [
//           widget.withRadius ? radiusOfMapWidget() : googleMapWidget(),
//           Positioned(
//             top: 20.h,
//             right: 10.w,
//             child: FloatingActionButton(
//               onPressed: () async {
//                 MapController.i.mapController?.animateCamera(
//                   CameraUpdate.newCameraPosition(
//                     CameraPosition(
//                       target: LatLng(
//                           MapController.i.currentlocation?.latitude ??
//                               33.2158587,
//                           MapController.i.currentlocation?.longitude ??
//                               -96.7357166),
//                       zoom: 14,
//                     ),
//                   ),
//                 );
//               },
//               backgroundColor: AppColors.green,
//               child: Icon(
//                 Icons.my_location,
//                 color: AppColors.white,
//               ), // Replace with your desired icon
//             ),
//           ),
//         ],
//       );
//     });
//   }

//   ClipRRect radiusOfMapWidget() {
//     return ClipRRect(
//       // clipBehavior: Clip.antiAlias,
//       borderRadius: BorderRadius.circular(35.sp),

//       child: googleMapWidget(),
//     );
//   }

//   GoogleMap googleMapWidget() {
//     return GoogleMap(
//       zoomControlsEnabled: false,
//       // myLocationEnabled: true,
//       myLocationButtonEnabled: false,
//       initialCameraPosition: CameraPosition(
//         target: LatLng(MapController.i.currentlocation?.latitude ?? 33.2158587,
//             MapController.i.currentlocation?.longitude ?? -96.7357166),
//         zoom: 14,
//       ),
//       onMapCreated: (GoogleMapController controller) {
//         print("Map created");
//         MapController.i.mapController = controller;
//         // Future.delayed(Duration(seconds: 3), () {
//         //   MapController.i.mapController?.animateCamera(
//         //     CameraUpdate.newCameraPosition(
//         //       CameraPosition(
//         //         target: LatLng(
//         //             MapController.i.currentlocation?.latitude ?? 33.2158587,
//         //             MapController.i.currentlocation?.longitude ?? -96.7357166),
//         //         zoom: 14,
//         //       ),
//         //     ),
//         //   );
//         // });
//         // MapController.i.setMapStyle(context);

//         // mapController.calculatePolyline();
//       },
//       markers:
//           //    {  Marker(
//           //   markerId: const MarkerId('LiveLocation'),
//           //   position:
//           //       LatLng(MapController.i.currentlocation!.latitude!, MapController.i.currentlocation!.longitude!),
//           //   // icon: await MapController.i.currentlocation!._getMarkerIcon(AssetPaths.ICON_CAR),
//           //   infoWindow: const InfoWindow(title: 'Employee'),
//           // ),}

//           MapController.i.markers,
//       circles: MapController.i.circles,
//       // polylines: MapController.i.polyline,
//       //  onCameraMove: (CameraPosition position) {
//       // MapController.i.currentlocation?.latitude= position.target.latitude;
//       // MapController.i.currentlocation?.longitude??0 = position.target.longitude;
//       // MapController.i.currentlocation?.longitude ?? 0
//       // },
//     );
//   }
// }
