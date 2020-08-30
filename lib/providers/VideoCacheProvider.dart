import 'dart:io';
import 'package:dopamemes/providers/CacheProvider.dart';
import 'package:flutter/foundation.dart';
class VideoCacheProvider with ChangeNotifier
{

  Future<File> cachedPath;

  Future<File> getFile()
  {
      return cachedPath;
  }

  Future<void> getCachedVideo(String fullPath)
  async {
    print("download video $fullPath");
   cachedPath=CacheProvider().getSingleFile(fullPath);

  }

}