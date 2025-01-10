import 'package:base_flutter/app/constans/app_assets.dart';
import 'package:base_flutter/app/constans/app_colors.dart';
import 'package:base_flutter/data/entity/comment_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    super.key,
    required this.comment,
    this.isFixable = false,
    this.onEdit,
    this.onDelete,
  });

  final CommentEntity comment;
  final bool isFixable;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    if (isFixable) {
      return Slidable(
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (_) async {
                if (onEdit != null) {
                  onEdit!();
                }
              },
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              label: 'Sửa',
            ),
            SlidableAction(
              onPressed: (_) async {
                if (onDelete != null) {
                  onDelete!();
                }
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              label: 'Xoá',
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: _buildItem(context),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.more_vert, color: AppColors.greyCCCCCC),
          ],
        ),
      );
    } else {
      return _buildItem(context);
    }
  }

  Widget _buildItem(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Avatar
          Row(
            children: [
              Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.black262626,
                      width: 2,
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    comment.avatar ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      ImagePaths.avatarDefault,
                      fit: BoxFit.cover,
                    ),
                  )),
              const SizedBox(width: 8),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comment.name ?? 'Tên người dùng',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    timeAgoFromString(comment.createdAt ?? ''),
                    style: const TextStyle(
                      color: AppColors.greyCCCCCC,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              )
            ],
          ),
          // vote
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.star, color: AppColors.yellowFCC434, size: 16),
              const SizedBox(width: 4),
              Text(
                '${comment.voteStar ?? 0}/5 - ${getRatingDescription(comment.voteStar ?? 0)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          // content
          const SizedBox(height: 8),
          Text(
            comment.comment ?? 'Nội dung đánh giá',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  String getRatingDescription(int rating) {
    if (rating < 1 || rating > 5) {
      return 'Điểm không hợp lệ';
    }

    if (rating <= 1) {
      return 'Tệ';
    } else if (rating <= 2) {
      return 'Bình thường';
    } else if (rating <= 3) {
      return 'Khá tốt';
    } else if (rating <= 4) {
      return 'Tốt';
    } else {
      return 'Tuyệt vời';
    }
  }

  String timeAgoFromString(String commentTimeString) {
    try {
      final commentTime = DateTime.parse(commentTimeString);
      final now = DateTime.now();
      final difference = now.difference(commentTime);

      if (difference.inSeconds < 60) {
        return '${difference.inSeconds} giây trước';
      } else if (difference.inMinutes < 60) {
        return '${difference.inMinutes} phút trước';
      } else if (difference.inHours < 24) {
        return '${difference.inHours} giờ trước';
      } else if (difference.inDays < 30) {
        return '${difference.inDays} ngày trước';
      } else if (difference.inDays < 365) {
        final months = (difference.inDays / 30).floor();
        return '$months tháng trước';
      } else {
        final years = (difference.inDays / 365).floor();
        return '$years năm trước';
      }
    } catch (e) {
      return 'Thời gian không hợp lệ';
    }
  }
}
