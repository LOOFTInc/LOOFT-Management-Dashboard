import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:management_dashboard/constants.dart';
import 'package:management_dashboard/data/models/enums/opacity_colors.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';

class ImagePickerFormField extends StatefulWidget {
  /// Image Picker Form Field
  const ImagePickerFormField({
    super.key,
    required this.name,
    this.imageURL,
    this.validator,
  });

  /// Name of the form field
  final String name;

  /// Image URL
  final String? imageURL;

  /// Validator
  final String? Function(PlatformFile?)? validator;

  @override
  State<ImagePickerFormField> createState() => _ImagePickerFormFieldState();
}

class _ImagePickerFormFieldState extends State<ImagePickerFormField> {
  /// Is hovering over the image
  final RxBool isHovering = false.obs;

  /// Selected image
  final Rxn<PlatformFile?> selectedImage = Rxn<PlatformFile>(null);

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: widget.name,
      validator: widget.validator,
      builder: (FormFieldState<PlatformFile> field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MouseRegion(
              onEnter: (_) => isHovering.value = true,
              onExit: (_) => isHovering.value = false,
              child: ClipOval(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Obx(() {
                        if (selectedImage.value != null) {
                          return Image.memory(
                            selectedImage.value!.bytes!,
                            fit: BoxFit.cover,
                          );
                        }

                        return widget.imageURL == null
                            ? Image.asset('assets/images/user_large.png')
                            : Image.network(
                                widget.imageURL!,
                                fit: BoxFit.cover,
                              );
                      }),
                      Obx(
                        () => isHovering.value
                            ? Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: K.black40,
                                  ),
                                  child: Center(
                                    child: IconButton(
                                      onPressed: () async {
                                        final FilePickerResult? result =
                                            await FilePicker.platform.pickFiles(
                                          type: FileType.custom,
                                          allowedExtensions: <String>[
                                            'jpg',
                                            'jpeg',
                                            'png'
                                          ],
                                        );

                                        if (result != null) {
                                          field.didChange(result.files.single);
                                          selectedImage.value =
                                              result.files.single;
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const CustomText(
              'Allowed file types: png, jpg, jpeg.',
              opacity: OpacityColors.op40,
            ),
          ],
        );
      },
    );
  }
}
