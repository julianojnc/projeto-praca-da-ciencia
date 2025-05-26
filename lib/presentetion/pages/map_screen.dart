import 'package:app_praca_ciencia/presentetion/pages/map_points_information.dart';
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
        title: 'Gyrotec',
        xRel: 0.82,
        yRel: 0.59,
        pointSizeFactor: 0.04,
        iconPath: 'assets/images/logo.ico',
        text:
            'É um equipamento baseado no giro de um volante (como um pião). Quando girado rapidamente, ele demonstra a conservação do momento angular, que é a tendência de um objeto girando manter sua rotação. Ao tentar mudar sua direção, o Gyrotec resiste ao movimento, mostrando na prática como funcionam giroscópios. \n\nUsados em satélites, drones e aviões para orientação.',
        img: 'assets/images/Gyrotec.png',
        link: 'https://www.google.com',
      ),
      MapPoint(
        id: '2',
        title: 'Gerador Manual',
        xRel: 0.415,
        yRel: 0.56,
        pointSizeFactor: 0.04,
        iconPath: 'assets/images/logo.ico',
        text:
            'Um dínamo é acionado manualmente por uma manivela, transformando energia mecânica em energia elétrica. A rotação do eixo movimenta ímãs e bobinas internas, gerando corrente elétrica — acendendo lâmpadas ou movendo pequenos dispositivos.\n\nDemonstra os princípios da geração de eletricidade usados em usinas e bicicletas.',
        img: 'assets/images/GeradorManual.png',
        link: 'https://www.youtube.com',
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
              onPointTap: (point) async {
                // Volta para orientação portrait antes de navegar
                await SystemChrome.setPreferredOrientations([
                  DeviceOrientation.portraitUp,
                ]);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => MapPointInformationScreen(
                          title: point.title,
                          text: point.text,
                          img: point.img,
                          link: point.link,
                        ),
                  ),
                ).then((_) {
                  // Quando volta para o mapa, restaura orientação landscape
                  SystemChrome.setPreferredOrientations([
                    DeviceOrientation.landscapeLeft,
                    DeviceOrientation.landscapeRight,
                  ]);
                });
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
