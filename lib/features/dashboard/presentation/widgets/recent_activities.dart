import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colours.dart';

class RecentActivityItem extends StatelessWidget {
  final String title;
  final String time;
  final Color statusColor;

  const RecentActivityItem({
    Key? key,
    required this.title,
    required this.time,
    required this.statusColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          // Status indicator
          Container(
            width: 12.w,
            height: 12.w,
            decoration: BoxDecoration(
              color: statusColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 16.w),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: AppColors.textLight,
                  ),
                ),
              ],
            ),
          ),
          // Arrow icon
          Icon(
            Icons.arrow_forward_ios,
            size: 16.w,
            color: AppColors.textLight,
          ),
        ],
      ),
    );
  }
}