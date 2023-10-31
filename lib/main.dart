import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:management_dashboard/logic/blocs/iot_devices_list/iot_devices_list_bloc.dart';
import 'package:management_dashboard/logic/cubits/authentication/authentication_cubit.dart';
import 'package:management_dashboard/logic/cubits/global_observables/global_observables_cubit.dart';
import 'package:management_dashboard/logic/cubits/iot_device_templates/iot_device_templates_cubit.dart';
import 'package:management_dashboard/logic/cubits/side_bars/side_bars_cubit.dart';
import 'package:management_dashboard/logic/cubits/theme/theme_cubit.dart';
import 'package:management_dashboard/logic/cubits/user_management/user_management_cubit.dart';
import 'package:management_dashboard/presentation/routing/app_routes.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:responsive_ui/responsive_ui.dart';

import 'firebase_options.dart';

void main() async {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorage.webStorageDirectory,
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Responsive.setGlobalBreakPoints(400.0, 768, 960, 1460);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return KeyboardDismisser(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => ThemeCubit()),
              BlocProvider(create: (_) => GlobalObservablesCubit()),
              BlocProvider(create: (_) => AuthenticationCubit()),
              BlocProvider(create: (_) => SideBarsCubit()),
              BlocProvider(create: (_) => IoTDevicesListBloc()),
              BlocProvider(create: (_) => IoTDeviceTemplatesCubit()),
              BlocProvider(create: (_) => UserManagementCubit()),
            ],
            child: BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) => MaterialApp.router(
                builder: FToastBuilder(),
                title: 'LOOFT Management Dashboard',
                routerConfig: AppRoutes.router,
                scrollBehavior:
                    const ScrollBehavior().copyWith(scrollbars: false),
                theme: state.lightTheme,
                darkTheme: state.darkTheme,
                themeMode: state.themeMode,
              ),
            ),
          ),
        );
      },
    );
  }
}
