import 'package:flutter/material.dart';
import 'package:quizz/articles.dart';

class Modifier extends StatefulWidget {
  final int id;

  const Modifier({Key? key, required this.id}) : super(key: key);

  @override
  State<Modifier> createState() => _ModifierState();
}

class _ModifierState extends State<Modifier> {
  final GlobalKey<FormState> login = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final prixController = TextEditingController();
  final imageController = TextEditingController();
  final quantiteController = TextEditingController();
  late Future<List> _articles;

  @override
  void initState() {
    super.initState();
    // On récupère les informations de l'articles avec son id
    // passé en paramètre
    _articles = Article.getArticle(widget.id);
    _articles.then((value) => {
          // On pré-remplit le formulaire avec les données récupérer de l'API
          nameController.text = value[0]['name'],
          prixController.text = value[0]['prix'],
          imageController.text = value[0]['image'],
          quantiteController.text = value[0]['quantite'],
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: login,
        child: _Modifier(context),
      ),
      key: UniqueKey(),
    );
  }

  Widget _Modifier(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Modification d'un article"),
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(50),
                child: Center(
                  child: Text(
                    "Modifier un article",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.yellow),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nom',
                      hintText: 'Entrez un thème'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Veuillez rentrer un thème";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextFormField(
                  controller: prixController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Prix',
                      hintText: 'Entrez une article'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Veuillez rentrer une article";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextFormField(
                  controller: imageController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Image',
                      hintText: 'Entrez la réponse'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Veuillez rentrer la réponse";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextFormField(
                  controller: quantiteController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Quantité',
                      hintText: 'Entrez la réponse'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Veuillez rentrer la réponse";
                    }
                    return null;
                  },
                ),
              ),
              Center(
                child: Container(
                  height: 50,
                  width: 250,
                  margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    onPressed: () {
                      if (login.currentState!.validate()) {
                        Article.Update(
                            context,
                            widget.id,
                            nameController.text,
                            prixController.text,
                            imageController.text,
                            quantiteController.text);
                      }
                    },
                    child: const Text("Validez",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white)),
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
