import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:management_dashboard/data/models/classes/custom_user.dart';
import 'package:management_dashboard/data/models/classes/iot_device_template.dart';
import 'package:management_dashboard/helper_functions.dart';
import 'package:management_dashboard/logic/cubits/authentication/authentication_cubit.dart';
import 'package:management_dashboard/logic/cubits/theme/theme_cubit.dart';
import 'package:management_dashboard/presentation/pages/authentication/account_type_selection/account_type_selection_page.dart';
import 'package:management_dashboard/presentation/pages/authentication/auth_actions/auth_actions_page.dart';
import 'package:management_dashboard/presentation/pages/authentication/company_selection/company_selection_page.dart';
import 'package:management_dashboard/presentation/pages/authentication/forgot_password/forgot_password_page.dart';
import 'package:management_dashboard/presentation/pages/authentication/login/login_page.dart';
import 'package:management_dashboard/presentation/pages/authentication/sign_up/sign_up_page.dart';
import 'package:management_dashboard/presentation/pages/authentication/two_step_verification/two_step_verification_page.dart';
import 'package:management_dashboard/presentation/pages/dashboard/control_panel/users_management/add_user_page.dart';
import 'package:management_dashboard/presentation/pages/dashboard/control_panel/users_management/edit_user_page.dart';
import 'package:management_dashboard/presentation/pages/dashboard/control_panel/users_management/users_management_page.dart';
import 'package:management_dashboard/presentation/pages/dashboard/customers/customers_page.dart';
import 'package:management_dashboard/presentation/pages/dashboard/dashboard_page.dart';
import 'package:management_dashboard/presentation/pages/dashboard/iot_platform/devices/add_iot_device_page.dart';
import 'package:management_dashboard/presentation/pages/dashboard/iot_platform/devices/device_details/iot_device_details_page.dart';
import 'package:management_dashboard/presentation/pages/dashboard/iot_platform/devices/edit_iot_device_page.dart';
import 'package:management_dashboard/presentation/pages/dashboard/iot_platform/devices/iot_device_template_page.dart';
import 'package:management_dashboard/presentation/pages/dashboard/iot_platform/devices/iot_devices_page.dart';
import 'package:management_dashboard/presentation/pages/dashboard/iot_platform/devices/iot_platform_landing_page.dart';
import 'package:management_dashboard/presentation/pages/dashboard/overview/overview_page.dart';
import 'package:management_dashboard/presentation/theming/custom_theme.dart';

/// Custom Route Class
class CustomRoute {
  /// Name of the Route - will be shown in the appbar if display name is null
  final String name;

  /// Path of the route shown in URL
  final String route;

  /// Whether to show the path in the appbar
  final bool showInAppbarPath;

  /// The display name of the route (shown in the appbar)
  String? displayName;

  /// Example Route for the route (Used for ids e.g /:deviceID)
  final Map<String, String> pathParams;

  CustomRoute({
    required this.name,
    required this.route,
    this.showInAppbarPath = true,
    this.pathParams = const {},
    this.displayName,
  });
}

/// The routes for the app
class AppRoutes {
  // Don't Forget to add every new Route to Routes List - otherwise it won't be shown in Dashboard path

  /// The route for the login page
  static CustomRoute loginRoute = CustomRoute(
    name: 'Login',
    route: '/login',
  );

  /// The route for the sign up page
  static CustomRoute signUpRoute = CustomRoute(
    name: 'Sign up',
    route: '/sign-up',
  );

  /// The route for the forgot password page
  static CustomRoute forgotPasswordRoute = CustomRoute(
    name: 'Forgot Password',
    route: '/forgot-password',
  );

  /// The route for the setup new password page
  static CustomRoute authActionsRoute = CustomRoute(
    name: 'Auth Actions',
    route: '/auth-actions',
  );

  /// The route for the two step verification page
  static CustomRoute twoStepVerificationRoute = CustomRoute(
    name: 'Two Step Verification',
    route: '/two-step-verification',
  );

  /// The route for the account type selection page
  static CustomRoute accountTypeSelectionRoute = CustomRoute(
    name: 'Account Type Selection',
    route: '/account-type-selection',
  );

  /// The route for the company selection page
  static CustomRoute companySelectionRoute = CustomRoute(
    name: 'Company Selection',
    route: '/company-selection',
  );

  /// The route for dashboard page
  static CustomRoute dashboardRoute = CustomRoute(
    name: 'Dashboard',
    route: '/dashboard',
  );

  /// The route for the dashboard/overview page
  static CustomRoute dashboardOverviewRoute = CustomRoute(
    name: 'Overview',
    route: 'overview',
  );

