import 'package:app_praca_ciencia/core/widgets/header.dart';
import 'package:app_praca_ciencia/core/widgets/menu.dart';
import 'package:flutter/material.dart';

class InteractiveMap extends StatefulWidget {
  const InteractiveMap({super.key});

  @override
  State<InteractiveMap> createState() => _InteractiveMapState();
}

class _InteractiveMapState extends State<InteractiveMap> {
  final List<Map<String, dynamic>> points = [
    {'x': 0.42, 'y': 0.40, 'label': 'Relógio de Sol'},
    {'x': 0.75, 'y': 0.5, 'label': 'Espelhos Curvos'},
  ];

  final double imageWidth = 1000;
  final double imageHeight = 800;
  final TransformationController _transformationController = TransformationController();
  double _currentScale = 1.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setInitialZoom();
    });
    
    _transformationController.addListener(() {
      setState(() {
        _currentScale = _transformationController.value.getMaxScaleOnAxis();
      });
    });
  }

  void _setInitialZoom() {
    final screenSize = MediaQuery.of(context).size;
    final imageAspectRatio = imageWidth / imageHeight;
    final screenAspectRatio = screenSize.width / screenSize.height;

    double initialScale;
    if (screenAspectRatio > imageAspectRatio) {
      initialScale = screenSize.height / imageHeight;
    } else {
      initialScale = screenSize.width / imageWidth;
    }

    _transformationController.value = Matrix4.identity()..scale(initialScale);
    _currentScale = initialScale;
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: 'Mapa Interativo'),
      drawer: Menu(),
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFFFFFFFF),
      body: InteractiveViewer(
        transformationController: _transformationController,
        panEnabled: true,
        scaleEnabled: true,
        boundaryMargin: EdgeInsets.all(double.infinity),
        minScale: 0.8,
        maxScale: 2.0,
        child: Stack(
          children: [
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: Image.asset(
                  'assets/images/mapa.png',
                  width: imageWidth,
                  height: imageHeight,
                ),
              ),
            ),
            
            for (var point in points)
              Positioned(
                left: point['x'] * MediaQuery.of(context).size.width,
                top: point['y'] * MediaQuery.of(context).size.height,
                child: GestureDetector(
                  onTap: () {
                    print('Clicou no ${point['label']}');
                  },
                  child: Container(
                    width: 17,
                    height: 17,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1),
                    ),
                    child: Center(
                      child: Tooltip(
                        message: point['label'],
                        child: Icon(
                          Icons.location_on,
                          size: 17 * 0.6,
                          color: Colors.orange[900],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}