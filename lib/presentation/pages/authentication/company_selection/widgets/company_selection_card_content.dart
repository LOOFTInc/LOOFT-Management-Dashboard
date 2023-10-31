import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:management_dashboard/logic/cubits/authentication/authentication_cubit.dart';
import 'package:management_dashboard/logic/cubits/company_selection/company_selection_cubit.dart';
import 'package:management_dashboard/logic/cubits/theme/theme_cubit.dart';
import 'package:management_dashboard/presentation/pages/authentication/company_selection/widgets/company_widget.dart';
import 'package:management_dashboard/presentation/routing/app_routes.dart';
import 'package:management_dashboard/presentation/widgets/buttons/custom_text_button.dart';
import 'package:management_dashboard/presentation/widgets/custom_svg.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_16.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_28.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text_span.dart';
import 'package:responsive_ui/responsive_ui.dart';

import '../../../../../constants.dart';
import '../../../../../data/models/enums/opacity_colors.dart';
import '../../../../widgets/text_widgets/custom_text.dart';

class CompanySelectionCardContent extends StatefulWidget {
  /// Content of the card in [CompanySelectionPage]
  const CompanySelectionCardContent({super.key});

  @override
  State<CompanySelectionCardContent> createState() =>
      _CompanySelectionCardContentState();
}

class _CompanySelectionCardContentState
    extends State<CompanySelectionCardContent> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<AuthenticationCubit>(context).loadCustomClaims();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, authState) {
        if (authState.customClaims?['role'] != 'super_admin' &&
            authState.company != null) {
          context.goNamed(AppRoutes.dashboardOverviewRoute.name);
        }
      },
      builder: (context, authState) {
        if (authState.customClaims?['role'] != 'super_admin' &&
            authState.customClaims?['company'] == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomText(
                  'Please ask your admin to give you permission to access the dashboard.\nIf they have already done so, kindly sign in again!',
                  textAlign: TextAlign.center,
                ),
                const Gap16(),
                CustomTextButton(
                  text: 'Log Out',
                  fontSize: 14,
                  onPressed: () async {
                    await BlocProvider.of<AuthenticationCubit>(context)
                        .signOut()
                        .then((value) {
                      context.goNamed(AppRoutes.loginRoute.name);
                    });
                  },
                ),
              ],
            ),
          );
        }

        if (authState.customClaims?['role'] != 'super_admin') {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return BlocProvider(
          create: (context) => CompanySelectionCubit(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomText(
                'Select Company',
                style: K.headingStyleAuth,
              ),
              const SizedBox(height: 8),
              CustomRichText(
                textSpanList: [
                  const TextSpan(
                      text: 'If you need more info, please check out '),
                  TextSpan(
                    text: 'Help Page',
                    recognizer: TapGestureRecognizer()..onTap = () {},
                    style: const TextStyle(color: K.primaryBlue),
                  ),
                  const TextSpan(text: '.'),
                ],
                opacity: OpacityColors.op40,
              ),
              const Gap28(),
              BlocBuilder<AuthenticationCubit, AuthenticationState>(
                builder: (context, authState) {
                  return BlocBuilder<CompanySelectionCubit,
                      CompanySelectionState>(
                    builder: (context, companyState) {
                      if (companyState is CompaniesLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (companyState is CompaniesErrorState) {
                        return Center(
                          child: CustomText(
                            companyState.message,
                            textAlign: TextAlign.center,
                          ),
                        );
                      }

                      return Responsive(
                        runSpacing:
                            MediaQuery.of(context).size.width < K.mobileSize
                                ? K.gap28Mobile
                                : K.gap28Desktop,
                        children: companyState.companies
                            .map(
                              (e) => CompanyWidget(
                                isSelected:
                                    authState.company == e.name ? true : false,
                                imagePath: e.imageURL,
                                name: e.name,
                                onPressed: () {
                                  BlocProvider.of<AuthenticationCubit>(context)
                                      .updateCompany(e.name);
                                },
                              ),
                            )
                            .toList(),
                      );
                    },
                  );
                },
              ),
              const Gap28(),
              BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, state) {
                  return CustomTextButton(
                    text: '',
                    onPressed: () {
                      if (authState.company == null) {
                        K.showToast(message: 'Please select a Company');
                        return;
                      }

                      context.goNamed(AppRoutes.dashboardOverviewRoute.name);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 8),
                        CustomText(
                          'Continue',
                          selectable: false,
                          style: TextStyle(
                            color: state.reverseOpacity100,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const CustomSvg(
                          svgPath: 'assets/icons/chevron_right.svg',
                          opacity: OpacityColors.rop100,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