  /// The route for the dashboard/customers page
  static CustomRoute customersRoute = CustomRoute(
    name: 'Customers',
    route: 'customers',
  );

  /// The route for the dashboard/control-panel page
  static CustomRoute controlPanelRoute = CustomRoute(
    name: 'Control Panel',
    route: 'control-panel',
  );

  /// The route for the dashboard/control-panel/users-management page
  static CustomRoute usersManagementRoute = CustomRoute(
    name: 'Users Management',
    route: 'users-management',
  );

  /// The route for the dashboard/control-panel/users-management/add page
  static CustomRoute addUserRoute = CustomRoute(
    name: 'Add User',
    displayName: 'Add',
    route: 'add',
  );

  /// The route for the dashboard/control-panel/users-management/edit page
  static CustomRoute editUserRoute = CustomRoute(
    name: 'Edit User',
    displayName: 'Edit',
    route: 'edit',
    showInAppbarPath: false,
  );

  /// The route for the dashboard/iot-platform page
  static CustomRoute iotPlatformRoute = CustomRoute(
    name: 'IoT Platform',
    route: 'iot-platform',
  );

  /// The route for the dashboard/iot-platform/iot-devices page
  static CustomRoute iotDevicesRoute = CustomRoute(
    name: 'IoT Devices',
    route: 'iot-devices',
  );

  /// The route for the dashboard/iot-platform/iot-devices/:deviceID page
  static CustomRoute iotDeviceDetailsRoute = CustomRoute(
    name: 'Analytics',
    route: ':deviceID',
    pathParams: {
      'deviceID': 'deviceID',
    },
    showInAppbarPath: false,
  );

  /// The route for the dashboard/iot-platform/iot-devices/:deviceID/edit page
  static CustomRoute editIotDeviceRoute = CustomRoute(
    name: 'Edit IoT Device',
    route: 'edit',
    displayName: 'Edit',
    showInAppbarPath: false,
  );

  /// The route for the dashboard/iot-platform/iot-devices/add page
  static CustomRoute addIotDeviceRoute = CustomRoute(
    name: 'Add IoT Device',
    displayName: 'Add',
    route: 'add',
  );

  /// The route for the dashboard/iot-platform/iot-devices/new-template page
  static CustomRoute newIotTemplateRoute = CustomRoute(
    name: 'New Template',
    route: 'new-template',
  );

  /// The route for the dashboard/iot-platform/iot-devices/edit-template page
  static CustomRoute editIotTemplateRoute = CustomRoute(
    name: 'Edit Template',
    route: 'edit-template',
  );

  /// The route for the temp page
  static CustomRoute tempRoute = CustomRoute(
    name: 'Temp',
    route: '/temp',
  );

  /// The list of all routes
  static List<CustomRoute> routesList = [
    loginRoute,
    signUpRoute,
    forgotPasswordRoute,
    authActionsRoute,
    twoStepVerificationRoute,
    accountTypeSelectionRoute,
    companySelectionRoute,
    dashboardRoute,
    dashboardOverviewRoute,
    iotPlatformRoute,
    iotDevicesRoute,
    iotDeviceDetailsRoute,
    editIotDeviceRoute,
    addIotDeviceRoute,
    newIotTemplateRoute,
    editIotTemplateRoute,
    customersRoute,
    controlPanelRoute,
    usersManagementRoute,
    addUserRoute,
    editUserRoute,
    tempRoute,
  ];

