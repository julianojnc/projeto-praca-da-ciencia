import 'package:flutter/material.dart';
import 'dart:async';

class InteractiveMap extends StatefulWidget {
  final String imageAsset;
  final List<MapPoint> points;
  final Function(MapPoint)? onPointTap;
  final Color pointColor;
  final double pointSizeFactor;

  const InteractiveMap({
    super.key,
    required this.imageAsset,
    required this.points,
    this.onPointTap,
    this.pointColor = Colors.red,
    this.pointSizeFactor = 0.05,
  });

  @override
  State<InteractiveMap> createState() => _InteractiveMapState();
}

class _InteractiveMapState extends State<InteractiveMap> {
  final _controller = TransformationController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return FutureBuilder<Size>(
      future: _getImageSize(widget.imageAsset),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

        final imageSize = snapshot.data!;
        final imageAspectRatio = imageSize.width / imageSize.height;

        // Altura fixada pela altura da tela
        final displayHeight = screenHeight;
        final displayWidth = displayHeight * imageAspectRatio;

        return Center(
          child: InteractiveViewer(
            transformationController: _controller,
            minScale: 0.5,
            maxScale: 5.0,
            boundaryMargin: EdgeInsets.zero,
            constrained: false,
            child: SizedBox(
              height: displayHeight,
              width: displayWidth,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      widget.imageAsset,
                      fit: BoxFit.fill,
                    ),
                  ),
                  ...widget.points.map((point) {
                    final pointSize = widget.pointSizeFactor * displayWidth;

                    return Positioned(
                      left: point.xRel * displayWidth - pointSize / 2,
                      top: point.yRel * displayHeight - pointSize / 2,
                      child: GestureDetector(
                        onTap: () => widget.onPointTap?.call(point),
                        child: Container(
                          width: pointSize,
                          height: pointSize,
                          decoration: BoxDecoration(
                            color: widget.pointColor.withOpacity(0.5),
                          ),
                          child: point.iconPath != null
                              ? Image.asset(
                                  point.iconPath!,
                                  width: pointSize * 0.8,
                                  height: pointSize * 0.8,
                                )
                              : null,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<Size> _getImageSize(String assetPath) async {
    final image = Image.asset(assetPath);
    final completer = Completer<Size>();

    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, _) {
        final myImage = info.image;
        completer.complete(Size(
          myImage.width.toDouble(),
          myImage.height.toDouble(),
        ));
      }),
    );

    return completer.future;
  }
}

// Modelo do ponto do mapa
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
