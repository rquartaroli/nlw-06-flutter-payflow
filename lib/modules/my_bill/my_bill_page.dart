import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:payflow_project/shared/themes/app_colors.dart';
import 'package:payflow_project/shared/themes/app_text_styles.dart';
import 'package:payflow_project/shared/widgets/bill_list/bill_list_widget.dart';

class MyBillPage extends StatefulWidget {
  const MyBillPage({super.key});

  @override
  State<MyBillPage> createState() => _MyBillPageState();
}

class _MyBillPageState extends State<MyBillPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            child: Row(
              children: [
                Text("Meus boletos", style: TextStyles.titleBoldHeading),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Divider(
              color: AppColors.stroke,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: AnimatedCard(
              direction: AnimatedCardDirection.bottom,
              child: BillListWidget(
                key: UniqueKey(),
              ),
            ),
          )
        ],
      ),
    );
  }
}