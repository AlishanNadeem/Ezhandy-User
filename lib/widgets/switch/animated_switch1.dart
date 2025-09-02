// import 'package:flutter/material.dart';
// import 'package:ezhandy_user/utils/app_colors.dart';

// typedef ToggleFunction = Function(bool v);

// // ignore: must_be_immutable
// class AnimatedSwitch extends StatefulWidget {
//   int isEnabled;
//   void Function()? onToggle;
//   AnimatedSwitch({
//     Key? key,
//     required this.onToggle,
//     required this.isEnabled,
//   }) : super(key: key);
//   @override
//   _AnimatedSwitchState createState() => _AnimatedSwitchState();
// }

// class _AnimatedSwitchState extends State<AnimatedSwitch> {
//   final animationDuration = Duration(milliseconds: 300);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap:

//           //  widget.   isEnabled = ! widget. isEnabled;
//           // if (isEnabled) {
//           widget.onToggle,
//       // .call( widget. isEnabled);
//       // }

//       child: AnimatedContainer(
//         height: 30,
//         width: 50,
//         duration: animationDuration,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(30),
//           color: widget.isEnabled == 1 ? AppColors.buttonColor : AppColors.pink,
//           border: Border.all(color: Colors.white, width: 2),
//           // boxShadow: [
//           //   BoxShadow(
//           //     color: Colors.grey.shade400,
//           //     spreadRadius: 2,
//           //     blurRadius: 10,
//           //   ),
//           // ],
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(3.0),
//           child: AnimatedAlign(
//             duration: animationDuration,
//             alignment: widget.isEnabled == 1 ? Alignment.centerRight : Alignment.centerLeft,
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 2),
//               child: Container(
//                 width: 20,
//                 height: 20,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: widget.isEnabled == 1 ? AppColors.white : AppColors.buttonColor,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
