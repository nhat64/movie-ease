import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as p;

Future<MultipartFile> getImgMultipartFileByPath(String imageSellectPath) async {
  XFile imageSellect;
  if (imageSellectPath.startsWith('http')) {
    imageSellect = await getImgXFileByUrl(imageSellectPath);
  } else if (imageSellectPath.startsWith('assets')) {
    imageSellect = await getImgXFileByAssetsPath(imageSellectPath);
  } else {
    imageSellect = await getImgXFileByFromDevice(imageSellectPath);
  }
  return MultipartFile.fromFileSync(imageSellect.path, filename: imageSellect.name, contentType: DioMediaType('image', imageSellect.path.split('.').last));
}

Future<XFile> getImgXFileByUrl(String url) async {
  var file = await DefaultCacheManager().getSingleFile(url);
  XFile result = XFile(file.path);
  return result;
}

Future<XFile> getImgXFileByAssetsPath(String assetPath) async {
  // image only exist in cache 12 hours
  final byteData = await rootBundle.load(assetPath);

  final cacheKey = 'temp_${assetPath.split(p.separator).last}';

  final file = await DefaultCacheManager().putFile(
    cacheKey,
    byteData.buffer.asUint8List(),
    maxAge: const Duration(hours: 12),
  );

  return XFile(file.path);
}

Future<XFile> getImgXFileByFromDevice(String imgPath) async {
  // image only exist in cache 12 hours
  final File file = File(imgPath);

  var result = await FlutterImageCompress.compressWithFile(
    file.absolute.path,
    minWidth: 100,
    minHeight: 100,
    quality: 70,
    format: CompressFormat.png,
  );

  final cacheKey = 'temp_${imgPath.split(p.separator).last}';

  final fileFromCache = await DefaultCacheManager().putFile(
    cacheKey,
    result!,
    maxAge: const Duration(hours: 12),
  );

  return XFile(fileFromCache.path);
}
