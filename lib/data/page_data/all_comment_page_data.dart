import 'package:base_flutter/data/entity/comment_entity.dart';
import 'package:base_flutter/data/entity/movie_entity.dart';

class AllCommentPageData {
  final MovieEntity movie;
  final List<CommentEntity> listComment;

  AllCommentPageData({
    required this.movie,
    required this.listComment,
  });
}