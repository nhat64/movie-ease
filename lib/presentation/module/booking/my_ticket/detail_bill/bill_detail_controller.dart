import 'package:base_flutter/app/base/helper/log.dart';
import 'package:base_flutter/app/base/mvvm/view_model/base_controller.dart';
import 'package:base_flutter/data/entity/bill_detail.dart';
import 'package:base_flutter/data/repositories/book_repository.dart';
import 'package:get/get.dart';

class BillDetailController extends BaseController {

  final int billId;

  BillDetailController({required this.billId});

  final BookRepository _bookRepository = BookRepository();

  Rx<BillDetail?> billDetail = Rx(null);

  @override
  onReady() {
    super.onReady();
    callApiGetBill(billId: billId);
  }

  callApiGetBill({required int billId}) async {
    final rs = await _bookRepository.getDetailBill(billId);

    await rs.when(
      apiSuccess: (res) async {
        billDetail.value = BillDetail.fromJson(res.data);
      },
      apiFailure: (error) async {
        Log.console('error: $error');
      },
    );
  }
}
