import 'package:flutter/material.dart';
import 'package:payflow_project/shared/models/bill_model.dart';
import 'package:payflow_project/shared/widgets/bill_list/bill_list_controller.dart';
import 'package:payflow_project/shared/widgets/bill_tile/bill_tile_widget.dart';

class BillListWidget extends StatefulWidget {
  const BillListWidget({super.key});

  @override
  State<BillListWidget> createState() => _BillListWidgetState();
}

class _BillListWidgetState extends State<BillListWidget> {
  final controller = BillListController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<BillModel>>(
        valueListenable: controller.boletosNotifier,
        builder: (_, boletos, __) => Column(
            children: boletos
                .map(
                  (e) => BillTileWidget(data: e),
                )
                .toList()));
  }
}