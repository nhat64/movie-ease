import 'package:base_flutter/app/base/mvvm/view_model/base_controller.dart';
import 'package:base_flutter/data/entity/genre_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovieSearchController extends BaseController {
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  RxList<GenreEntity> listGenreSelectedTmp = <GenreEntity>[].obs;
  RxList<int> listIdGenreSelected = <int>[].obs;
  RxInt indexSelected = 0.obs;
  RxString textSearch = "".obs;

  List<GenreEntity> listGenre = [
    GenreEntity(id: 1, name: "Hành động"),
    GenreEntity(id: 12, name: "Kinh dị"),
    GenreEntity(id: 13, name: "Hài"),
    GenreEntity(id: 14, name: "Tình cảm"),
    GenreEntity(id: 15, name: "Hoạt hình"),
    GenreEntity(id: 16, name: "Phiêu lưu"),
    GenreEntity(id: 17, name: "Tâm lý"),
    GenreEntity(id: 18, name: "Gia đình"),
    GenreEntity(id: 19, name: "Thần thoại"),
    GenreEntity(id: 20, name: "Khoa học viễn tưởng"),
    GenreEntity(id: 21, name: "Hồi hộp"),
  ];

  RxBool isFilter = false.obs;

  onSelectedGenre(GenreEntity genre) {
    if (listGenreSelectedTmp.contains(genre)) {
      listGenreSelectedTmp.remove(genre);
    } else {
      listGenreSelectedTmp.add(genre);
    }
  }

  onFilter() {
    listIdGenreSelected.value = listGenreSelectedTmp.map((e) => e.id).toList();
    Get.back();
  }

  onResetFilter() {
    listGenreSelectedTmp.value = [];
    listIdGenreSelected.value = [];
    Get.back();
  }

  @override
  void onInit() {
    super.onInit();

    searchController.addListener(() {
      textSearch.value = searchController.text;
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }
}
