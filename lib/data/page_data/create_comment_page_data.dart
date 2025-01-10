import 'package:base_flutter/data/entity/comment_entity.dart';
import 'package:base_flutter/data/entity/movie_entity.dart';

class CreateCommentPageData {
  final MovieEntity movie;
  final CommentEntity? comment;

  CreateCommentPageData({
    required this.movie,
    this.comment,
  });
}
