import 'package:flutter/material.dart';

class MapPoint {
  final double x; // Posição relativa X (0.0 a 1.0)
  final double y; // Posição relativa Y (0.0 a 1.0)
  final String label;
  final Color? color;
  final IconData? icon;
  final dynamic data;

  MapPoint({
    required this.x,
    required this.y,
    required this.label,
    this.color,
    this.icon,
    this.data,
  });
}