import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderRoadLine extends StatelessWidget {
  final int index;
  final int currentIndex;

  const OrderRoadLine({
    super.key,
    required this.index,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    bool isPassed = index < currentIndex;

    return Expanded(
      child: Container(
        height: 3.h,
        margin: EdgeInsets.only(bottom: 20.h), 
        color: isPassed ? const Color(0xFF10B981) : Colors.grey.shade200,
      ),
    );
  }
}