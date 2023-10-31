import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_dashboard/data/models/classes/customer.dart';
import 'package:management_dashboard/helper_functions.dart';
import 'package:management_dashboard/logic/cubits/theme/theme_cubit.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/tables/custom_table_column.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/tables/table_header.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/tables/table_list_tile.dart';
import 'package:management_dashboard/presentation/widgets/custom_svg.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_28.dart';

import '../../models/table_column.dart';
import '../../widgets/tables/custom_table_separator.dart';

class CustomersTableWidget extends StatefulWidget {
  /// Custom Table Widget
  const CustomersTableWidget({super.key});

  @override
  State<CustomersTableWidget> createState() => _CustomersTableWidgetState();
}

class _CustomersTableWidgetState extends State<CustomersTableWidget> {
  final List<TableColumn> columns = [
    TableColumn(title: 'User', flex: 2),
    TableColumn(title: 'UID', flex: 2),
    TableColumn(title: 'Email', flex: 3),
    TableColumn(title: 'Registration Date', flex: 2),
  ];

  final List<Customer> data = List.generate(
    20,
    (index) => Customer(
      'Kate Morrison',
      'A6HDJG89',
      'kate.morgan@gmail.com',
      DateTime.now().subtract(Duration(hours: index * 20)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableHeader(
          columns: columns,
          onCheckAll: (val) {},
        ),
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) {
              if (index == data.length) {
                return const Gap28();
              }

              return BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, state) {
                  return TableListTile(
                    onDoubleTap: () {},
                    content: Row(
                      children: [
                        ...List.generate(columns.length, (subIndex) {
                          if (subIndex == 0) {
                            return Expanded(
                              flex: columns[subIndex].flex,
                              child: CustomTableColumn(
                                text: getCustomerValueFromIndex(
                                    data[index], subIndex),
                                leading: Image.asset(
                                  'assets/images/kate.png',
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            );
                          }

                          if (subIndex == 3) {
                            return Expanded(
                              flex: columns[subIndex].flex,
                              child: CustomTableColumn(
                                text: getCustomerValueFromIndex(
                                    data[index], subIndex),
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
                              text: getCustomerValueFromIndex(
                                  data[index], subIndex),
                            ),
                          );
                        }),
                      ],
                    ),
                  );
                },
              );
            },
            separatorBuilder: (context, index) => const CustomTableSeparator(),
            itemCount: data.length + 1,
          ),
        ),
      ],
    );
  }

  getCustomerValueFromIndex(Customer customer, int index) {
    if (index == 0) {
      return customer.name;
    } else if (index == 1) {
      return customer.uid;
    } else if (index == 2) {
      return customer.email;
    } else if (index == 3) {
      return HelperFunctions.getFormattedRegistrationDate(
          customer.registrationDate);
    }
  }
}
