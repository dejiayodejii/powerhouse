// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:powerhouse/ui/components/_components.dart';
// import 'package:powerhouse/ui/constants/_constants.dart';

// import '../views/fitness/notifiers/fitness_notifier.dart';

// class LiveChatDialog extends HookConsumerWidget {
//   const LiveChatDialog({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final notifier = ref.watch(fitnessNotifier.notifier);
//     final state = ref.watch(fitnessNotifier);
//     final textController = useTextEditingController();
//     return Dialog(
//       clipBehavior: Clip.hardEdge,
//       backgroundColor: AppColors.pink,
//       insetPadding: EdgeInsets.all(20.sp),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20.r),
//       ),
//       child: Container(
//         height: 368.h,
//         padding: EdgeInsets.all(36.sp),
//         child: Column(
//           children: [
//             Text(
//               "Start Live Chat",
//               style: AppTextStyles.light20.copyWith(fontSize: 23.sm),
//             ),
//             const YSpacing(20),
//             Expanded(
//               child: AppTextField(
//                 hint: "Type Something",
//                 controller: textController,
//                 expands: true,
//                 textCapitalization: TextCapitalization.sentences,
//                 textAlign: TextAlign.start,
//                 textAlignVertical: TextAlignVertical.top,
//               ),
//             ),
//             const YSpacing(20),
//             Row(
//               children: [
//                 Flexible(
//                   child: AppButton(
//                     label: "Cancel",
//                     labelColor: AppColors.black,
//                     buttonColor: AppColors.white,
//                     onTap: notifier.navigateBack,
//                   ),
//                 ),
//                 const XSpacing(10),
//                 Flexible(
//                   child: AppButton(
//                     label: "Submit",
//                     isBusy: state.isBusy,
//                     onTap: () => notifier.startLiveChat(textController.text),
//                   ),
//                 ),
//               ],
//             ),
//             const YSpacing(10),
//           ],
//         ),
//       ),
//     );
//   }
// }
