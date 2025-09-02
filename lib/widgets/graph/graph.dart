// import 'dart:ffi';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl/intl.dart';
// import 'package:ezhandy_user/utils/app_colors.dart';
// import 'package:ezhandy_user/utils/enums.dart';
// import 'package:ezhandy_user/widgets/Container/custom_container.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class Graph extends StatefulWidget {
//   String graphType;

//   Graph({required this.graphType, super.key});

//   @override
//   State<Graph> createState() => _GraphState();
// }

// class _GraphState extends State<Graph> {
//   List<ChartData> chartData = [
//     ChartData('Week 1', 25000, 95000),
//     ChartData('Week 2', 27000, 93000),
//     ChartData('Week 3', 46000, 94000),
//     ChartData('Week 4', 28000, 92000),
//   ];
//   void setData() {
//     chartData = widget.graphType == GraphType.Weekly.name
//         ? [
//             ChartData('Week 1', 25000, 95000),
//             ChartData('Week 2', 27000, 93000),
//             ChartData('Week 3', 46000, 94000),
//             ChartData('Week 4', 28000, 92000),
//           ]
//         : widget.graphType == GraphType.Monthly.name
//             ? [
//                 ChartData('01', 25000, 95000),
//                 ChartData('02', 25000, 95000),
//                 ChartData('03', 25000, 95000),
//                 ChartData('04', 25000, 95000),
//                 ChartData('05', 25000, 95000),
//                 ChartData('06', 25000, 95000),
//                 ChartData('07', 25000, 95000),
//                 ChartData('08', 25000, 95000),
//                 ChartData('09', 25000, 95000),
//                 ChartData('10', 25000, 95000),
//                 ChartData('11', 25000, 95000),
//                 ChartData('12', 25000, 95000),
//                 ChartData('13', 25000, 95000),
//                 ChartData('14', 25000, 95000),
//                 ChartData('15', 25000, 95000),
//                 ChartData('16', 25000, 95000),
//                 ChartData('17', 25000, 95000),
//                 ChartData('18', 25000, 95000),
//                 ChartData('19', 25000, 95000),
//                 ChartData('20', 25000, 95000),
//                 ChartData('21', 25000, 95000),
//                 ChartData('22', 25000, 95000),
//                 ChartData('23', 25000, 95000),
//                 ChartData('24', 25000, 95000),
//                 ChartData('25', 25000, 95000),
//                 ChartData('26', 25000, 95000),
//                 ChartData('27', 25000, 95000),
//                 ChartData('28', 25000, 95000),
//                 ChartData('29', 25000, 95000),
//                 ChartData('30', 25000, 95000),
//                 ChartData('31', 25000, 95000),
//               ]
//             : [
//                 ChartData('Jan', 25000, 95000),
//                 ChartData('Feb', 25000, 95000),
//                 ChartData('Mar', 25000, 95000),
//                 ChartData('Apr', 25000, 95000),
//                 ChartData('May', 25000, 95000),
//                 ChartData('Jun', 25000, 95000),
//                 ChartData('Jul', 25000, 95000),
//                 ChartData('Aug', 25000, 95000),
//                 ChartData('Sep', 25000, 95000),
//                 ChartData('Oct', 25000, 95000),
//                 ChartData('Nov', 25000, 95000),
//                 ChartData('Dec', 25000, 95000)
//               ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     setData();
//     return CustomContainer(
//       height: 200.h,
//       bgColor: AppColors.background,
//       borderColor: AppColors.backButtonPurple,
//       child: SfCartesianChart(
//         primaryXAxis: CategoryAxis(
//           axisLine: AxisLine(width: 0),
//           majorGridLines: MajorGridLines(width: 0),
//         ),
//         primaryYAxis: NumericAxis(
//           axisLine: AxisLine(width: 0),
//           majorGridLines: MajorGridLines(width: 1, dashArray: [3]),
//           numberFormat: NumberFormat.compactCurrency(symbol: '\$'),
//           minimum: 0,
//           maximum: 120000,
//           interval: 25000,
//         ),
//         series: <CartesianSeries<dynamic, dynamic>>[
//           StackedColumnSeries<ChartData, String>(
//             // Disables animation
//             animationDuration: 0,
//             dataSource: chartData,
//             xValueMapper: (ChartData data, _) => data.week,
//             yValueMapper: (ChartData data, _) => data.lowerValue,
//             color: AppColors.backButtonPurple,
//             borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(5.r),
//                 bottomRight: Radius.circular(5.r)), // Rounded corners
//           ),
//           StackedColumnSeries<ChartData, String>(
//             animationDuration: 0,

//             dataSource: chartData,
//             xValueMapper: (ChartData data, _) => data.week,
//             yValueMapper: (ChartData data, _) => data.upperValue,
//             color: AppColors.graphBarColor,
//             borderRadius: BorderRadius.only(
//                 topRight: Radius.circular(5.r),
//                 topLeft: Radius.circular(5.r)), // Rounded corners
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ChartData {
//   final String week;
//   final double lowerValue;
//   final double upperValue;

//   ChartData(this.week, this.lowerValue, this.upperValue);
// }
