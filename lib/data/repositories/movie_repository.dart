import 'package:base_flutter/app/base/mvvm/model/base_repository.dart';
import 'package:base_flutter/app/base/mvvm/model/source/local/local_storage.dart';
import 'package:base_flutter/app/base/mvvm/model/source/network/api_result.dart';
import 'package:base_flutter/app/base/mvvm/model/source/network/base_response.dart';
import 'package:base_flutter/app/constans/app_strings.dart';

abstract class MoviePath {
  static const String getMovies = '/api/app/movies/get-list';
}

class MovieRepository extends BaseRepository {
  MovieRepository()
      : super(
          baseUrl: AppStrings.baseUrl,
          token: LocalStorage.getString(LocalStorageKeys.accessToken),
        );

  Future<ApiResult> getMovies({int? genreId, int? statusShow}) async {
    try {
      final resData = await dioClient.get(
        MoviePath.getMovies,
        queryParameters: {
          if (genreId != null) 'genre_id': genreId,
          if (statusShow != null) 'statusShow': statusShow,
        },
      );
      return ApiResult.apiSuccess(BaseResponse.fromJson(resData));
    } on Exception catch (e) {
      return ApiResult.apiFailure(e);
    }
  }
}

extension FakeDataMovie on MovieRepository {
  // null là tất cả, 1 là đang chiếu, 2 là sắp chiếu
  Future<ApiResult> getMoviesFake({int? movieStatus}) async {
    final BaseResponse rs = BaseResponse(
      status: 200,
      data: movieStatus == null
          ? listMovie
          : movieStatus == 1
              ? listMovie.sublist(0, 7)
              : listMovie.sublist(7, 14),
    );
    return ApiResult.apiSuccess(rs);
  }
}

