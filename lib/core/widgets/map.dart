import 'package:flutter/material.dart';

class InteractiveMap extends StatefulWidget {
  final String imageAsset;
  final double imageAspectRatio;
  final List<MapPoint> points;
  final Function(MapPoint)? onPointTap;
  final Color pointColor;
  final double pointSizeFactor;

  const InteractiveMap({
    super.key,
    required this.imageAsset,
    required this.imageAspectRatio,
    required this.points,
    this.onPointTap,
    this.pointColor = Colors.red,
    this.pointSizeFactor = 0.05,
  });

  @override
  State<InteractiveMap> createState() => _InteractiveMapState();
}

class _InteractiveMapState extends State<InteractiveMap> {
  late TransformationController _transformationController;
  late TapDownDetails _tapDownDetails;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final isPortrait = orientation == Orientation.portrait;
            double width, height;

            // Calcula as dimensões
            if (isPortrait) {
              width = constraints.maxWidth;
              height = width / widget.imageAspectRatio;
              if (height > constraints.maxHeight) {
                height = constraints.maxHeight;
                width = height * widget.imageAspectRatio;
              }
            } else {
              height = constraints.maxHeight;
              width = height * widget.imageAspectRatio;
              if (width > constraints.maxWidth) {
                width = constraints.maxWidth;
                height = width / widget.imageAspectRatio;
              }
            }

            return Center(
              child: GestureDetector(
                onDoubleTapDown: (details) => _tapDownDetails = details,
                onDoubleTap: _handleDoubleTap,
                child: InteractiveViewer(
                  transformationController: _transformationController,
                  boundaryMargin: const EdgeInsets.all(double.infinity),
                  minScale: 0.5,
                  maxScale: 10.0,
                  child: Container(
                    width: width,
                    height: height,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Center(
                          child: Image.asset(
                            widget.imageAsset,
                            width: width,
                            height: height,
                            fit: BoxFit.contain,
                          ),
                        ),
                        ...widget.points.map((point) {
                          return Positioned(
                            left: point.xRel * width,
                            top: point.yRel * height,
                            child: GestureDetector(
                              onTap: () {
                                if (widget.onPointTap != null) {
                                  widget.onPointTap!(point);
                                }
                              },
                              child: Container(
                                width: widget.pointSizeFactor * width,
                                height: widget.pointSizeFactor * width,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: widget.pointColor.withOpacity(0.5),
                                  border: Border.all(
                                    color: widget.pointColor,
                                    width: 2,
                                  ),
                                ),
                                child:
                                    point.iconPath != null
                                        ? Image.asset(
                                          point.iconPath!,
                                          width:
                                              widget.pointSizeFactor *
                                              width *
                                              0.8,
                                          height:
                                              widget.pointSizeFactor *
                                              width *
                                              0.8,
                                        )
                                        : null,
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _handleDoubleTap() {
    _transformationController.value = Matrix4.identity();
  }
}

class MapPoint {
  final String id;
  final String name;
  final double xRel;
  final double yRel;
  final String? iconPath;
  final dynamic data;

  MapPoint({
    required this.id,
    required this.name,
    required this.xRel,
    required this.yRel,
    this.iconPath,
    this.data,
  });
}
