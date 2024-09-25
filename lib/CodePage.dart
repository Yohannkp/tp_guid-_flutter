import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tp_guide/Model/Code.dart';
import 'package:tp_guide/Repository/CodeRepository.dart';
import 'package:flutter/services.dart';




class CodePage extends StatefulWidget {
  @override
  _CodePageState createState() => _CodePageState();
}

class _CodePageState extends State<CodePage> {
  final TextEditingController _controller = TextEditingController();
  final CollectionReference _codeCollection =
  FirebaseFirestore.instance.collection('Code');
  CodeRepository codeRepository = CodeRepository();

  void _supprimer(Code code){
    CodeRepository().deleteCode(code);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter et Afficher Code'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Entrez le code'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_controller.text.isNotEmpty) {

                  Code message = new Code(uid: "", code: _controller.text);
                  await codeRepository.AjoutCode(message);
                  setState(() {
                    _controller.clear();
                  });
                }
              },
              child: Text('Ajouter'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _codeCollection.snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final codes = snapshot.data!.docs.map((doc) {
                    return Code.fromJson(doc.data() as Map<String, dynamic>);
                  }).toList();
                  return ListView.builder(
                    itemCount: codes.length,
                    itemBuilder: (context, index) {
                      return Slidable(
                          startActionPane: ActionPane(motion: const StretchMotion(), children: [
                            SlidableAction(backgroundColor: Colors.red,icon: Icons.delete,label: "Supprimer",onPressed: (context)=> _supprimer(codes[index]),)
                          ]),
                          child: GestureDetector(
                        onTap: (){
                          var data = jsonEncode(codes[index].code);
                          Clipboard.setData(ClipboardData(text: data.toString()));
                          print("touch");
                          final snackBar = SnackBar(
                            content: const Text("Copié dans le presse papié"),
                            action: SnackBarAction(
                              label: 'Cacher',
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(top: BorderSide(color: Colors.black),bottom: BorderSide(color: Colors.black),left: BorderSide(color: Colors.black),right: BorderSide(color: Colors.black),)
                            ),
                            child: ListTile(
                              title: Text(codes[index].code ?? ''),
                              subtitle: Text("Taper pour copier"),
                              trailing: Icon(Icons.copy),
                            ),
                          ),
                        ),
                      ));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
