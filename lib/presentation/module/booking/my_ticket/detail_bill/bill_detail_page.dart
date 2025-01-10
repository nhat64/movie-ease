import 'package:base_flutter/app/base/mvvm/view/base_screen.dart';
import 'package:base_flutter/app/base/widget_common/call_api_widget.dart';
import 'package:base_flutter/app/constans/app_colors.dart';
import 'package:base_flutter/presentation/module/booking/my_ticket/detail_bill/bill_detail_controller.dart';
import 'package:base_flutter/presentation/widgets/app_dialog/show_qr_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class BillDetailPage extends BaseScreen<BillDetailController> {
  const BillDetailPage({super.key});

  @override
  Color? get screenBackgroundColor => Colors.black;

  @override
  bool get wrapWithSafeArea => true;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      title: const Text('Chi tiết vé'),
      centerTitle: true,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.qr_code, color: Colors.white),
          onPressed: () {
            if (controller.billDetail.value == null) return;
            showQrDialog(controller.billDetail.value!.bill!.ticketCode ?? '');
          },
        ),
      ],
    );
  }

  @override
  Widget buildScreen(BuildContext context) {
    return Obx(
      () {
        if (controller.billDetail.value == null) {
          return const Center(
            child: CicularLoadingWidget(),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 24),
                _buildInfoMovie(),
                const SizedBox(height: 20),
                _buildContainer(
                  title: 'Thông tin vé',
                  child: _buildInfoBill(),
                ),
                const SizedBox(height: 20),
                _buildContainer(
                  title: 'Địa điểm',
                  child: _buildInfoCinema(),
                  acction: InkWell(
                    onTap: () {
                      final Uri url = Uri.parse('https://maps.app.goo.gl/iqs7N9qejWFE7Qec7');
                      launchUrl(url);
                    },
                    child: const Text(
                      'Xem bản đồ',
                      style: TextStyle(
                        color: AppColors.yellowFCC434,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.yellowFCC434,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (controller.billDetail.value!.foods != null && controller.billDetail.value!.foods!.isNotEmpty)
                  _buildContainer(
                    title: 'Đồ ăn',
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.billDetail.value!.foods!.length,
                      itemBuilder: (context, index) {
                        final food = controller.billDetail.value!.foods![index];
                        return _buildRowInforFood(
                          title: food.name ?? 'Tên món ăn',
                          avatar: food.image ?? 'https://image.anninhthudo.vn/w800/Uploaded/2024/ipjoohb/2024_08_14/72430d6b-1d13-401e-83b8-15c3edb713be-1756.jpeg',
                          quantity: food.quantity ?? 0,
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(height: 16),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRowInforFood({
    required String title,
    required String avatar,
    required int quantity,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            color: AppColors.neutral1D1D1D,
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.network(
            avatar,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'x $quantity',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  _buildContainer({
    required String title,
    required Widget child,
    Widget? acction,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.neutral1D1D1D,
        borderRadius: BorderRadius.circular(14),
      ),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: acction == null ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (acction != null) acction,
            ],
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.white.withOpacity(0.5),
            margin: const EdgeInsets.symmetric(vertical: 8),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  _buildInfoCinema() {
    return Column(
      children: [
        _buildRowInforBill(
          title: 'Rạp',
          content: Text(controller.billDetail.value!.bill!.cinemaName ?? 'Tên rạp'),
        ),
        const SizedBox(height: 8),
        _buildRowInforBill(
          title: 'Phòng chiếu',
          content: Text(controller.billDetail.value!.ticket![0].room ?? 'Phòng chiếu'),
        ),
        const SizedBox(height: 8),
        _buildRowInforBill(
          title: 'Ghế',
          content: Text(controller.billDetail.value!.ticket!.map((e) => e.seatCode).join(', ')),
        ),
      ],
    );
  }

  _buildInfoBill() {
    return Column(
      children: [
        _buildRowInforBill(
          title: 'Mã vé',
          content: Text(controller.billDetail.value!.bill!.ticketCode ?? ''),
        ),
        const SizedBox(height: 8),
        _buildRowInforBill(
          title: 'Ngày chiếu',
          content: Text(controller.billDetail.value!.ticket![0].startDate ?? '00/00/0000'),
        ),
        const SizedBox(height: 8),
        _buildRowInforBill(
          title: 'Giờ chiếu',
          content: Text(controller.billDetail.value!.ticket![0].startTime ?? '00:00'),
        ),
        const SizedBox(height: 8),
        _buildRowInforBill(
          title: 'Trạng thái',
          content: Text(
            controller.billDetail.value!.bill!.status == '1' ? 'Đã lấy vé' : 'Chưa lấy vé',
            style: TextStyle(color: controller.billDetail.value!.bill!.status == '1' ? Colors.green : Colors.red),
          ),
        ),
      ],
    );
  }

  Widget _buildRowInforBill({
    required String title,
    required Widget content,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.greyCCCCCC,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: DefaultTextStyle(
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: content,
            ),
          ),
        ),
      ],
    );
  }

  _buildInfoMovie() {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 130,
            height: 190,
            decoration: BoxDecoration(
              color: AppColors.neutral1D1D1D,
              borderRadius: BorderRadius.circular(8),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              controller.billDetail.value!.movie!.avatar ?? 'https://image.anninhthudo.vn/w800/Uploaded/2024/ipjoohb/2024_08_14/72430d6b-1d13-401e-83b8-15c3edb713be-1756.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.billDetail.value!.movie!.name ?? 'Tên phim',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  controller.billDetail.value!.movie!.movieGenre?.map((e) => e.name).join(', ') ?? 'Mô tả thể loại',
                  style: const TextStyle(
                    color: AppColors.greyCCCCCC,
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  '${controller.billDetail.value!.movie!.duration ?? '0'} phút',
                  style: const TextStyle(
                    color: AppColors.greyCCCCCC,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    controller.billDetail.value!.movie!.rated?.name ?? '18+',
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
      ),
    );
  }
}
