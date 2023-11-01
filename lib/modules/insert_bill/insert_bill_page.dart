import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payflow_project/modules/insert_bill/insert_bill_controller.dart';
import 'package:payflow_project/shared/themes/app_colors.dart';
import 'package:payflow_project/shared/themes/app_text_styles.dart';
import 'package:payflow_project/shared/widgets/input_text/input_text_widget.dart';
import 'package:payflow_project/shared/widgets/set_buttons/set_label_buttons.dart';

class InsertBillPage extends StatefulWidget {
  final String? barcode;
  const InsertBillPage({super.key, this.barcode});

  @override
  State<InsertBillPage> createState() => _InsertBillPageState();
}

class _InsertBillPageState extends State<InsertBillPage> {
  final controller = InsertBillController();

  final moneyInputTextController = MoneyMaskedTextController(
      leftSymbol: "R\$", initialValue: 0, decimalSeparator: ",");
  final vencimentoInputTextController =
      MaskedTextController(mask: "00/00/0000");
  final codigoInputTextController = TextEditingController();

  @override
  void initState() {
    if (widget.barcode != null) {
      print("VERIFICANDO VALOR DO BARCODEEEEEEEEEEE");
      print(widget.barcode);
      codigoInputTextController.text = widget.barcode!;
    }
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        leading: const BackButton(
          color: AppColors.input,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 93, vertical: 24),
                child: Text(
                  "Preencha os dados do boleto",
                  style: TextStyles.titleBoldHeading,
                  textAlign: TextAlign.center,
                ),
              ),
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    InputTextWidget(
                      label: "Nome do boleto",
                      icon: Icons.description_outlined,
                      onChanged: (value) {
                        controller.onChange(name: value);
                      },
                      validator: controller.validateName,
                    ),
                    InputTextWidget(
                      controller: vencimentoInputTextController,
                      label: "Vencimento",
                      icon: FontAwesomeIcons.circleXmark,
                      onChanged: (value) {
                        controller.onChange(dueDate: value);
                      },
                      validator: controller.validateVencimento,
                    ),
                    InputTextWidget(
                      controller: moneyInputTextController,
                      label: "Valor",
                      icon: FontAwesomeIcons.wallet,
                      validator: (_) => controller
                          .validateValor(moneyInputTextController.numberValue),
                      onChanged: (value) {
                        controller.onChange(
                            value: moneyInputTextController.numberValue);
                      },
                    ),
                    InputTextWidget(
                      controller: codigoInputTextController,
                      label: "Código",
                      icon: FontAwesomeIcons.barcode,
                      validator: controller.validateCodigo,
                      onChanged: (value) {
                        controller.onChange(barcode: value);
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(
            height: 1,
            thickness: 1,
            color: AppColors.stroke,
          ),
          SetLabelButtons(
            enableSecondaryColor: true,
            labelPrimary: "Cancelar",
            onTapPrimary: () {
              Navigator.pop(context);
            },
            labelSecondary: "Cadastrar",
            onTapSecondary: () async {
              await controller.cadastrar();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}