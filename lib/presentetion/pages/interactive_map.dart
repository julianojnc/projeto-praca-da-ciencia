import 'package:flutter/material.dart';

class InteractiveMap extends StatefulWidget {
  const InteractiveMap({super.key});

  @override
  State<InteractiveMap> createState() => _InteractiveMapState();
}

class _InteractiveMapState extends State<InteractiveMap> {
  final List<Map<String, dynamic>> _markers = [
    {
      'position': Offset(150, 200), 
      'icon': Icons.location_pin,
      'color': Colors.red,
      'label': 'Ponto 1',
    },
    {
      'position': Offset(300, 450),
      'icon': Icons.flag,
      'color': Colors.blue,
      'label': 'Ponto 2',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mapa Interativo')),
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: InteractiveViewer(
          boundaryMargin: const EdgeInsets.all(20.0),
          minScale: 0.1,
          maxScale: 5,
          constrained: true,
          child: Stack(
            children: [
              const Image(image: AssetImage('assets/images/mapa.png')),
              
              ..._markers.map((marker) {
                return Positioned(
                  left: marker['position'].dx,
                  top: marker['position'].dy,
                  child: GestureDetector(
                    onTap: () {
                      _showMarkerInfo(marker['label']);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          marker['icon'],
                          color: marker['color'],
                          size: 40,
                        ),
                        Text(
                          marker['label'],
                          style: TextStyle(
                            backgroundColor: Colors.white.withOpacity(0.7),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  void _showMarkerInfo(String label) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Informação do Marcador'),
        content: Text('Você clicou no $label'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Fechar'),
          ),
        ],
      ),
    );
  }
}