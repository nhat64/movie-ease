import 'package:json_annotation/json_annotation.dart';
part 'comment_entity.g.dart';

@JsonSerializable()
class CommentEntity {
  @JsonKey(name: 'account_id')
  int accountId;
  @JsonKey(name: 'comment')
  String? comment;
  @JsonKey(name: 'vote_star')
  int? voteStar;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'avatar')
  String? avatar;

  CommentEntity({
    this.accountId = 0,
    this.comment,
    this.voteStar,
    this.createdAt,
    this.name,
    this.avatar,
  });

  factory CommentEntity.fromJson(Map<String, dynamic> json) =>
      _$CommentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CommentEntityToJson(this);
}
