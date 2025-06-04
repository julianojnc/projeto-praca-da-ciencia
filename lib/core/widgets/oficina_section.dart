import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app_praca_ciencia/core/styles/styles.dart';

class OficinasSection extends StatelessWidget {
  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot;

  const OficinasSection({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 200,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data?.docs.length ?? 0,
            separatorBuilder: (context, index) => SizedBox(width: 10),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.of(context).pushNamed('/workshop', arguments: {'id': snapshot.data?.docs[index].id}),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Styles.backgroundContentColor,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width / 1.2,
                    child: Row(
                      children: [
                        const Image(
                          image: AssetImage('assets/images/imgOficina.png'),
                          fit: BoxFit.cover,
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '${snapshot.data?.docs[index]['nome']}',
                                    style: TextStyle(
                                      color: Styles.fontColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${snapshot.data?.docs[index]['inicio_evento']} - ${snapshot.data?.docs[index]['fim_evento']}',
                                    style: TextStyle(
                                      color: Styles.fontColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${snapshot.data?.docs[index]['dia_evento']}',
                                    style: TextStyle(
                                      color: Styles.fontColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                            Styles.buttonSecond,
                                          ),
                                      shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder
                                      >(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          side: BorderSide(
                                            color: Styles.fontColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      'Informações',
                                      style: TextStyle(
                                        color: Styles.fontColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