  static GoRouter router = GoRouter(
    initialLocation: FirebaseAuth.instance.currentUser == null
        ? loginRoute.route
        : companySelectionRoute.route,
    redirect: (BuildContext context, GoRouterState state) async {
      AuthenticationCubit authenticationCubit =
          BlocProvider.of<AuthenticationCubit>(context);

      updateThemeBasedOnRoute(context, state.matchedLocation);

      // Display the page without any checks
      if ([
        authActionsRoute.route,
      ].contains(state.matchedLocation)) {
        return null;
      }

      // Display the page only if user isn't signed in
      if ([
        signUpRoute.route,
        forgotPasswordRoute.route,
      ].contains(state.matchedLocation)) {
        if (authenticationCubit.state.user == null) {
          return null;
        }
      }

      // Display the page only if user is signed in and has a company
      if (authenticationCubit.state.user == null) {
        return loginRoute.route;
      }

      return authenticationCubit.state.company == null
          ? companySelectionRoute.route
          : null;
    },
    routes: <RouteBase>[
      GoRoute(
        name: loginRoute.name,
        path: loginRoute.route,
        pageBuilder: (context, state) => customPageBuilder(
          context: context,
          state: state,
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        name: companySelectionRoute.name,
        path: companySelectionRoute.route,
        pageBuilder: (context, state) => customPageBuilder(
          context: context,
          state: state,
          child: const CompanySelectionPage(),
        ),
      ),
      GoRoute(
        name: signUpRoute.name,
        path: signUpRoute.route,
        pageBuilder: (context, state) => customPageBuilder(
          context: context,
          state: state,
          child: const SignUpPage(),
        ),
      ),
      GoRoute(
        name: forgotPasswordRoute.name,
        path: forgotPasswordRoute.route,
        pageBuilder: (context, state) => customPageBuilder(
          context: context,
          state: state,
          child: const ForgotPasswordPage(),
        ),
      ),
      GoRoute(
        name: authActionsRoute.name,
        path: authActionsRoute.route,
        pageBuilder: (context, state) {
          return customPageBuilder(
            context: context,
            state: state,
            child: AuthActionsPage(
              queryParams: state.uri.queryParameters,
            ),
          );
        },
      ),
      GoRoute(
        name: twoStepVerificationRoute.name,
        path: twoStepVerificationRoute.route,
        pageBuilder: (context, state) => customPageBuilder(
          context: context,
          state: state,
          child: const TwoStepVerificationPage(),
        ),
      ),
      GoRoute(
        name: accountTypeSelectionRoute.name,
        path: accountTypeSelectionRoute.route,
        pageBuilder: (context, state) => customPageBuilder(
          context: context,
          state: state,
          child: const AccountTypeSelectionPage(),
        ),
      ),
      ShellRoute(
        pageBuilder: (context, state, child) => customPageBuilder(
          context: context,
          state: state,
          child: DashboardPage(child: child),
        ),
        routes: [
          GoRoute(
            name: dashboardRoute.name,
            path: dashboardRoute.route,
            redirect: (context, state) {
              if (state.fullPath == state.namedLocation(dashboardRoute.name)) {
                return state.namedLocation(dashboardOverviewRoute.name);
              }

              return null;
            },
            routes: [
              GoRoute(
                name: dashboardOverviewRoute.name,
                path: dashboardOverviewRoute.route,
                pageBuilder: (context, state) => customPageBuilder(
                  context: context,
                  state: state,
                  child: const OverviewPage(),
                  showThemeSwitchButton: false,
                ),
              ),
              GoRoute(
                name: iotPlatformRoute.name,
                path: iotPlatformRoute.route,
                pageBuilder: (context, state) => customPageBuilder(
                  context: context,
                  state: state,
                  child: const IoTPlatformLandingPage(),
                  showThemeSwitchButton: false,
                ),
                routes: [
                  GoRoute(
                    name: iotDevicesRoute.name,
                    path: iotDevicesRoute.route,
                    pageBuilder: (context, state) => customPageBuilder(
                      context: context,
                      state: state,
                      child: IoTDevicesPage(
                        initialIndex: (state.extra
                            as Map<String, dynamic>?)?['tab'] as int?,
                      ),
                      showThemeSwitchButton: false,
                    ),
                    routes: [
                      GoRoute(
                        name: addIotDeviceRoute.name,
                        path: addIotDeviceRoute.route,
                        pageBuilder: (context, state) => customPageBuilder(
                          context: context,
                          state: state,
                          child: const AddIoTDevicePage(),
                          showThemeSwitchButton: false,
                        ),
                      ),
                      GoRoute(
                        name: newIotTemplateRoute.name,
                        path: newIotTemplateRoute.route,
                        pageBuilder: (context, state) => customPageBuilder(
                          context: context,
                          state: state,
                          child: const IoTDeviceTemplatePage(),
                          showThemeSwitchButton: false,
                        ),
                      ),
                      GoRoute(
                        name: editIotTemplateRoute.name,
                        path: editIotTemplateRoute.route,
                        pageBuilder: (context, state) => customPageBuilder(
                          context: context,
                          state: state,
                          child: IoTDeviceTemplatePage(
                            template: (state.extra
                                    as Map<String, dynamic>?)?['template']
                                as IoTDeviceTemplate?,
                          ),
                          showThemeSwitchButton: false,
                        ),
                      ),
                      GoRoute(
                        name: iotDeviceDetailsRoute.name,
                        path: iotDeviceDetailsRoute.route,
                        pageBuilder: (context, state) => customPageBuilder(
                          context: context,
                          state: state,
                          child: IoTDeviceDetailsPage(
                            deviceID:
                                state.pathParameters['deviceID'] as String,
                          ),
                          showThemeSwitchButton: false,
                        ),
                        routes: [
                          GoRoute(
                            name: editIotDeviceRoute.name,
                            path: editIotDeviceRoute.route,
                            pageBuilder: (context, state) => customPageBuilder(
                              context: context,
                              state: state,
                              child: EditIoTDevicePage(
                                device: (state.extra
                                    as Map<String, dynamic>?)?['device'],
                              ),
                              showThemeSwitchButton: false,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              GoRoute(
                name: customersRoute.name,
                path: customersRoute.route,
                pageBuilder: (context, state) => customPageBuilder(
                  context: context,
                  state: state,
                  child: const CustomersPage(),
                  showThemeSwitchButton: false,
                ),
              ),
              GoRoute(
                name: controlPanelRoute.name,
                path: controlPanelRoute.route,
                redirect: (context, state) {
                  if (state.fullPath ==
                      state.namedLocation(controlPanelRoute.name)) {
                    return state.namedLocation(usersManagementRoute.name);
                  }

                  return null;
                },
                routes: [
                  GoRoute(
                    name: usersManagementRoute.name,
                    path: usersManagementRoute.route,
                    pageBuilder: (context, state) => customPageBuilder(
                      context: context,
                      state: state,
                      child: const UsersManagementPage(),
                      showThemeSwitchButton: false,
                    ),
                    routes: [
                      GoRoute(
                        name: addUserRoute.name,
                        path: addUserRoute.route,
                        pageBuilder: (context, state) => customPageBuilder(
                          context: context,
                          state: state,
                          child: const AddUserPage(),
                          showThemeSwitchButton: false,
                        ),
                      ),
                      GoRoute(
                        name: editUserRoute.name,
                        path: editUserRoute.route,
                        pageBuilder: (context, state) => customPageBuilder(
                          context: context,
                          state: state,
                          child: EditUserPage(
                            user:
                                (state.extra as Map<String, dynamic>?)?['user']
                                    as CustomUser?,
                          ),
                          showThemeSwitchButton: false,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            name: tempRoute.name,
            path: tempRoute.route,
            pageBuilder: (context, state) => customPageBuilder(
              context: context,
              state: state,
              child: const IoTPlatformLandingPage(),
              showThemeSwitchButton: false,
            ),
          ),
        ],
      ),
    ],
  );

  /// Updates the theme based on the current route
  static void updateThemeBasedOnRoute(
      BuildContext context, String currentRoute) {
    if (currentRoute == loginRoute.route) {
      BlocProvider.of<ThemeCubit>(context).updateThemes(
        lightTheme: CustomTheme.loginScreenLightTheme,
        darkTheme: CustomTheme.loginScreenDarkTheme,
      );
    } else if ([
      signUpRoute.route,
      forgotPasswordRoute.route,
      authActionsRoute.route,
      twoStepVerificationRoute.route,
      accountTypeSelectionRoute.route,
    ].contains(currentRoute)) {
      BlocProvider.of<ThemeCubit>(context).updateThemes(
        lightTheme: CustomTheme.authScreensLightTheme,
        darkTheme: CustomTheme.darkTheme,
      );
    } else {
      BlocProvider.of<ThemeCubit>(context).updateThemes(
        lightTheme: CustomTheme.lightTheme,
        darkTheme: CustomTheme.darkTheme,
      );
    }
  }

  /// Returns the path from the route
  static List<CustomRoute> getRoutesFromLocation(String location) {
    List<CustomRoute> routes = [];

    router.configuration.findMatch(location).matches.forEach((element) {
      if (element.route is GoRoute) {
        try {
          routes.add(
            routesList.firstWhere(
              (route) =>
                  route.showInAppbarPath &&
                  route.name == (element.route as GoRoute).name,
            ),
          );
        } catch (e) {
          HelperFunctions.printDebug(e);
        }
      }
    });

    return routes;
  }

  /// A custom page builder that wraps the page in a [CustomTransitionPage]
  static CustomTransitionPage customPageBuilder<T>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
    bool showThemeSwitchButton = true,
    bool showTransition = true,
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween);

        final childWidget = showThemeSwitchButton && kDebugMode
            ? Scaffold(
                floatingActionButton: BlocBuilder<ThemeCubit, ThemeState>(
                  builder: (context, state) {
                    return FloatingActionButton(
                      onPressed: () {
                        BlocProvider.of<ThemeCubit>(context).switchTheme();
                      },
                      child: Icon(
                        state.themeMode == ThemeMode.dark
                            ? Icons.light_mode
                            : Icons.dark_mode,
                      ),
                    );
                  },
                ),
                body: child,
              )
            : child;

        if (showTransition) {
          return SlideTransition(
            position: offsetAnimation,
            child: childWidget,
          );
        }

        return childWidget;
      },
    );
  }
}
