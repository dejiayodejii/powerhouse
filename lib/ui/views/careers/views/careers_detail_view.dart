import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:powerhouse/core/models/_models.dart';
import 'package:powerhouse/ui/components/_components.dart';
import 'package:powerhouse/ui/constants/_constants.dart';
import 'package:powerhouse/ui/views/careers/notifiers/careers_notifier.dart';

class CareerDetailView extends StatefulHookConsumerWidget {
  final CareerModel career;
  const CareerDetailView({
    Key? key,
    required this.career,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CareerDetailViewState();
}

class _CareerDetailViewState extends ConsumerState<CareerDetailView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(careersNotifier.notifier);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.fromLTRB(20.sp, 15.r, 20.sp, 0),
          child: Column(
            children: [
              const AppBackButton(),
              const YSpacing(20),
              Container(
                height: 120.h,
                // padding: EdgeInsets.only(left: 7.w),
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 20.h),
                decoration: BoxDecoration(
                  color: AppColors.darkGrey,
                  borderRadius: BorderRadius.circular(15.sp),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.career.name,
                          style: AppTextStyles.kTextStyle(
                            20,
                            height: 21.09,
                            color: AppColors.white,
                            weight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "-" * 2000,
                      style: AppTextStyles.kTextStyle(
                        15,
                        height: 17.58,
                        weight: FontWeight.w500,
                        color: AppColors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                    ),
                    const YSpacing(3),
                    Text(
                      "${widget.career.count} Videos",
                      style: AppTextStyles.kTextStyle(
                        15,
                        height: 17.58,
                        weight: FontWeight.w500,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const YSpacing(15),
              Expanded(
                child: FutureBuilder<List<MediaModel>>(
                  future: notifier.fetchCareerLibrary(widget.career),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: AppLoader(
                          color: AppColors.darkGrey,
                        ),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "Something went wrong, try again",
                          style: AppTextStyles.kTextStyle(
                            15,
                            height: 17.58,
                            weight: FontWeight.w500,
                            color: AppColors.black,
                          ),
                        ),
                      );
                    }
                    final library = snapshot.data;
                    if (library!.isEmpty) {
                      return Center(
                        child: Text(
                          "Error fetching library",
                          style: AppTextStyles.kTextStyle(
                            15,
                            height: 17.58,
                            weight: FontWeight.w500,
                            color: AppColors.black,
                          ),
                        ),
                      );
                    }

                    return ListView.separated(
                      itemCount: widget.career.count,
                      padding: EdgeInsets.only(bottom: 20.h, top: 30.h),
                      shrinkWrap: true,
                      // itemExtent: 170.h,
                      separatorBuilder: (context, index) => const YSpacing(10),
                      // controller: notifier.scrollController,
                      itemBuilder: (context, index) {
                        final data = library[index];
                        return MediaWidget(
                          body: data.title,
                          title: data.author.toUpperCase(),
                          image: data.coverImage,
                          showIndicator: false,
                          onTap: () {},
                          // => notifier.onMediaClick(data),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
