import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';

class AppCore {
  static final AppCore _instance = AppCore._();
  factory AppCore() => _instance;
  AppCore._();

  bool _isOnline = true;
  bool _lightweightMode = false;
  bool get isOnline => _isOnline;
  bool get lightweightMode => _lightweightMode;

  StreamSubscription? _sub;

  void init() {
    _sub = Connectivity().onConnectivityChanged.listen((result) {
      _isOnline = result != ConnectivityResult.none;
    });
  }

  void toggleLightweight() {
    _lightweightMode = !_lightweightMode;
  }

  void dispose() {
    _sub?.cancel();
  }

  // For helpers with limited data plans:
  // - Disables auto-play videos
  // - Reduces image quality
  // - Disables animations
  // - Compresses shared images
  static const int MAX_IMAGE_KB = 200;
  static const bool CACHE_IMAGES = true;
  static const int MAX_CACHE_MB = 50;
}