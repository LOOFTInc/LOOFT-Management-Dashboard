import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:management_dashboard/data/models/classes/custom_user.dart';
import 'package:management_dashboard/data/models/enums/account_roles.dart';
import 'package:management_dashboard/helper_functions.dart';
import 'package:management_dashboard/logic/cubits/user_management/user_management_cubit.dart';
import 'package:management_dashboard/presentation/pages/dashboard/control_panel/users_management/widgets/user_image_widget.dart';
import 'package:management_dashboard/presentation/pages/dashboard/models/table_column.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/colored_text_container.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/tables/custom_table_column.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/tables/custom_table_separator.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/tables/table_header.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/tables/table_list_tile.dart';
import 'package:management_dashboard/presentation/routing/app_routes.dart';
import 'package:management_dashboard/presentation/widgets/custom_svg.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_28.dart';

class UsersTableWidget extends StatefulWidget {
  /// Custom Table Widget
  const UsersTableWidget({
    super.key,
    required this.searchValue,
  });

  /// Value to search in the table
  final String searchValue;

  @override
  State<UsersTableWidget> createState() => _UsersTableWidgetState();
}

class _UsersTableWidgetState extends State<UsersTableWidget> {
  /// Index of the column on which sorting is applied
  int sortingIndex = -4;

  /// Columns to be displayed in the table
  final List<TableColumn> columns = [
    TableColumn(title: 'Name', flex: 4),
    TableColumn(title: 'Email', flex: 5),
    TableColumn(title: 'Role', flex: 3),
    TableColumn(title: 'Registration Date', flex: 4),
  ];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < columns.length; i++) {
      columns[i].onTap = () {
        setState(() {
          sortingIndex = sortingIndex == -(i + 1) ? (i + 1) : -(i + 1);
        });
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableHeader(
          columns: columns,
          onCheckAll: (val) {},
          sortingIndex: sortingIndex,
        ),
        Expanded(
          child: BlocBuilder<UserManagementCubit, UserManagementState>(
            builder: (context, userManagementState) {
              if (userManagementState is UsersListLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (userManagementState is UsersListUpdateFailed) {
                return Center(
                  child: Text(userManagementState.error),
                );
              }

              List<CustomUser> users = List.from(userManagementState.users);

              // Sorts the devices based on the sorting index
              int tempIndex = sortingIndex.abs() - 1;
              if (sortingIndex.isNegative) {
                users.sort((a, b) => HelperFunctions.compare(
                    getValueFromIndex(b, tempIndex),
                    getValueFromIndex(a, tempIndex)));
              } else {
                users.sort((a, b) => HelperFunctions.compare(
                    getValueFromIndex(a, tempIndex),
                    getValueFromIndex(b, tempIndex)));
              }

              // Filters the devices based on the search value
              users = users.where((element) {
                for (int i = 0; i < columns.length; i++) {
                  if (getStringValueFromIndex(element, i)
                      .toLowerCase()
                      .contains(widget.searchValue)) {
                    return true;
                  }
                }

                return false;
              }).toList();

              return ListView.separated(
                itemBuilder: (context, index) {
                  if (index == users.length) {
                    return const Gap28();
                  }

                  final CustomUser currentUser = users[index];

                  return TableListTile(
                    onDoubleTap: () {},
                    onEdit: () {
                      context.goNamed(
                        AppRoutes.editUserRoute.name,
                        extra: {
                          'user': currentUser,
                        },
                      );
                    },
                    content: Row(
                      children: [
                        ...List.generate(columns.length, (subIndex) {
                          if (subIndex == 0) {
                            return Expanded(
                              flex: columns[subIndex].flex,
                              child: CustomTableColumn(
                                text: getStringValueFromIndex(
                                  currentUser,
                                  subIndex,
                                ),
                                leading: Flexible(
                                  child: UserImageWidget(
                                    imageURL: currentUser.photoURL,
                                  ),
                                ),
                              ),
                            );
                          }

                          if (subIndex == 2) {
                            return Expanded(
                              flex: columns[subIndex].flex,
                              child: CustomTableColumn(
                                text: '',
                                child: ColoredTextContainer(
                                  text: getStringValueFromIndex(
                                    currentUser,
                                    subIndex,
                                  ),
                                  textColor: currentUser.role.color,
                                ),
                              ),
                            );
                          }

                          if (subIndex == 3) {
                            return Expanded(
                              flex: columns[subIndex].flex,
                              child: CustomTableColumn(
                                text: getStringValueFromIndex(
                                    currentUser, subIndex),
                                leading: const CustomSvg(
                                  svgPath: 'assets/icons/calender.svg',
                                  size: 16,
                                ),
                              ),
                            );
                          }

                          return Expanded(
                            flex: columns[subIndex].flex,
                            child: CustomTableColumn(
                              text: getStringValueFromIndex(
                                currentUser,
                                subIndex,
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    const CustomTableSeparator(),
                itemCount: users.length + 1,
              );
            },
          ),
        ),
      ],
    );
  }

  /// Returns the String form of value from the index
  String getStringValueFromIndex(CustomUser user, int index) {
    if (index == 2) {
      return user.role.name;
    } else if (index == 3) {
      return HelperFunctions.getFormattedRegistrationDate(
        user.registrationDate,
      );
    }

    return handleNullValue(getValueFromIndex(user, index));
  }

  /// Returns the value from the index
  dynamic getValueFromIndex(CustomUser iotDevice, int index) {
    if (index == 0) {
      return iotDevice.displayName;
    } else if (index == 1) {
      return iotDevice.email;
    } else if (index == 2) {
      return iotDevice.role.name;
    } else if (index == 3) {
      return iotDevice.registrationDate;
    }
  }

  /// Handles null value
  handleNullValue(dynamic value) {
    if (value == null) {
      return '?';
    }
    return value;
  }
}
