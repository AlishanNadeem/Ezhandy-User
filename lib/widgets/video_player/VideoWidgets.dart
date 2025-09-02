// import 'dart:developer';

// import 'package:chewie/chewie.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ezhandy_user/utils/app_colors.dart';
// // import 'package:ezhandy_user/utils/app_color.dart';
// // import 'package:ezhandy_user/utils/network_strings.dart';
// import 'package:video_player/video_player.dart';

// class VideoPlayerScreen extends StatefulWidget {
//   String? videoURl, thumbnail;
//   bool? isSoundActive;
//   double? aspectRatio;

//   VideoPlayerScreen(
//       {this.videoURl,
//       this.thumbnail,
//       this.isSoundActive = true,
//       this.aspectRatio,
//       Key? key})
//       : super(key: key);

//   @override
//   State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
// }

// class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
//   late VideoPlayerController videoPlayerController;
//   ChewieController? chewieController;

//   @override
//   void initState() {
//     super.initState();
//     _initPlayer();
//   }

//   void _initPlayer() async {
//     videoPlayerController = VideoPlayerController.networkUrl(
//       // Uri.parse('${NetworkStrings.IMAGE_BASE_URL}${widget.videoURl}'),
//       Uri.parse(
//           'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'),
//     );
//     await videoPlayerController.initialize().catchError((ex) {});
//     if (widget.isSoundActive == false) {
//       videoPlayerController.setVolume(0.0);
//     }
//     setState(() {});
//     chewieController = ChewieController(
//       videoPlayerController: videoPlayerController,
//       allowMuting: widget.isSoundActive!, // Allow user to mute/unmute
//       autoInitialize:
//           true, // Initialize the player immediately      // autoPlay: true,
//       // looping: true,
//     );
//   }

//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     if (chewieController != null) {
//       chewieController!.dispose();
//     }
//     videoPlayerController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return video_container();

//     //  chewieController != null
//     //     ? Padding(
//     //         padding: const EdgeInsets.symmetric(vertical: 0),
//     //         child: AspectRatio(
//     //           aspectRatio: 16 / 9,
//     //           child: Chewie(
//     //             controller: chewieController!,
//     //           ),
//     //         ),
//     //       )
//     //     : const Center(
//     //         child: CircularProgressIndicator(),
//     //       );
//   }

//   Widget video_container() {
//     log((videoPlayerController.value.aspectRatio).toString());
//     return videoPlayerController.value.aspectRatio == null ||
//             videoPlayerController.value.aspectRatio == 1.0
//         ? Stack(
//             alignment: Alignment.center,
//             children: <Widget>[
//               Container(
//                 height: 200.h,
//                 width: 1.sw,
//                 decoration: BoxDecoration(
//                     // borderRadius: BorderRadius.circular(12),
//                     image: DecorationImage(
//                   image: NetworkImage(
//                       // NetworkStrings.IMAGE_BASE_URL + widget.thumbnail!),
//                       "https://media.gettyimages.com/id/1733699966/video/dramatic-slow-motion-shot-of-female-athlete-getting-on-starting-block-to-begin-track-race.avif?s=640x640&k=20&c=KjHgW55dTin_XP9srCFgP-9dysKJK8RzTPUSOrR3gmM="),
//                   fit: BoxFit.cover,
//                 )),
//               ),

//               // Image.network(
//               // width: 1.sw,
//               // height: 200.h,
//               // fit: BoxFit.cover,
//               // NetworkStrings.IMAGE_BASE_URL + widget.thumbnail!),
//               const Center(
//                 child: CircularProgressIndicator(
//                   color: AppColors.green,
//                 ),
//               )
//             ],
//           )
//         : AspectRatio(
//             aspectRatio:
//                 widget.aspectRatio ?? videoPlayerController.value.aspectRatio,
//             // aspectRatio: 16/9,
//             child: Stack(
//               alignment: Alignment.bottomCenter,
//               children: <Widget>[
//                 chewieController != null
//                     ? Padding(
//                         padding: EdgeInsets.zero,
//                         //symmetric(vertical: 10, horizontal: 10),
//                         child: Chewie(
//                           controller: chewieController!,
//                         ),
//                       )
//                     : const Center(
//                         child: CircularProgressIndicator(
//                           color: AppColors.green,
//                         ),
//                       ),
//               ],
//             ),
//           );
//   }
// }
