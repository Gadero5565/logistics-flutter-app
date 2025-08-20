import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:logistics_app/core/theme/app_colours.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String jobTitle;
  final String department;
  final String imageUrl;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.jobTitle,
    required this.department,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.synchronized(
      duration: const Duration(milliseconds: 500),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  _buildBackground(),
                  _buildProfileImage(context),
                ],
              ),
              SizedBox(height: 10.h),
              _buildProfileInfo(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.2),
            AppColors.primaryDark.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30.r),
        ),
      ),
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    return Hero(
      tag: 'profile-avatar',
      child: Container(
        width: 120.w,
        height: 40.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 4.w,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 12,
              spreadRadius: 3,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(60.r),
          child: Image.network(
            imageUrl,
            // fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                      : null,
                  color: AppColors.primary,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[200],
                child: Icon(
                  Iconsax.user,
                  size: 50.w,
                  color: Colors.grey[400],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProfileInfo(BuildContext context) {
    return Column(
      children: [
        Text(
          name,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 36.sp,
          ),
        ),
        SizedBox(height: 8.h),
        AnimatedContainer(
          duration: const Duration(seconds: 1),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: AppColors.secondaryLight,
            borderRadius: BorderRadius.circular(20.r),
          ),
          curve: Curves.fastOutSlowIn,
          child: Text(
            jobTitle,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
              fontSize: 26.sp,
            ),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          department,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
            fontSize: 24.sp,
          ),
        ),
      ],
    );
  }
}