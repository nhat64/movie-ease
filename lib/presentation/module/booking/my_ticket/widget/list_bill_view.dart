import 'package:base_flutter/app/base/widget_common/call_api_widget.dart';
import 'package:base_flutter/app/constans/app_colors.dart';
import 'package:base_flutter/data/entity/bill_entity.dart';
import 'package:base_flutter/presentation/module/booking/my_ticket/my_ticket_controller.dart';
import 'package:base_flutter/presentation/routes/route_names.dart';
import 'package:base_flutter/presentation/widgets/money_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListBillView extends StatefulWidget {
  const ListBillView({super.key, required this.typeBill});

  final TypeBill typeBill;

  @override
  State<ListBillView> createState() => _ListBillViewState();
}

class _ListBillViewState extends State<ListBillView> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  bool _isLoading = true;

  List<BillEntity> _listBill = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _listBill = await Get.find<MyTicketController>().callApiGetListBill(typeBill: widget.typeBill.value);
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _isLoading
        ? const Center(
            child: CicularLoadingWidget(),
          )
        : _listBill.isEmpty
            ? const Center(
                child: Text('Không có dữ liệu'),
              )
            : _buildListBill();
  }

  _buildListBill() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ListView.separated(
        itemCount: _listBill.length,
        itemBuilder: (context, index) {
          return _buildBillItemWidget(_listBill[index]);
        },
        separatorBuilder: (context, index) => const SizedBox(height: 16),
      ),
    );
  }

  _buildBillItemWidget(BillEntity bill) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(RouteName.billDetail, arguments: bill.billId);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.neutral1D1D1D,
          borderRadius: BorderRadius.circular(14),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          children: [
            _buildInfoCinema(bill),
            const SizedBox(height: 20),
            _buildInfoMovie(bill),
            const SizedBox(height: 18),
            _buildTimeInfo(bill),
            const SizedBox(height: 30),
            _buildPrice(bill),
          ],
        ),
      ),
    );
  }

  _buildPrice(BillEntity bill) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Tổng tiền thanh toán',
          style: TextStyle(
            color: AppColors.greyCCCCCC,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        MoneyTextWidget(
          money: bill.totalPrice != null ? int.tryParse(bill.totalPrice!) ?? 0 : 0,
          unitRight: true,
          style: const TextStyle(
            color: AppColors.yellowFCC434,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          unitStyle: const TextStyle(
            color: AppColors.yellowFCC434,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  _buildTimeInfo(BillEntity bill) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _buildColumnInfo(title: 'Ngày chiếu', content: bill.showStartDate != null && bill.showStartDate!.isNotEmpty ? bill.showStartDate! : 'Trống'),
            ),
            Expanded(
              child: _buildColumnInfo(title: 'Suất chiếu', content: bill.showStartTime != null && bill.showStartTime!.isNotEmpty ? bill.showStartTime! : 'Trống'),
            ),
            Expanded(
              child: _buildColumnInfo(title: 'Phòng chiếu', content: bill.showRoom != null && bill.showRoom!.isNotEmpty ? bill.showRoom! : 'Trống'),
            )
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: _buildColumnInfo(title: 'Số lượng vé', content: bill.showTicketTotal != null ? '${bill.showTicketTotal!} vé' : 'Trống'),
            ),
            Expanded(
              flex: 2,
              child: _buildColumnInfo(title: 'Số ghế (3)', content: bill.showSeat != null && bill.showSeat!.isNotEmpty ? bill.showSeat! : 'Trống', maxLineContent: 4),
            ),
          ],
        ),
      ],
    );
  }

  _buildColumnInfo({
    required String title,
    required String content,
    int? maxLineContent,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.greyCCCCCC,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          content,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
          maxLines: maxLineContent,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  _buildInfoMovie(BillEntity bill) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 95,
          height: 120,
          decoration: BoxDecoration(
            color: AppColors.neutral1D1D1D,
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.network(
            bill.movieAvatar != null && bill.movieAvatar!.isNotEmpty
                ? bill.movieAvatar!
                : 'https://image.anninhthudo.vn/w800/Uploaded/2024/ipjoohb/2024_08_14/72430d6b-1d13-401e-83b8-15c3edb713be-1756.jpeg',
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                bill.movieName != null && bill.movieName!.isNotEmpty ? bill.movieName! : 'Tiêu đề phim',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                bill.movieGenre != null && bill.movieGenre!.isNotEmpty ? bill.movieGenre!.map((e) => e.name).join(', ') : '',
                style: const TextStyle(
                  color: AppColors.greyCCCCCC,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 20),
              Text(
                bill.movieDuration != null && bill.movieDuration!.isNotEmpty ? '${bill.movieDuration!} phút' : '0 phút',
                style: const TextStyle(
                  color: AppColors.greyCCCCCC,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: const EdgeInsets.all(4),
                child: Text(
                  bill.movieRated != null && bill.movieRated!.isNotEmpty ? bill.movieRated! : '18+',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildInfoCinema(BillEntity bill) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.neutral1D1D1D,
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.network(
            'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c5/Lotte_%22Value_Line%22_logo.svg/2048px-Lotte_%22Value_Line%22_logo.svg.png',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                bill.cinemaName != null && bill.cinemaName!.isNotEmpty ? bill.cinemaName! : 'Rạp Hà đông',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                bill.cinemaAddress != null && bill.cinemaAddress!.isNotEmpty ? bill.cinemaAddress! : 'Hà đông, Hà nội',
                style: const TextStyle(
                  color: AppColors.greyCCCCCC,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
