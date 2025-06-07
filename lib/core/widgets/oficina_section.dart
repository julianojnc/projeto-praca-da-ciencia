import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app_praca_ciencia/core/styles/styles.dart';

class OficinasSection extends StatelessWidget {
  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot;

  const OficinasSection({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: SizedBox(
        height: 180,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: snapshot.data?.docs.length ?? 0,
          separatorBuilder: (context, index) => SizedBox(width: 10),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap:
                  () => Navigator.of(context).pushNamed(
                    '/workshop',
                    arguments: {'id': snapshot.data?.docs[index].id},
                  ),
              child: Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.only(bottom: 10),
                width: 345,
                decoration: BoxDecoration(
                  color: Styles.backgroundContentColor,
                  borderRadius: BorderRadius.circular(30),
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
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '${snapshot.data?.docs[index]['nome']}',
                                    style: TextStyle(
                                      color: Styles.fontColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      '${snapshot.data?.docs[index]['inicio_evento']} - ${snapshot.data?.docs[index]['fim_evento']}',
                                      style: TextStyle(
                                        color: Styles.fontColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      '${snapshot.data?.docs[index]['dia_evento']}',
                                      style: TextStyle(
                                        color: Styles.fontColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Styles.buttonSecond,
                                      shadowColor: Styles.button,
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(32.0),
                                      ),
                                      minimumSize: const Size(50, 35),
                                    ),
                                    onPressed:
                                        () => Navigator.of(context).pushNamed(
                                          '/workshop',
                                          arguments: {
                                            'id': snapshot.data?.docs[index].id,
                                          },
                                        ),
                                    child: Text(
                                      'Informações',
                                      style: TextStyle(
                                        color: Styles.fontColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
    );
  }
}
