import 'package:base_flutter/app/base/mvvm/view/base_screen.dart';
import 'package:base_flutter/presentation/module/voucher/voucher_controller.dart';
import 'package:flutter/material.dart';

class VoucherPage extends BaseScreen<VoucherController> {
  const VoucherPage({super.key});

  @override
  Color? get screenBackgroundColor => Colors.black;

  @override
  Widget buildScreen(BuildContext context) {
    return const Center(
      child: Text('Voucher Page'),
    );
  }
}
