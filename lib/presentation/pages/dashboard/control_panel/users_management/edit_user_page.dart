import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:management_dashboard/constants.dart';
import 'package:management_dashboard/data/models/classes/custom_user.dart';
import 'package:management_dashboard/data/models/enums/account_roles.dart';
import 'package:management_dashboard/logic/cubits/user_management/user_management_cubit.dart';
import 'package:management_dashboard/presentation/pages/dashboard/control_panel/users_management/widgets/image_picker_form_field.dart';
import 'package:management_dashboard/presentation/pages/dashboard/control_panel/users_management/widgets/user_account_preferences_card.dart';
import 'package:management_dashboard/presentation/pages/dashboard/control_panel/users_management/widgets/user_delete_account_card.dart';
import 'package:management_dashboard/presentation/pages/dashboard/control_panel/users_management/widgets/user_profile_details_card.dart';
import 'package:management_dashboard/presentation/pages/dashboard/control_panel/users_management/widgets/user_sign_in_method_card.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/responsive_widgets/dashboard_responsive_horizontal_padding.dart';
import 'package:management_dashboard/presentation/routing/app_routes.dart';
import 'package:management_dashboard/presentation/widgets/buttons/custom_text_button.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_16.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_28.dart';

class EditUserPage extends StatefulWidget {
  /// Add User page inside the Dashboard
  const EditUserPage({
    super.key,
    this.user,
  });

  /// User to edit
  final CustomUser? user;

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  /// A global key for the form
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  /// The account role
  final Rx<AccountRoles> accountRole = AccountRoles.monitor.obs;

  @override
  void initState() {
    super.initState();

    if (widget.user == null) {
      context.goNamed(AppRoutes.usersManagementRoute.name);
    } else {
      accountRole.value = widget.user?.role ?? AccountRoles.monitor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DashboardResponsiveHorizontalPadding(
        child: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap28(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ImagePickerFormField(
                      name: 'image',
                      imageURL: widget.user?.photoURL,
                    ),
                    const SizedBox(width: 10),
                    CustomTextButton(
                      text: 'Save Changes',
                      fontSize: 12,
                      onPressed: () async {
                        if (_formKey.currentState?.saveAndValidate() ?? false) {
                          String? password =
                              _formKey.currentState?.fields['password']?.value;
                          if (password != null && password.length < 8) {
                            _formKey.currentState?.fields['password']?.invalidate(
                                'Password must be at least 8 characters long');
                            return;
                          }

                          await BlocProvider.of<UserManagementCubit>(context)
                              .updateUser(
                            uid: widget.user!.uid,
                            fullName:
                                _formKey.currentState?.fields['name']?.value,
                            email:
                                _formKey.currentState?.fields['email']?.value,
                            password: _formKey
                                .currentState?.fields['password']?.value,
                            role: accountRole.value,
                            image:
                                _formKey.currentState?.fields['image']?.value,
                            phoneNumber:
                                _formKey.currentState?.fields['phone']?.value,
                            imageURL: widget.user?.photoURL,
                          )
                              .then((error) {
                            if (error != null) {
                              K.showToast(message: error);
                            } else {
                              context
                                  .goNamed(AppRoutes.usersManagementRoute.name);
                              K.showToast(
                                message: 'User updated successfully',
                              );
                            }
                          });
                        }
                      },
                    ),
                  ],
                ),
                const Gap16(),
                UserProfileDetailsCard(user: widget.user),
                const Gap16(),
                UserSignInMethodCard(user: widget.user),
                const Gap16(),
                UserAccountPreferencesCard(
                  accountRole: accountRole,
                ),
                const Gap16(),
                UserDeleteAccountCard(
                  user: widget.user,
                ),
                const Gap28(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
