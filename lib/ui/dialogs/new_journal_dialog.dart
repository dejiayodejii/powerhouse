import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:powerhouse/core/models/_models.dart';
import 'package:powerhouse/ui/components/_components.dart';
import 'package:powerhouse/ui/constants/_constants.dart';
import 'package:powerhouse/ui/views/journal/notifiers/journal_notifier.dart';

class NewJournalDialog extends HookConsumerWidget {
  final JournalModel? journal;
  const NewJournalDialog({
    Key? key,
    this.journal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useTextEditingController(text: journal?.title);
    final bodyController = useTextEditingController(text: journal?.body);
    final notifier = ref.watch(journalNotifier.notifier);
    final state = ref.watch(journalNotifier);
    return Dialog(
      clipBehavior: Clip.hardEdge,
      backgroundColor: AppColors.veryLightGrey,
      insetPadding: EdgeInsets.all(20.sp),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Container(
        height: 387.h,
        padding: EdgeInsets.all(30.sp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              maxLines: 1,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
              style: AppTextStyles.heading1.copyWith(
                fontSize: 27.sm,
              ),
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
              decoration: kDecoration.copyWith(
                fillColor: AppColors.transparent,
                hintText: "Title",
                filled: true,
                hintStyle: AppTextStyles.heading1.copyWith(
                  fontSize: 27.sm,
                ),
              ),
            ),
            Expanded(
              child: AppTextField(
                hint: "Journal your Thoughts",
                textCapitalization: TextCapitalization.sentences,
                controller: bodyController,
                fillColor: AppColors.transparent,
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Flexible(
                    child: AppButton(
                      label: "CANCEL",
                      labelColor: AppColors.black,
                      buttonColor: AppColors.white,
                      onTap: notifier.navigateBack,
                    ),
                  ),
                  const XSpacing(10),
                  Flexible(
                    child: AppButton(
                      label: "SAVE",
                      isBusy: state.isBusy,
                      onTap: () {
                        final journal = JournalModel(
                          id: this.journal?.id,
                          title: titleController.text,
                          body: bodyController.text,
                          date: DateTime.now().millisecondsSinceEpoch,
                        );
                        notifier.onSaveJournal(journal);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
