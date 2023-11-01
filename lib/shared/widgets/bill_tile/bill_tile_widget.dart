import 'package:flutter/material.dart';
import 'package:payflow_project/shared/models/bill_model.dart';
import 'package:payflow_project/shared/themes/app_text_styles.dart';

class BillTileWidget extends StatelessWidget {
  final BillModel data;
  const BillTileWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          data.name!,
          style: TextStyles.titleListTile,
        ),
        subtitle: Text(
          "Vence em ${data.dueDate}",
          style: TextStyles.captionBody,
        ),
        trailing: Text.rich(TextSpan(
          text: "R\$ ",
          style: TextStyles.trailingRegular,
          children: [
            TextSpan(
              text: "${data.value!.toStringAsFixed(2)}",
              style: TextStyles.trailingBold,
            ),
          ],
        )),
      ),
    );
  }
}