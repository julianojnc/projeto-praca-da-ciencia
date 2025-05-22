import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_praca_ciencia/core/widgets/map.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    super.initState();
    // Tela em formato de paisagem
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    // Ao sair volta a tela ao normal
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Lista de pontos a serem exibidos no mapa
    final points = [
      MapPoint(
        id: '1',
        name: 'Ponto de Interesse 1',
        xRel: 0.3,
        yRel: 0.4,
        iconPath: 'assets/images/logo.ico',
        data: {'info': 'Detalhes sobre este local'},
      ),
      MapPoint(
        id: '2',
        name: 'Ponto Importante',
        xRel: 0.7,
        yRel: 0.6,
        iconPath: 'assets/images/logo.ico',
        data: {'info': 'Outras informações'},
      ),
    ];

    return Scaffold(
      body: Stack(
        children: [
          WillPopScope(
            onWillPop: () async {
              // Ao sair volta a tela ao normal
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
                DeviceOrientation.landscapeLeft,
                DeviceOrientation.landscapeRight,
              ]);
              return true;
            },
            child: InteractiveMap(
              imageAsset: 'assets/images/mapa.png',
              points: points,
              pointColor: const Color.fromARGB(255, 0, 0, 0),
              pointSizeFactor: 0.05,
              onPointTap: (point) {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text(point.name),
                    content: Text(point.data['info']),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Fechar'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // Botão de voltar no canto superior esquerdo
          Positioned(
            top: 16,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              style: IconButton.styleFrom(
                backgroundColor: Colors.black.withOpacity(0.5),
                padding: const EdgeInsets.all(12),
              ),
              onPressed: () {
                // Ao sair volta a tela ao normal
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.landscapeLeft,
                  DeviceOrientation.landscapeRight,
                ]);
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}