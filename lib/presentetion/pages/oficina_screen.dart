import 'package:app_praca_ciencia/core/widgets/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_praca_ciencia/core/styles/styles.dart';

class OficinaScreen extends StatelessWidget {
  const OficinaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final argumento = ModalRoute.of(context)?.settings.arguments as Map;
    final String? id = argumento['id'] as String?;

    return Scaffold(
      backgroundColor: Styles.backgroundColor,
      appBar: Header(title: 'Oficina'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance
                    .collection('oficinas')
                    .doc(id)
                    .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título
                  Center(
                    child: Text(
                      '${snapshot.data!['nome']}',
                      style: TextStyle(
                        color: Styles.fontColor,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Imagem
                  SizedBox(
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/images/img-carousel-2.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Localização
                  Text(
                    '${snapshot.data!['local']}',
                    style: TextStyle(
                      color: Styles.fontColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Conteudo
                  Container(
                    decoration: BoxDecoration(
                      color: Styles.backgroundContentColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Local
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 24,
                              color: Styles.fontColor,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '${snapshot.data!['local']}',
                              style: TextStyle(
                                color: Styles.fontColor,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Horário
                        Row(
                          children: [
                            Icon(Icons.access_time, size: 24, color: Styles.fontColor,),
                            const SizedBox(width: 6),
                            Text(
                              '${snapshot.data!['inicio_evento']}h às ${snapshot.data!['fim_evento']}h',
                              style: TextStyle(
                                color: Styles.fontColor,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Gratuito
                        Row(
                          children: [
                            Icon(Icons.person, size: 24, color: Styles.fontColor),
                            const SizedBox(width: 6),
                            Text(
                              '${snapshot.data!['limite_participantes']}',
                              style: TextStyle(
                                color: Styles.fontColor,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Descrição
                  Text(
                    '${snapshot.data!['descrição']}',
                    style: TextStyle(color: Styles.fontColor, fontSize: 14),
                  ),
                  const SizedBox(height: 24),

                  // Botão Agendar
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible:
                            snapshot.data!['lista_participantes'].length <
                                num.parse(
                                  snapshot.data!['limite_participantes'],
                                ) ||
                            snapshot.data!['lista_participantes'].contains(
                              FirebaseAuth.instance.currentUser!.uid,
                            ),
                        child: Visibility(
                          visible:
                              !snapshot.data!['lista_participantes'].contains(
                                FirebaseAuth.instance.currentUser!.uid,
                              ),
                          replacement: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Styles.buttonCancel,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                                side: BorderSide(color: Styles.fontColor),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            onPressed: () async {
                              await _excluirParticipacao(
                                snapshot.data!.id,
                              ).then((_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Participante adicionado a oficina.',
                                    ),
                                  ),
                                );
                              });
                            },
                            child: Text(
                              'CANCELAR',
                              style: TextStyle(
                                color: Styles.backgroundColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Styles.buttonSecond,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                                side: BorderSide(color: Styles.fontColor),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            onPressed: () async {
                              await _confirmarParticipacao(
                                snapshot.data!.id,
                              ).then((_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Participante removido da oficina',
                                    ),
                                  ),
                                );
                              });
                            },
                            child: Text(
                              'PARTICIPAR',
                              style: TextStyle(
                                color: Styles.fontColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _confirmarParticipacao(String id) async {
    await FirebaseFirestore.instance.collection('oficinas').doc(id).update({
      'lista_participantes': FieldValue.arrayUnion([
        FirebaseAuth.instance.currentUser!.uid,
      ]),
    });
  }

  Future<void> _excluirParticipacao(String id) async {
    await FirebaseFirestore.instance.collection('oficinas').doc(id).update({
      'lista_participantes': FieldValue.arrayRemove([
        FirebaseAuth.instance.currentUser!.uid,
      ]),
    });
  }
}
