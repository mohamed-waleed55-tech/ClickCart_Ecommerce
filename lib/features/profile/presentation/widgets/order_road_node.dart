import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderRoadNode extends StatelessWidget {
  final String title;
  final int index;
  final int currentIndex;

  const OrderRoadNode({
    super.key,
    required this.title,
    required this.index,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    bool isCompleted = index <= currentIndex;
    bool isCurrent = index == currentIndex;

    return Expanded(
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            width: isCurrent ? 28.w : 22.w,
            height: isCurrent ? 28.h : 22.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCompleted ? const Color(0xFF10B981) : Colors.grey.shade200,
              boxShadow: isCurrent
                  ? [
                      BoxShadow(
                        color: const Color(0xFF10B981).withValues(alpha: 0.4),
                        blurRadius: 8,
                        spreadRadius: 2,
                      )
                    ]
                  : [],
            ),
            child: Center(
              child: Icon(
                isCompleted ? Icons.check : Icons.fiber_manual_record,
                size: isCurrent ? 14.sp : 10.sp,
                color: isCompleted ? Colors.white : Colors.grey.shade400,
              ),
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
              color: isCompleted ? Colors.black87 : Colors.grey.shade400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}