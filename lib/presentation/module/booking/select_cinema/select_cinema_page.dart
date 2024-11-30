import 'package:base_flutter/app/base/mvvm/view/base_screen.dart';
import 'package:base_flutter/presentation/module/booking/select_cinema/select_cinema_controller.dart';
import 'package:base_flutter/presentation/module/booking/select_cinema/widget/cinema_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectCinemaPage extends BaseScreen<SelectCinemaController> {
  const SelectCinemaPage({super.key});

  @override
  Color? get screenBackgroundColor => Colors.black;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      title: const Text('Chọn rạp chiếu'),
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
    );
  }

  @override
  Widget buildScreen(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: controller.cinemas.length,
          itemBuilder: (context, index) {
            final cinema = controller.cinemas[index];
            return CinemaItemWidget(cinema: cinema);
          },
          separatorBuilder: (context, index) => const SizedBox(height: 16),
        ),
      );
    });
  }
}
