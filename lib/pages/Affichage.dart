import 'dart:async';
import 'package:quizz/pages/Modifier.dart';
import 'package:quizz/articles.dart';
import 'package:flutter/material.dart';

class Affichage extends StatefulWidget {
  const Affichage({Key? key}) : super(key: key);

  @override
  State<Affichage> createState() => _AffichageState();
}

class _AffichageState extends State<Affichage> {
  late Future<List> _articles;

  @override
  void initState() {
    super.initState();
    _articles = Article.getAllArticle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste des articles"),
      ),
      body: FutureBuilder<List>(
        future: _articles,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, i) {
                  return Card(
                    child: ListTile(
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            snapshot.data![i]['name'].toString(),
                            style: const TextStyle(fontSize: 20),
                          ),
                          Text(
                            snapshot.data![i]['prix'].toString(),
                            style: const TextStyle(fontSize: 18),
                          ),
                          Image.asset(
                            snapshot.data![i]['image'],
                            height: 250,
                            width: 250,
                          ),
                          Text(
                            snapshot.data![i]['quantite'].toString(),
                            style: const TextStyle(fontSize: 18),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15.0, top: 0, bottom: 0),
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Modifier(
                                                id: int.parse(snapshot.data![i]
                                                        ["id"]
                                                    .toString()))),
                                      );
                                    },
                                    child: const Icon(Icons.edit)),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SizedBox(
                                          height: 200,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                const Text(
                                                    'Êtes-vous sûr de vouloir supprimer cette article ? '),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 15.0,
                                                                right: 15.0,
                                                                top: 15.0,
                                                                bottom: 0),
                                                        child: ElevatedButton(
                                                            child: const Text(
                                                                'Oui'),
                                                            onPressed: () {
                                                              Article.Delete(
                                                                  context,
                                                                  int.parse(snapshot
                                                                      .data![i]
                                                                          ["id"]
                                                                      .toString()));
                                                            }),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 15.0,
                                                                right: 15.0,
                                                                top: 15.0,
                                                                bottom: 0),
                                                        child: ElevatedButton(
                                                          child:
                                                              const Text('Non'),
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context),
                                                        ),
                                                        
                                                      )
                                                    ]),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: const Icon(Icons.delete)),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
          } else {
            return const Center(
              child: Text("Pas de données"),
            );
          }
        },
      ),
    floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/ajout');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
