import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({super.key, required this.score});

  final int score;

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  final _textController = TextEditingController();
  bool esconder = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Sua pontuação final:",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomLeft,
                    colors: [Color(0xFF276DC9), Color(0XFF1F2F98)]),
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Center(
                  child: Text(
                    "${widget.score}",
                    style: const TextStyle(
                        fontSize: 140,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Mensagens enviadas antes do tempo acabar!",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      enabled: !esconder,
                      controller: _textController,
                      maxLength: 5,
                      decoration: const InputDecoration(
                          label: Text("Seu nick"),
                          counterText: "",
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey))),
                    ),
                  ),
                ),
                if (!esconder)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          esconder = enviarPontuacaoFirebase(
                              _textController.text, widget.score);
                        });
                      },
                      customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomLeft,
                              colors: [Color(0xFF276DC9), Color(0XFF1F2F98)]),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        height: 55,
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              "Enviar >",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
              ],
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('pontuacoes')
                    .orderBy("pontuacao", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Flexible(
                    child: ListView(
                      //physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: snapshot.data!.docs.map((document) {
                        return ListTile(
                          leading: const Icon(Icons.emoji_emotions),
                          title: Text(document['nome']),
                          trailing: Text(document['pontuacao'].toString()),
                        );
                      }).toList(),
                    ),
                  );
                })
          ],
        )),
      ),
    );
  }
}

bool enviarPontuacaoFirebase(String nome, int pontuacao) {
  try {
    var database = FirebaseFirestore.instance;
    database
        .collection("pontuacoes")
        .add({"nome": nome, "pontuacao": pontuacao});
  } catch (e) {
    return false;
  }
  return true;
}
