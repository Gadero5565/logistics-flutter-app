import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colours.dart';

class RequestListItem extends StatelessWidget {
  final String id;
  final String name;
  final String type;
  final String category;
  final String status;
  final Color statusColor;
  final String date;
  final String priority;
  final VoidCallback onTap;

  const RequestListItem({
    Key? key,
    required this.id,
    required this.name,
    required this.type,
    required this.category,
    required this.status,
    required this.statusColor,
    required this.date,
    required this.priority,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r), // Use .r for radius
      child: Container(
        padding: EdgeInsets.symmetric( // Responsive padding
          horizontal: 18.w,
          vertical: 12.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10.w, // Scale shadow
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ID and status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  id,
                  style: TextStyle( // Responsive text
                    fontWeight: FontWeight.bold,
                    fontSize: 36.sp, // Use .sp
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  name,
                  style: TextStyle( // Responsive text
                    fontWeight: FontWeight.bold,
                    fontSize: 36.sp, // Use .sp
                    color: AppColors.primary,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 46.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 18.w, // Use .w for width
                        height: 18.w, // Keep circular aspect (same value)
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 6.w), // Horizontal spacing
                      Text(
                        status,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 26.sp, // Use .sp
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h), // Vertical spacing

            // Type and category
            Row(
              children: [
                Icon(
                  Icons.description_outlined,
                  color: AppColors.textSecondary,
                  size: 36.w, // Icon size responsive
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Request Type',
                        style: TextStyle(
                          fontSize: 26.sp, // Use .sp
                          color: AppColors.textLight,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        type,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                // Divider
                Container(
                  height: 30.h, // Vertical dimension
                  width: 1.w,   // Horizontal dimension
                  color: Colors.grey[300],
                ),
                SizedBox(width: 16.w),
                // Category section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Category',
                      style: TextStyle(
                        fontSize: 26.sp, // Use .sp
                        color: AppColors.textLight,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      category,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 4.h),

            // Date and priority
            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  color: AppColors.textSecondary,
                  size: 36.w, // Icon size responsive
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date',
                      style: TextStyle(
                        fontSize: 26.sp, // Use .sp
                        color: AppColors.textLight,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      date,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 298.w),
                Icon(
                  Icons.flag_outlined,
                  color: priority == 'High' || priority == 'Very High'
                      ? AppColors.error
                      : AppColors.textSecondary,
                  size: 36.w, // Icon size responsive
                ),
                SizedBox(width: 8.w),
                Text(
                  priority,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: priority == 'High' || priority == 'Very High'
                        ? AppColors.error
                        : AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}