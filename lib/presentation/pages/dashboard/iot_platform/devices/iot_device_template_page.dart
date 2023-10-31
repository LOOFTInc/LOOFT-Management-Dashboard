import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:management_dashboard/constants.dart';
import 'package:management_dashboard/data/models/classes/iot_device_template.dart';
import 'package:management_dashboard/data/models/enums/device_template_device_types.dart';
import 'package:management_dashboard/logic/cubits/iot_device_templates/iot_device_templates_cubit.dart';
import 'package:management_dashboard/presentation/pages/dashboard/iot_platform/devices/widgets/iot_device_template_capabilities_card.dart';
import 'package:management_dashboard/presentation/pages/dashboard/iot_platform/devices/widgets/iot_device_template_name_card.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/responsive_widgets/dashboard_responsive_horizontal_padding.dart';
import 'package:management_dashboard/presentation/routing/app_routes.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_16.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_28.dart';

class IoTDeviceTemplatePage extends StatefulWidget {
  /// Page for the IoT Device Template
  const IoTDeviceTemplatePage({
    super.key,
    this.template,
  });

  /// The template to edit
  final IoTDeviceTemplate? template;

  @override
  State<IoTDeviceTemplatePage> createState() => _IoTDeviceTemplatePageState();
}

class _IoTDeviceTemplatePageState extends State<IoTDeviceTemplatePage> {
  IoTDeviceTemplate currentTemplate = IoTDeviceTemplate(
    templateID: '',
    templateName: '',
    deviceType: DeviceTemplateDeviceTypes.iotDevice,
    metrics: [],
  );

  final _formKey = GlobalKey<FormBuilderState>();
  final List<GlobalKey<FormBuilderState>> formKeys = [];

  @override
  void initState() {
    super.initState();

    if (widget.template != null) {
      currentTemplate = widget.template!.clone();
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
                IoTDeviceTemplateNameCard(
                  template: currentTemplate,
                  onSaveChangesPressed: () async {
                    if (_formKey.currentState!.saveAndValidate()) {
                      for (final formKey in formKeys) {
                        if (!(formKey.currentState?.saveAndValidate() ??
                            false)) {
                          return;
                        }
                      }

                      if (currentTemplate.templateID == '') {
                        await BlocProvider.of<IoTDeviceTemplatesCubit>(context)
                            .addIoTDeviceTemplate(currentTemplate)
                            .then(backOrError);
                      } else {
                        await BlocProvider.of<IoTDeviceTemplatesCubit>(context)
                            .updateIoTDeviceTemplate(currentTemplate)
                            .then(backOrError);
                      }
                    }
                  },
                ),
                const Gap16(),
                IoTDeviceTemplateCapabilitiesCard(
                  template: currentTemplate,
                  formKeys: formKeys,
                ),
                const Gap28(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// This method is used to go back or show an error message
  void backOrError(String? error) {
    if (error == null) {
      K.showToast(message: 'Changes Saved');
      context.goNamed(AppRoutes.iotDevicesRoute.name, extra: {
        'tab': 2,
      });
    } else {
      K.showToast(message: error);
    }
  }
}
