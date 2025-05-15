import 'package:app_praca_ciencia/core/widgets/header.dart';
import 'package:app_praca_ciencia/core/widgets/map.dart';
import 'package:app_praca_ciencia/core/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Forçar orientação paisagem ao entrar na tela
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    final List<MapPoint> points = [
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
      appBar: Header(title: 'Mapa Interativo'),
      drawer: Menu(),
      body: WillPopScope(
        onWillPop: () async {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight,
          ]);
          return true;
        },
        child: InteractiveMap(
          imageAsset: 'assets/images/mapa.png',
          imageAspectRatio:
              MediaQuery.of(context).size.width /
              MediaQuery.of(context).size.height,
          points: points,
          pointColor: Colors.blue,
          pointSizeFactor: 0.06,
          onPointTap: (point) {
            showDialog(
              context: context,
              builder:
                  (context) => AlertDialog(
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
    );
  }
}
