import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:powerhouse/core/mixins/_mixins.dart';
import 'package:powerhouse/core/models/user_model.dart';
import 'package:powerhouse/ui/components/_components.dart';
import 'package:powerhouse/ui/constants/_constants.dart';
import 'package:powerhouse/ui/views/home/notifiers/profile_notifier.dart';
import 'package:powerhouse/ui/views/home/notifiers/settings_notifier.dart';

import '../../../bottom_sheets/sign_up_sheet.dart';

class EditProfileView extends HookConsumerWidget
    with ValidatorMixin, DialogAndSheetMixin {
  const EditProfileView({Key? key}) : super(key: key);

  String? getDate(DateTime? date) {
    if (date == null) return null;
    return DateFormat("MMMM d, yyyy").format(date);
  }

  String parsePhone(String? phone) {
    if (phone == null) return "";
    // final _phone = PhoneNumber(phoneNumber: phone);
    // print(FlutterLibphonenumber().formatNumberSync(phone));
    return phone.replaceAll("+234", "");
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(profileNotifier.notifier);
    final notifier2 = ref.watch(settingsNotifier.notifier);
    final state = ref.watch(profileNotifier);

    final first = useTextEditingController(text: state.data!.user.firstName);
    final last = useTextEditingController(text: state.data!.user.lastName);
    final email = useTextEditingController(text: state.data!.user.email);
    final phone = useTextEditingController(
        text: parsePhone(state.data!.user.phoneNumber));
    final dob =
        useTextEditingController(text: getDate(state.data?.user.dateOfBirth));
    return Scaffold(
      body: Form(
        key: notifier.formKey,
        child: ListView(
          physics: const ClampingScrollPhysics(),
          padding: REdgeInsets.all(30),
          children: [
            const YSpacing(40),
            const AppBackButton(),
            const YSpacing(40),
            const Divider(color: AppColors.lightGrey),
            const YSpacing(40),
            BorderTextField(
              label: "First Name",
              controller: first,
              textCapitalization: TextCapitalization.words,
              validator: validateNotEmpty,
              keyboardType: TextInputType.name,
              textAlign: TextAlign.start,
            ),
            const YSpacing(14),
            BorderTextField(
              label: "Last Name",
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.name,
              validator: validateNotEmpty,
              textAlign: TextAlign.start,
              controller: last,
            ),
            const YSpacing(14),
            BorderTextField(
              label: "Email",
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.emailAddress,
              validator: validateNotEmpty,
              readOnly: true,
              enabled: false,
              textAlign: TextAlign.start,
              controller: email,
            ),
            const YSpacing(14),
            InternationalPhoneNumberInput(
              onInputChanged: (val) {
                notifier.phone = val.phoneNumber!;
              },
              textFieldController: phone,
              countries: const ["NG"],
              formatInput: true,
              selectorConfig: SelectorConfig(
                setSelectorButtonAsPrefixIcon: true,
                leadingPadding: 20.w,
                showFlags: false,
              ),
              inputDecoration: kBorderDecoration.copyWith(
                labelText: "Phone Number",
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 25.w, vertical: 18.h),
                filled: true,
                fillColor: AppColors.white,
              ),
            ),
            const YSpacing(14),
            BorderTextField(
              label: "Date Of Birth",
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.name,
              readOnly: true,
              textAlign: TextAlign.start,
              controller: dob,
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: state.data!.user.dateOfBirth ?? DateTime.now(),
                  firstDate: DateTime(1800),
                  lastDate: DateTime.now(),
                );
                if (date == null) return;
                dob.text = getDate(date) ?? "";
                notifier.onDatePicked(date);
              },
            ),
            const YSpacing(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 135.w,
                  height: 51.h,
                  child: AppButton(
                    label: "UPDATE",
                    isBusy: state.isBusy,
                    width: 135,
                    onTap: () {
                      final user = UserModel(
                        firstName: first.text,
                        lastName: last.text,
                        email: email.text,
                        id: state.data!.user.id,
                        phoneNumber: notifier.phone,
                        dateOfBirth: state.data!.user.dateOfBirth,
                      );
                      notifier.updateUser(user);
                    },
                  ),
                ),
                SizedBox(
                  width: 150.w,
                  height: 51.h,
                  child: AppButton(
                    hasBorder: true,
                    buttonColor: Colors.white,
                    labelColor: AppColors.darkGrey,
                    borderColor: AppColors.darkGrey,
                    loaderColor: AppColors.darkGrey,
                    label: "DELETE PROFILE",
                    width: 135,
                    onTap: () {
                      notifier2.showSignUpSheet();
                      
                    },
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
