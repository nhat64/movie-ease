import 'package:json_annotation/json_annotation.dart';

part 'bill_detail.g.dart';

@JsonSerializable()
class BillDetail {
  @JsonKey(name: 'bill')
  Bill? bill;
  @JsonKey(name: 'movie')
  _Movie? movie;
  @JsonKey(name: 'ticket')
  List<_Ticket>? ticket;
  @JsonKey(name: 'voucher')
  _Voucher? voucher;
  @JsonKey(name: 'foods')
  List<_Foods>? foods;

  BillDetail({
    this.bill,
    this.movie,
    this.ticket,
    this.voucher,
    this.foods,
  });

  factory BillDetail.fromJson(Map<String, dynamic> json) => _$BillDetailFromJson(json);

  Map<String, dynamic> toJson() => _$BillDetailToJson(this);
}

@JsonSerializable()
class Bill {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'ticket_code')
  String? ticketCode;
  @JsonKey(name: 'account_id')
  int? accountId;
  @JsonKey(name: 'cinema_id')
  int? cinemaId;
  @JsonKey(name: 'movie_show_time_id')
  int? movieShowTimeId;
  @JsonKey(name: 'staff_check')
  int? staffCheck;
  @JsonKey(name: 'total')
  String? total;
  @JsonKey(name: 'extra_id')
  String? extraId;
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'cinema_name')
  String? cinemaName;
  @JsonKey(name: 'cinema_address')
  String? cinemaAddress;

  Bill({
    this.id,
    this.ticketCode,
    this.accountId,
    this.cinemaId,
    this.movieShowTimeId,
    this.staffCheck,
    this.total,
    this.extraId,
    this.status,
    this.cinemaName,
    this.cinemaAddress,
  });

  factory Bill.fromJson(Map<String, dynamic> json) => _$BillFromJson(json);

  Map<String, dynamic> toJson() => _$BillToJson(this);
}

@JsonSerializable()
class _Movie {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'slug')
  String? slug;
  @JsonKey(name: 'genre_id')
  int? genreId;
  @JsonKey(name: 'country_id')
  int? countryId;
  @JsonKey(name: 'rated_id')
  int? ratedId;
  @JsonKey(name: 'avatar')
  String? avatar;
  @JsonKey(name: 'poster')
  String? poster;
  @JsonKey(name: 'trailer_url')
  String? trailerUrl;
  @JsonKey(name: 'duration')
  String? duration;
  @JsonKey(name: 'date')
  String? date;
  @JsonKey(name: 'performer')
  String? performer;
  @JsonKey(name: 'director')
  String? director;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'vote_total')
  int? voteTotal;
  @JsonKey(name: 'voting')
  String? voting;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'movie_genre')
  List<_MovieGenre>? movieGenre;
  @JsonKey(name: 'rated')
  _Rated? rated;

  _Movie({
    this.id,
    this.name,
    this.slug,
    this.genreId,
    this.countryId,
    this.ratedId,
    this.avatar,
    this.poster,
    this.trailerUrl,
    this.duration,
    this.date,
    this.performer,
    this.director,
    this.description,
    this.voteTotal,
    this.voting,
    this.status,
    this.movieGenre,
    this.rated,
  });

  factory _Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);
}

@JsonSerializable()
class _MovieGenre {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'description')
  String? description;

  _MovieGenre({
    this.id,
    this.name,
    this.description,
  });

  factory _MovieGenre.fromJson(Map<String, dynamic> json) => _$MovieGenreFromJson(json);

  Map<String, dynamic> toJson() => _$MovieGenreToJson(this);
}

@JsonSerializable()
class _Rated {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'description')
  String? description;

  _Rated({
    this.id,
    this.name,
    this.description,
  });

  factory _Rated.fromJson(Map<String, dynamic> json) => _$RatedFromJson(json);

  Map<String, dynamic> toJson() => _$RatedToJson(this);
}

@JsonSerializable()
class _Ticket {
  @JsonKey(name: 'price')
  int? price;
  @JsonKey(name: 'seat_code')
  String? seatCode;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'start_time')
  String? startTime;
  @JsonKey(name: 'end_time')
  String? endTime;
  @JsonKey(name: 'movie_name')
  String? movieName;
  @JsonKey(name: 'movie_id')
  int? movieId;
  @JsonKey(name: 'avatar')
  String? avatar;
  @JsonKey(name: 'room')
  String? room;
  @JsonKey(name: 'start_date')
  String? startDate;

  _Ticket({
    this.price,
    this.seatCode,
    this.name,
    this.startTime,
    this.endTime,
    this.movieName,
    this.movieId,
    this.avatar,
    this.room,
    this.startDate,
  });

  factory _Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

  Map<String, dynamic> toJson() => _$TicketToJson(this);
}

@JsonSerializable()
class _Voucher {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'promo_name')
  String? promoName;
  @JsonKey(name: 'avatar')
  String? avatar;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'discount')
  int? discount;
  @JsonKey(name: 'start_date')
  String? startDate;
  @JsonKey(name: 'end_date')
  String? endDate;
  @JsonKey(name: 'quantity')
  int? quantity;
  @JsonKey(name: 'status')
  int? status;

  _Voucher({
    this.id,
    this.promoName,
    this.avatar,
    this.description,
    this.discount,
    this.startDate,
    this.endDate,
    this.quantity,
    this.status,
  });

  factory _Voucher.fromJson(Map<String, dynamic> json) => _$VoucherFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherToJson(this);
}

@JsonSerializable()
class _Foods {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'price')
  int? price;
  @JsonKey(name: 'image')
  String? image;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'quantity')
  int? quantity;
  @JsonKey(name: 'total')
  int? total;

  _Foods({
    this.id,
    this.name,
    this.description,
    this.price,
    this.image,
    this.status,
    this.quantity,
    this.total,
  });

  factory _Foods.fromJson(Map<String, dynamic> json) => _$FoodsFromJson(json);

  Map<String, dynamic> toJson() => _$FoodsToJson(this);
}
