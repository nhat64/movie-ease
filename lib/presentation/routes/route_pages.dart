import 'package:base_flutter/presentation/module/auth/change_pass/change_pass_binding.dart';
import 'package:base_flutter/presentation/module/auth/change_pass/change_pass_page.dart';
import 'package:base_flutter/presentation/module/auth/forgot/forgot_page.dart';
import 'package:base_flutter/presentation/module/auth/forgot/forgt_binding.dart';
import 'package:base_flutter/presentation/module/auth/login/login_binding.dart';
import 'package:base_flutter/presentation/module/auth/login/login_page.dart';
import 'package:base_flutter/presentation/module/auth/register/register_page.dart';
import 'package:base_flutter/presentation/module/auth/register/registor_bindings.dart';
import 'package:base_flutter/presentation/module/booking/my_ticket/detail_bill/bill_detail_binding.dart';
import 'package:base_flutter/presentation/module/booking/my_ticket/detail_bill/bill_detail_page.dart';
import 'package:base_flutter/presentation/module/booking/my_ticket/my_ticket_binding.dart';
import 'package:base_flutter/presentation/module/booking/my_ticket/my_ticket_page.dart';
import 'package:base_flutter/presentation/module/booking/payment/payment_binding.dart';
import 'package:base_flutter/presentation/module/booking/payment/payment_page.dart';
import 'package:base_flutter/presentation/module/booking/select_cinema/select_cinema_binding.dart';
import 'package:base_flutter/presentation/module/booking/select_cinema/select_cinema_page.dart';
import 'package:base_flutter/presentation/module/booking/select_popcorn/popcorn_binding.dart';
import 'package:base_flutter/presentation/module/booking/select_popcorn/popcorn_page.dart';
import 'package:base_flutter/presentation/module/booking/select_seats/select_seats_binding.dart';
import 'package:base_flutter/presentation/module/booking/select_seats/select_seats_page.dart';
import 'package:base_flutter/presentation/module/booking/select_showtime/select_showtime_binding.dart';
import 'package:base_flutter/presentation/module/booking/select_showtime/select_showtime_page.dart';
import 'package:base_flutter/presentation/module/detail_cinema/cinema_detail_binding.dart';
import 'package:base_flutter/presentation/module/detail_cinema/cinema_detail_page.dart';
import 'package:base_flutter/presentation/module/detail_voucher.dart/voucher_detail_binding.dart';
import 'package:base_flutter/presentation/module/detail_voucher.dart/voucher_detail_page.dart';
import 'package:base_flutter/presentation/module/initial/initial_binding.dart';
import 'package:base_flutter/presentation/module/initial/initial_page.dart';
import 'package:base_flutter/presentation/module/movies/all_comment/all_comment_binding.dart';
import 'package:base_flutter/presentation/module/movies/all_comment/all_comment_page.dart';
import 'package:base_flutter/presentation/module/movies/create_comment/create_comment_binding.dart';
import 'package:base_flutter/presentation/module/movies/create_comment/create_comment_page.dart';
import 'package:base_flutter/presentation/module/movies/movie_detail/movie_detail_binding.dart';
import 'package:base_flutter/presentation/module/movies/movie_detail/movie_detail_page.dart';
import 'package:base_flutter/presentation/module/movies/movie_search/movie_search_binding.dart';
import 'package:base_flutter/presentation/module/movies/movie_search/movie_search_page.dart';
import 'package:base_flutter/presentation/module/movies/play_trailer/play_trailer_binding.dart';
import 'package:base_flutter/presentation/module/movies/play_trailer/play_trailer_page.dart';
import 'package:base_flutter/presentation/module/profile/edit_profile/edit_profile_binding.dart';
import 'package:base_flutter/presentation/module/profile/edit_profile/edit_profile_page.dart';
import 'package:base_flutter/presentation/module/root/root_binding.dart';
import 'package:base_flutter/presentation/module/root/root_page.dart';
import 'package:base_flutter/presentation/routes/route_names.dart';
import 'package:get/route_manager.dart';

class AppPages {
  static String initial = RouteName.welcome;

  static final appRoutes = [
    GetPage(
      name: RouteName.welcome,
      page: () => const InitialPage(),
      binding: InitialBinding(),
    ),
    GetPage(
      name: RouteName.root,
      page: () => const RootPage(),
      binding: RootBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
      name: RouteName.movieDetail,
      page: () => const MovieDetailPage(),
      binding: MovieDetailBinding(),
    ),
    GetPage(
      name: RouteName.playTrailers,
      page: () => const PlayTrailerPage(),
      binding: PlayTrailerBinding(),
    ),
    GetPage(
      name: RouteName.selectSeats,
      page: () => const SelectSeatsPage(),
      binding: SelectSeatsBinding(),
    ),
    GetPage(
      name: RouteName.selectCinema,
      page: () => const SelectCinemaPage(),
      binding: SelectCinemaBinding(),
    ),
    GetPage(
      name: RouteName.selectShowtime,
      page: () => const SelectShowtimePage(),
      binding: SelectShowtimeBinding(),
    ),
    GetPage(
      name: RouteName.selectPopcorn,
      page: () => const PopcornPage(),
      binding: PopcornBinding(),
    ),
    GetPage(
      name: RouteName.payment,
      page: () => const PaymentPage(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: RouteName.searchMovie,
      page: () => const MovieSearchPage(),
      binding: MovieSearchBinding(),
    ),
    GetPage(
      name: RouteName.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
      name: RouteName.register,
      page: () => const RegisterPage(),
      binding: RegisterBindings(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
      name: RouteName.myTicket,
      page: () => const MyTicketPage(),
      binding: MyTicketBindng(),
    ),
    GetPage(
      name: RouteName.changePass,
      page: () => const ChangePassPage(),
      binding: ChangePassBinding(),
    ),
    GetPage(
      name: RouteName.forgot,
      page: () => const ForgotPage(),
      binding: ForgotBinding(),
    ),
    GetPage(
      name: RouteName.voucherDetail,
      page: () => const VoucherDetailPage(),
      binding: VoucherDetailBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
      name: RouteName.cinemaDetail,
      page: () => const CinemaDetailPage(),
      binding: CinemaDetailBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
      name: RouteName.billDetail,
      page: () => const BillDetailPage(),
      binding: BillDetailBinding(),
    ),
    GetPage(
      name: RouteName.allComment,
      page: () => const AllCommentPage(),
      binding: AllCommentBinding(),
    ),
    GetPage(
      name: RouteName.createComment,
      page: () => const CreateCommentPage(),
      binding: CreateCommentBinding(),
    ),
    GetPage(
      name: RouteName.editProfile,
      page: () => const EditProfilePage(),
      binding: EditProfileBinding(),
    ),
  ];
}
