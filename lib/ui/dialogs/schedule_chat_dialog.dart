// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:intl/intl.dart';
// import 'package:powerhouse/ui/components/_components.dart';
// import 'package:powerhouse/ui/constants/_constants.dart';
// import 'package:powerhouse/ui/views/fitness/notifiers/fitness_notifier.dart';

// class ScheduleChatDialog extends HookConsumerWidget {
//   const ScheduleChatDialog({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     DateTime? date;
//     TimeOfDay? time;
//     final dateController = useTextEditingController();
//     final timeController = useTextEditingController();
//     final notifier = ref.watch(fitnessNotifier.notifier);
//     final state = ref.watch(fitnessNotifier);
//     return Dialog(
//       clipBehavior: Clip.hardEdge,
//       backgroundColor: AppColors.pink,
//       insetPadding: EdgeInsets.all(20.sp),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20.r),
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(36.sp),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               "Schedule Chat",
//               style: AppTextStyles.light20.copyWith(fontSize: 23.sm),
//             ),
//             const YSpacing(22),
//             AppTextField(
//               hint: "Pick a Date",
//               readOnly: true,
//               controller: dateController,
//               suffix: const Icon(
//                 Icons.calendar_month_sharp,
//                 color: AppColors.hintColor,
//               ),
//               onTap: () async {
//                 date = await showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime.now(),
//                   lastDate: DateTime(2030),
//                 );
//                 if (date != null) {
//                   dateController.text = DateFormat.yMEd().format(date!);
//                 }
//               },
//             ),
//             const YSpacing(17),
//             AppTextField(
//               hint: "Pick a Time",
//               controller: timeController,
//               readOnly: true,
//               maxLines: 1,
//               suffix: const Icon(
//                 Icons.access_time,
//                 color: AppColors.hintColor,
//               ),
//               onTap: () async {
//                 time = await showTimePicker(
//                   context: context,
//                   initialTime: TimeOfDay.now(),
//                 );
//                 if (time != null) timeController.text = time!.format(context);
//               },
//             ),
//             const YSpacing(28),
//             Row(
//               children: [
//                 Flexible(
//                   child: AppButton(
//                     label: "CANCEL",
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
//                     onTap: () => notifier.scheduleChat(date, time),
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
