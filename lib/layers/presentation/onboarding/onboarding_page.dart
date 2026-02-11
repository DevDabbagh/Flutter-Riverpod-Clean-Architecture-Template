import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../app/config/app_colors.dart';
import '../../../../app/config/assets.dart';
import '../../domain/onboarding/entities/onboarding.dart';
import 'onboarding_provider.dart';

class OnboardingPage extends ConsumerWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Watch Data
    final onboardingState = ref.watch(onboardingControllerProvider);
    
    // 2. Watch UI State (Index)
    final currentIndex = ref.watch(onboardingIndexProvider);
    
    // PageController (Local UI controller is fine, but we sync changes to Riverpod)
    // NOTE: In a pure stateless widget, creating PageController here means it resets on rebuild.
    // However, since we want to control it via riverpod for persistence or testing, we might need a StatefulConsumerWidget
    // OR just instantiate it. 
    // Actually, to avoid "ScrollController not attached" issues when rebuilding, using flutter_hooks is best,
    // but without hooks, best to keep StatefulWidget for the PageController itself, OR 
    // re-create it with initialPage: currentIndex is acceptable IF we don't animate externally often.
    // Let's use StatefulConsumerWidget to hold the PageController properly.
    return const _OnboardingPageBody();
  }
}

class _OnboardingPageBody extends ConsumerStatefulWidget {
  const _OnboardingPageBody();

  @override
  ConsumerState<_OnboardingPageBody> createState() => _OnboardingPageBodyState();
}

class _OnboardingPageBodyState extends ConsumerState<_OnboardingPageBody> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    // Initialize with current index from Riverpod
    final initialIndex = ref.read(onboardingIndexProvider);
    _pageController = PageController(initialPage: initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final onboardingState = ref.watch(onboardingControllerProvider);
    final currentIndex = ref.watch(onboardingIndexProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: onboardingState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text("Error: $err")),
          data: (items) {
             final isLastPage = currentIndex == items.length - 1;

             return Column(
              children: [
                // Top Bar with Language
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.translate, size: 16),
                            SizedBox(width: 4.w),
                            Text(
                              "العربية",
                              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Page View
                SizedBox(
                  height: 400.h,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: items.length,
                    onPageChanged: (index) {
                      // Update Riverpod State
                      ref.read(onboardingIndexProvider.notifier).setIndex(index);
                    },
                    itemBuilder: (context, index) {
                      return _buildPage(context, items[index]);
                    },
                  ),
                ),

                const Spacer(),

                // Dots Indicator
                SmoothPageIndicator(
                  controller: _pageController,
                  count: items.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: AppColors.primaryTeal,
                    dotColor: Colors.grey.shade300,
                    dotHeight: 8.h,
                    dotWidth: 8.w,
                    expansionFactor: 3,
                  ),
                  onDotClicked: (index) => _pageController.animateToPage(
                    index, 
                    duration: const Duration(milliseconds: 300), 
                    curve: Curves.easeInOut
                  ),
                ),

                SizedBox(height: 32.h),

                // Action Button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56.h,
                    child: ElevatedButton(
                      onPressed: () {
                        if (isLastPage) {
                          // Navigate to Auth or Home
                           context.go('/posts'); 
                        } else {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryTeal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child: Text(
                        isLastPage ? "Get Started" : "Next",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildPage(BuildContext context, Onboarding item) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Circle Background for Icon
          Container(
            width: 120.w,
            height: 120.w,
            decoration: BoxDecoration(
              color: AppColors.primaryTeal.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              item.icon,
              size: 50.sp,
              color: AppColors.primaryTeal,
            ),
          ),
          SizedBox(height: 40.h),
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: AppColors.textPrimary,
              height: 1.2,
              fontSize: 22.sp,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            item.description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