List<dynamic> listMovie = [
  {
    "id": 1,
    "poster":
        "https://iguov8nhvyobj.vcdn.cloud/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/3/5/350x495-linhmieu.jpg",
    "name": "LINH MIÊU",
    "date": "22-11-2024",
    "duration": 7200,
    "trailerUrl": "https://youtu.be/4oxoPMxBO6s",
    "director": "Lưu Thành Luân",
    "movieGenre": ["Kinh dị"],
    "rated": "18+",
    "country": "Việt Nam",
    "description":
        "Linh Miêu: Quỷ Nhập Tràng lấy cảm hứng từ truyền thuyết dân gian về “quỷ nhập tràng” để xây dựng cốt truyện. Phim lồng ghép những nét văn hóa đặc trưng của Huế như nghệ thuật khảm sành - một văn hóa đặc sắc của thời nhà Nguyễn, đề cập đến các vấn đề về giai cấp và quan điểm trọng nam khinh nữ. Đặc biệt, hình ảnh rước kiệu thây ma và những hình nhân giấy không chỉ biểu trưng cho tai ương hay điềm dữ mà còn là hiện thân của nghiệp quả."
  },
  {
    "id": 2,
    "poster":
        "https://iguov8nhvyobj.vcdn.cloud/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/a/m/amazon-main-poster-printing.jpg",
    "name": "CƯỜI XUYÊN BIÊN GIỚI",
    "date": "15-11-2024",
    "duration": 7200,
    "trailerUrl": "https://youtu.be/4ALt4VT7grw",
    "director": "KIM Chang-ju",
    "movieGenre": ["Hài"],
    "rated": "13+",
    "country": "Hàn Quốc",
    "description":
        "Cười Xuyên Biên Giới kể về hành trình của Jin-bong (Ryu Seung-ryong) - cựu vô địch bắn cung quốc gia, sau khi nghỉ hưu, anh đã trở thành một nhân viên văn phòng bình thường. Đứng trước nguy cơ bị sa thải, Jin-bong phải nhận một nhiệm vụ bất khả thi là bay đến nửa kia của trái đất trong nỗ lực tuyệt vọng để sinh tồn. Sống sót sau một sự cố đe doạ tính mạng, Jin-bong đã “hạ cánh” xuống khu rừng Amazon, nơi anh gặp bộ ba thổ dân bản địa có kỹ năng bắn cung thượng thừa: Sika, Eeba và Walbu. Tin rằng đã tìm ra cách để tự cứu mình, Jin-bong hợp tác với phiên dịch ngáo ngơ Bbang-sik (Jin Sun-kyu) và đưa ba chiến thần cung thủ đến Hàn Quốc cho một nhiệm vụ táo bạo."
  },
  {
    "id": 3,
    "poster":
        "https://iguov8nhvyobj.vcdn.cloud/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/7/0/700x1000-gladiator.jpg",
    "name": "VÕ SĨ GIÁC ĐẤU II",
    "date": "15-11-2024",
    "duration": 7200,
    "trailerUrl": "https://youtu.be/R4AFSgUGEEs",
    "director": "Ridley Scott",
    "movieGenre": ["Hành động", "Phiêu lưu", "Tâm lý"],
    "rated": "18+",
    "country": "Anh",
    "description":
        "Sau khi đánh mất quê hương vào tay hoàng đế bạo chúa – người đang cai trị Rome, Lucius trở thành nô lệ giác đấu trong đấu trường Colosseum và phải tìm kiếm sức mạnh từ quá khứ để đưa vinh quang trở lại cho người dân Rome."
  },
  {
    "id": 4,
    "poster":
        "https://iguov8nhvyobj.vcdn.cloud/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/3/5/350x495-red-one_1.jpg",
    "name": "MẬT MÃ ĐỎ",
    "date": "8-11-2024",
    "duration": 7200,
    "trailerUrl": "https://youtu.be/2T_mKyH17mY",
    "director": "Jake Kasdan",
    "movieGenre": ["Hành động", "Phiêu lưu", "Hài"],
    "rated": "16+",
    "country": "Mỹ",
    "description":
        "Sau khi Ông già Noel (mật danh: Red One) bị bắt cóc, Trưởng An ninh Bắc Cực (Dwayne Johnson) phải hợp tác với thợ săn tiền thưởng khét tiếng nhất thế giới (Chris Evans) trong một nhiệm vụ kịch tính xuyên lục địa để giải cứu Giáng Sinh."
  },
  {
    "id": 5,
    "poster":
        "https://iguov8nhvyobj.vcdn.cloud/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/l/i/litbc-main-poster-printing.jpg",
    "name": "ĐÔI BẠN HỌC YÊU",
    "date": "8-11-2024",
    "duration": 7200,
    "trailerUrl": "https://youtu.be/EIARKqcXILM",
    "director": "E.Oni",
    "movieGenre": ["Tình cảm", "Hài"],
    "rated": "18+",
    "country": "Hàn Quốc",
    "description":
        "Bộ phim xoay quanh đôi bạn ngỗ nghịch Jae-hee và Heung-soo cùng những khoảnh khắc “dở khóc dở cười” khi cùng chung sống trong một ngôi nhà. Jae-hee là một cô gái “cờ xanh” với tâm hồn tự do, sống hết mình với tình yêu. Ngược lại, Heung-soo lại là một “cờ đỏ” chính hiệu khi cho rằng tình yêu là sự lãng phí cảm xúc không cần thiết. Bỏ qua những tin đồn lan tràn do người khác tạo ra, Jae-hee và Heung-soo chọn sống chung nhưng yêu theo cách riêng của họ. Hai quan điểm tình yêu trái ngược sẽ đẩy cả hai sang những ngã rẽ và kết cục khác nhau. Sau cùng, Jae-hee hay Heung-soo sẽ về đích trong hành trình “học yêu” này?"
  },
  {
    "id": 6,
    "poster":
        "https://iguov8nhvyobj.vcdn.cloud/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/_/s/_size_chu_n_nxcmct_main-poster_dctr_1_.jpg",
    "name": "NGÀY XƯA CÓ MỘT CHUYỆN TÌNH",
    "date": "28-10-2024",
    "duration": 7200,
    "trailerUrl": "https://youtu.be/qaeHlk0OXec",
    "director": "Trịnh Đình Lê Minh",
    "movieGenre": ["Tình cảm"],
    "rated": "18+",
    "country": "Việt Nam",
    "description":
        "Ngày Xưa Có Một Chuyện Tình xoay quanh câu chuyện tình bạn, tình yêu giữa hai chàng trai và một cô gái từ thuở ấu thơ cho đến khi trưởng thành, phải đối mặt với những thử thách của số phận. Trải dài trong 4 giai đoạn từ năm 1987 - 2000, ba người bạn cùng tuổi - Vinh, Miền, Phúc đã cùng yêu, cùng bỡ ngỡ bước vào đời, va vấp và vượt qua."
  },
  {
    "id": 7,
    "poster":
        "https://iguov8nhvyobj.vcdn.cloud/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/r/s/rsz_vnm3_intl_online_1080x1350_tsr_01.jpg",
    "name": "VENOM: KÈO CUỐI KÈO CUỐI KÈO CUỐI ",
    "date": "25-10-2024",
    "duration": 7200,
    "trailerUrl": "https://youtu.be/id1rfr_KZWg",
    "director": "Kelly Marcel",
    "movieGenre": [
      "Hành động",
      "Khoa học viễn tưởng",
      "Phiêu lưu",
      "Thần thoại"
    ],
    "rated": "18+",
    "country": "Mỹ",
    "description":
        "Đây là phần phim cuối cùng và hoành tráng nhất về cặp đôi Venom và Eddie Brock (Tom Hardy). Sau khi dịch chuyển từ Vũ trụ Marvel trong ‘Spider-man: No way home’ (2021) trở về thực tại, Eddie Brock giờ đây cùng Venom sẽ phải đối mặt với ác thần Knull hùng mạnh - kẻ tạo ra cả chủng tộc Symbiote và những thế lực đang rình rập khác. Cặp đôi Eddie và Venom sẽ phải đưa ra lựa quyết định khốc liệt để hạ màn kèo cuối này."
  },
  {
    "id": 8,
    "poster":
        "https://iguov8nhvyobj.vcdn.cloud/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/o/f/official_poster_the_substance.jpg",
    "name": "THẦN DƯỢC",
    "date": "01-11-2024",
    "duration": 7200,
    "trailerUrl": "https://youtu.be/zBIDSp17AOo",
    "director": "Coralie Fargeat",
    "movieGenre": ["Kinh dị"],
    "rated": "18+",
    "country": "Mỹ",
    "description":
        "Elizabeth Sparkle, minh tinh sở hữu vẻ đẹp hút hồn cùng với tài năng được mến mộ nồng nhiệt. Khi đã trải qua thời kỳ đỉnh cao, nhan sắc dần tàn phai, cô tìm đến những kẻ buôn lậu để mua một loại thuốc bí hiểm nhằm \"thay da đổi vận\", tạo ra một phiên bản trẻ trung hơn của chính mình."
  },
  {
    "id": 9,
    "poster":
        "https://iguov8nhvyobj.vcdn.cloud/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/p/o/poster_ngay_ta_da_yeu_6.jpg",
    "name": "NGÀY TA ĐÃ YÊU",
    "date": "15-11-2024",
    "duration": 7200,
    "trailerUrl": "https://youtu.be/lbLk9PzHWfg",
    "director": "John Crowley",
    "movieGenre": ["Tình Cảm", "Tâm Lý"],
    "rated": "18+",
    "country": "Anh",
    "description":
        "Định mệnh đã đưa một nữ đầu bếp đầy triển vọng và một người đàn ông vừa trải qua hôn nhân đổ vỡ đến với nhau trong tình cảnh đặc biệt. Bộ phim là cuộc tình mười năm sâu đậm của cặp đôi này, từ lúc họ rơi vào lưới tình, xây dựng tổ ấm, cho đến khi một biến cố xảy đến thay đổi hoàn toàn cuộc đời họ."
  },
  {
    "id": 10,
    "poster":
        "https://iguov8nhvyobj.vcdn.cloud/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/o/z/ozi_poster_single_470x700.jpg",
    "name": "OZI: PHI VỤ RỪNG XANH",
    "date": "15-11-2024",
    "duration": 7200,
    "trailerUrl": "https://youtu.be/tyHPFFnDuZY",
    "director": "Tim Harper",
    "movieGenre": ["Hoạt Hình"],
    "rated": "18+",
    "country": "Anh",
    "description":
        "Câu chuyện xoay quanh Ozi, một cô đười ươi mồ côi có tầm ảnh hưởng, sử dụng những kỹ năng học được để bảo vệ khu rừng và ngôi nhà của mình khỏi sự tàn phá của nạn phá rừng. Đây là một bộ phim đầy hy vọng, truyền cảm hứng cho thế hệ trẻ mạnh dạn cất tiếng nói và hành động để bảo vệ ngôi nhà chung quý giá."
  },
  {
    "id": 11,
    "poster":
        "https://iguov8nhvyobj.vcdn.cloud/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/c/l/clnc-digitalposter-vnmarket-2048_1_.jpg",
    "name": "CU LI KHÔNG BAO GIỜ KHÓC",
    "date": "15-11-2024",
    "duration": 7200,
    "trailerUrl": "https://youtu.be/kMjlJkmt5nk",
    "director": "Phạm Ngọc Lân",
    "movieGenre": ["Tâm lý", "Tình cảm", "Gia đình"],
    "rated": "18+",
    "country": "Việt Nam",
    "description":
        "Sau đám tang người chồng cũ ở nước ngoài, bà Nguyện quay lại Hà Nội với một bình tro và một con cu li nhỏ - loài linh trưởng đặc hữu của bán đảo Đông Dương. Về tới nơi, bà phát hiện ra cô cháu gái mang bầu đang vội vã chuẩn bị đám cưới. Lo sợ cô đi theo vết xe đổ của đời mình, bà kịch liệt phản đối. Bộ phim Cu Li Không Bao Giờ Khóc khéo léo pha trộn đời sống hiện tại và những dư âm phức tạp của lịch sử Việt Nam bằng cách đan xen hoài niệm về quá khứ của người dì lớn tuổi và dự cảm về tương lai đầy bất định của cặp đôi trẻ."
  },
  {
    "id": 12,
    "poster":
        "https://iguov8nhvyobj.vcdn.cloud/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/h/o/hon_ma_theo_duoi_-_payoff_poster_-_kc_15.11.2024.jpg",
    "name": "HỒN MA THEO ĐUỔI",
    "date": "15-11-2024",
    "duration": 7200,
    "trailerUrl": "https://youtu.be/B8aGGueNtiE",
    "director": "Banjong Pisanthanakun, Parkpoom Wongpoom",
    "movieGenre": ["Kinh dị"],
    "rated": "18+",
    "country": "Thái Lan",
    "description":
        "Nhiếp ảnh gia Tun và bạn gái Jane trong một lần lái xe trên đường đã vô tình gây tai nạn cho một cô gái trẻ rồi bỏ chạy mà không hề quan tâm đến sự sống chết của cô gái đó. Sau vụ tai nạn, Jane mỗi ngày sống trong lo âu, hối hận, còn những tấm ảnh được Tun chụp đều xuất hiện bóng mờ kì lạ. Từ đây, những cơn ác mộng không có hồi kết liên tiếp xảy ra với cặp đôi này, và những bí mật trong quá khứ dần dần được hé mở."
  },
  {
    "id": 13,
    "poster":
        "https://iguov8nhvyobj.vcdn.cloud/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/k/e/kedongthe_payoff_poster_kc15.11.2024.jpg",
    "name": "KẺ ĐÓNG THẾ",
    "date": "15-11-2024",
    "duration": 7200,
    "trailerUrl": "https://youtu.be/O62t0TMdG4I",
    "director": "Lương Quán Nghiêu - Lương Quán Thuấn",
    "movieGenre": ["Hành động", "Hồi hộp"],
    "rated": "18+",
    "country": "Trung Quốc",
    "description":
        "Một đạo diễn đóng thế hết thời đang vật lộn để tìm lối đi trong ngành công nghiệp điện ảnh nhiều biến động. Ông đánh cược tất cả để tạo nên màn tái xuất cuối cùng, đồng thời cố gắng hàn gắn mối quan hệ với cô con gái xa cách của mình."
  },
  {
    "id": 14,
    "poster":
        "https://iguov8nhvyobj.vcdn.cloud/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/3/5/350x495-never-let-go.jpg",
    "name": "ĐỪNG BUÔNG TAY",
    "date": "08-11-2024",
    "duration": 7200,
    "trailerUrl": "https://youtu.be/ZlsGSkMIPaU",
    "director": "Alexandre Aja",
    "movieGenre": ["Kinh Dị", "Hồi hộp"],
    "rated": "18+",
    "country": "Anh",
    "description":
        "Một ngôi nhà chứa đầy bùa chú là nơi an toàn cuối cùng để tránh xa lũ quỷ trong thế giới hậu tận thế đáng sợ. Một người mẹ và 2 đứa con nhỏ phải kết nối với ngôi nhà bằng sợi dây thừng linh thiêng để sinh tồn nơi rừng rậm, nơi hai thực thể ác độc Kẻ Xấu và Kẻ Xa Lạ có thể tước đoạt mạng người trong một phút buông tay."
  },
];
