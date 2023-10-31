import 'package:flutter/material.dart';
import 'package:management_dashboard/presentation/pages/dashboard/customers/widgets/customers_status_row_widget.dart';

import '../widgets/customer_table_widget.dart';

class CustomersListTab extends StatelessWidget {
  /// Tab View showing Customers List
  const CustomersListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CustomersStatusRowWidget(),
        SizedBox(height: 10),
        Expanded(child: CustomersTableWidget()),
      ],
    );
  }
}
