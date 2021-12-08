import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:kansizlik/model/anemi.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List of Your last results"),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: getStream(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (!snapshot.hasData) {
              return const SizedBox();
            }
            List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
                snapshot.data!.docs;

            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot doc = docs[index];

                Anemi anemi =
                    Anemi.fromJson(doc.data() as Map<String, dynamic>);
                return ListTile(
                  title: Text(
                    anemi.type ?? "",
                  ),
                  subtitle: Text(
                    anemi.date != null
                        ? DateFormat("dd/MM/yyyy HH:mm")
                            .format(anemi.date!.toDate())
                        : "",
                  ),
                  trailing: Text(anemi.result! ? "Yes" : "No"),
                );
              },
            );
          }),
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getStream() {
    return FirebaseFirestore.instance
        .collection("anemi")
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy("date", descending: true)
        .snapshots();
  }
}
