import 'package:base_flutter/app/base/mvvm/view_model/base_controller.dart';
import 'package:base_flutter/data/entity/genre_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovieSearchController extends BaseController {
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  RxList<GenreEntity?> listGenreSelected = <GenreEntity>[].obs;
  RxInt indexSelected = 0.obs;
  RxString textSearch = "".obs;

  List<GenreEntity> listGenre = [
    GenreEntity(id: 1, name: "Hành động"),
    GenreEntity(id: 2, name: "Kinh dị"),
    GenreEntity(id: 3, name: "Hài"),
    GenreEntity(id: 4, name: "Tình cảm"),
    GenreEntity(id: 5, name: "Hoạt hình"),
    GenreEntity(id: 6, name: "Phiêu lưu"),
    GenreEntity(id: 7, name: "Tâm lý"),
    GenreEntity(id: 8, name: "Gia đình"),
    GenreEntity(id: 9, name: "Thần thoại"),
    GenreEntity(id: 10, name: "Khoa học viễn tưởng"),
    GenreEntity(id: 11, name: "Hồi hộp"),
  ];

  onSelectedGenre(GenreEntity genre) {
    if (listGenreSelected.contains(genre)) {
      listGenreSelected.remove(genre);
    } else {
      listGenreSelected.add(genre);
    }
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
