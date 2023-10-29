import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:powerhouse/ui/constants/_constants.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.chevron_left,
              size: 40.sm,
              color: AppColors.black,
            ),
            Text(
              "Back",
              style: AppTextStyles.semibold22.copyWith(
                fontSize: 27.sm,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
