import 'package:base_flutter/presentation/module/auth/login/login_binding.dart';
import 'package:base_flutter/presentation/module/auth/login/login_page.dart';
import 'package:base_flutter/presentation/module/auth/register/register_page.dart';
import 'package:base_flutter/presentation/module/auth/register/registor_bindings.dart';
import 'package:base_flutter/presentation/module/booking/my_ticket/my_ticket_binding.dart';
import 'package:base_flutter/presentation/module/booking/my_ticket/my_ticket_page.dart';
import 'package:base_flutter/presentation/module/booking/select_cinema/select_cinema_binding.dart';
import 'package:base_flutter/presentation/module/booking/select_cinema/select_cinema_page.dart';
import 'package:base_flutter/presentation/module/booking/select_seats/select_seats_binding.dart';
import 'package:base_flutter/presentation/module/booking/select_seats/select_seats_page.dart';
import 'package:base_flutter/presentation/module/booking/select_showtime/select_showtime_binding.dart';
import 'package:base_flutter/presentation/module/booking/select_showtime/select_showtime_page.dart';
import 'package:base_flutter/presentation/module/movies/movie_detail/movie_detail_binding.dart';
import 'package:base_flutter/presentation/module/movies/movie_detail/movie_detail_page.dart';
import 'package:base_flutter/presentation/module/movies/movie_search/movie_search_binding.dart';
import 'package:base_flutter/presentation/module/movies/movie_search/movie_search_page.dart';
import 'package:base_flutter/presentation/module/movies/play_trailer/play_trailer_binding.dart';
import 'package:base_flutter/presentation/module/movies/play_trailer/play_trailer_page.dart';
import 'package:base_flutter/presentation/module/payment/payment_binding.dart';
import 'package:base_flutter/presentation/module/payment/payment_page.dart';
import 'package:base_flutter/presentation/module/root/root_binding.dart';
import 'package:base_flutter/presentation/module/root/root_page.dart';
import 'package:base_flutter/presentation/module/welcome/welcome_binding.dart';
import 'package:base_flutter/presentation/module/welcome/welcome_page.dart';
import 'package:base_flutter/presentation/routes/route_names.dart';
import 'package:get/route_manager.dart';

class AppPages {
  static String initial = RouteName.welcome;

  static final appRoutes = [
    GetPage(
      name: RouteName.welcome,
      page: () => const WelcomePage(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: RouteName.root,
      page: () => const RootPage(),
      binding: RootBinding(),
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
    )
  ];
}
