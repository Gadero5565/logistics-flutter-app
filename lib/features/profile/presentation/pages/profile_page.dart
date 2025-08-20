import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:logistics_app/features/profile/domain/entities/employee_profile_entity.dart';
import 'package:logistics_app/features/profile/presentation/bloc/employee_profile_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../core/storage/app_storage.dart';
import '../../../../core/theme/app_colours.dart';
import '../../../../core/widgets/snack_bar.dart';
import '../../../../injection.dart' as di;
import '../widgets/profile_header.dart';
import '../widgets/profile_info_item.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildAppBar(),
          BlocProvider(
            create:
                (context) =>
                    di.sl<EmployeeProfileBloc>()..add(
                      FetchEmployeeProfile(
                        userId: AppStorage().getUserId() ?? 0,
                      ),
                    ),
            child: BlocConsumer<EmployeeProfileBloc, EmployeeProfileState>(
              builder: (context, state) {
                if (state is LoadingEmployeeProfileState) {
                  return SliverToBoxAdapter(child: _buildShimmerLoader());
                } else if (state is LoadedEmployeeProfileState) {
                  return _ProfileView(employeeProfile: state.profile);
                } else {
                  return SliverToBoxAdapter(child: _buildShimmerLoader());
                }
              },
              listener: (context, state) {
                if (state is ErrorEmployeeProfileState) {
                  SnackBarMessage().showSnackBar(
                    message: state.message,
                    backgroundColor: AppColors.error,
                    context: context,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 80.h,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'Employee Profile',
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.background,
          ),
        ),
        background: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary.withOpacity(0.8),
                AppColors.primaryDark,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerLoader() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 500),
            childAnimationBuilder:
                (widget) => SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(child: widget),
                ),
            children: [
              Center(
                child: Container(
                  width: 120.w,
                  height: 120.h,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              ...List.generate(
                8,
                (index) => Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40.w,
                        height: 40.h,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 100.w,
                              height: 18.h,
                              color: Colors.white,
                            ),
                            SizedBox(height: 8.h),
                            Container(
                              width: double.infinity,
                              height: 16.h,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileView extends StatelessWidget {
  final EmployeeProfile employeeProfile;

  const _ProfileView({super.key, required this.employeeProfile});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: AnimationLimiter(child: _ProfileContent(profile: employeeProfile)),
    );
  }
}

class _ProfileContent extends StatelessWidget {
  final EmployeeProfile profile;

  const _ProfileContent({required this.profile});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: AnimationConfiguration.synchronized(
        duration: const Duration(milliseconds: 500),
        child: FadeInAnimation(
          child: SlideAnimation(
            verticalOffset: 50.0,
            child: Column(
              children: [
                ProfileHeader(
                  name: profile.name,
                  jobTitle: profile.jobTitle,
                  department: profile.department,
                  imageUrl: profile.imageUrl,
                ),
                SizedBox(height: 24.h),
                _buildProfileCard(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: AnimationLimiter(
          child: Column(
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 100),
              childAnimationBuilder:
                  (widget) => SlideAnimation(
                    horizontalOffset: 50.0,
                    child: FadeInAnimation(child: widget),
                  ),
              children: [
                _buildInfoSection(
                  context: context,
                  icon: Iconsax.briefcase,
                  title: "Work Information",
                  children: [
                    ProfileInfoItem(
                      icon: Iconsax.call,
                      label: 'Work Phone',
                      value: profile.workPhone,
                    ),
                    ProfileInfoItem(
                      icon: Iconsax.sms,
                      label: 'Email',
                      value: profile.workEmail,
                    ),
                    ProfileInfoItem(
                      icon: Iconsax.user,
                      label: 'Manager',
                      value: profile.manager,
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                _buildInfoSection(
                  icon: Iconsax.profile_2user,
                  context: context,
                  title: "Personal Information",
                  children: [
                    ProfileInfoItem(
                      icon: Iconsax.cake,
                      label: 'Birthday',
                      value: profile.birthday,
                    ),
                    ProfileInfoItem(
                      icon: Iconsax.user,
                      label: 'Gender',
                      value: profile.gender,
                    ),
                    ProfileInfoItem(
                      icon: Iconsax.flag,
                      label: 'Country',
                      value: profile.country,
                    ),
                    ProfileInfoItem(
                      icon: Iconsax.profile_2user,
                      label: 'Marital Status',
                      value: profile.marital,
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                _buildInfoSection(
                  icon: Iconsax.document,
                  context: context,
                  title: "Documents",
                  children: [
                    ProfileInfoItem(
                      icon: Iconsax.card,
                      label: 'ID Number',
                      value: profile.identificationId,
                    ),
                    ProfileInfoItem(
                      icon: Iconsax.paperclip,
                      label: 'Passport',
                      value: profile.passportId,
                    ),
                    ProfileInfoItem(
                      icon: Iconsax.document,
                      label: 'Visa No',
                      value: profile.visaNo,
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                _buildInfoSection(
                  context: context,
                  icon: Iconsax.book,
                  title: "Education",
                  children: [
                    ProfileInfoItem(
                      icon: Iconsax.book_1,
                      label: 'Education',
                      value: profile.certificate,
                    ),
                    ProfileInfoItem(
                      icon: Iconsax.book_saved,
                      label: 'Field of Study',
                      value: profile.studyField,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection({
    required IconData icon,
    required String title,
    required List<Widget> children,
    required BuildContext context,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(8.w),
              child: Icon(icon, size: 36.w, color: AppColors.primary),
            ),
            SizedBox(width: 12.w),
            Text(
              title,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.titleLarge?.color,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        ...children,
      ],
    );
  }
}
