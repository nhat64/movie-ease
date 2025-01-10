import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';

class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    this.avatarPath,
    required this.name,
    this.size,
  });

  final String? avatarPath;
  final String name;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: size ?? 100,
        height: size ?? 100,
        child: _buildAvatar(),
      ),
    );
  }

  _buildAvatar() {
    if (avatarPath == null || avatarPath!.isEmpty) {
      return Initicon(text: name, elevation: 4);
    }

    if (avatarPath!.startsWith('http')) {
      return ClipOval(
        child: Image.network(
          avatarPath!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Initicon(text: name, elevation: 4);
          },
        ),
      );
    }

    if (avatarPath!.startsWith('assset')) {
      return ClipOval(
        child: Image.asset(
          avatarPath!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Initicon(text: name, elevation: 4);
          },
        ),
      );
    }

    return ClipOval(
      child: Image.file(
        File(avatarPath!),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Initicon(text: name, elevation: 4);
        },
      ),
    );
  }
}
