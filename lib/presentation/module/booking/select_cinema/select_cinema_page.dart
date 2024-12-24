import 'package:base_flutter/app/base/mvvm/view/base_screen.dart';
import 'package:base_flutter/app/base/widget_common/call_api_widget.dart';
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
    return Obx(
      () {
        if (controller.loading.value) {
          return const Center(
            child: CicularLoadingWidget(),
          );
        }

        final listCinema = controller.cinemas;
        final position = controller.appProvider.position.value;
        return Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (listCinema.isNotEmpty && position != null) ...[
                  const Text(
                    'Rạp gần nhất',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  CinemaItemWidget(
                    cinema: listCinema.first,
                    onTap: () {
                      controller.onSelectCinema(listCinema.first);
                    },
                  ),
                  const SizedBox(height: 20),
                ],
                const Text(
                  'Tất cả rạp',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: listCinema.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final cinema = listCinema[index];
                    return CinemaItemWidget(
                      cinema: cinema,
                      onTap: () {
                        controller.onSelectCinema(cinema);
                      },
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
