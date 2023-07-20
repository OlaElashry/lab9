import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityList extends StatefulWidget {
  const ActivityList({Key? key}) : super(key: key);

  @override
  State<ActivityList> createState() => _ActivityListState();
}

class _ActivityListState extends State<ActivityList> {
  CollectionReference actDoc =
      FirebaseFirestore.instance.collection('activities');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Activities"),
      ),
      body: FutureBuilder<QuerySnapshot<Object?>>(
        future: actDoc.get(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.hasData == false && snapshot.data == null) {
            return Text("Document does not exist");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return Text(
                      "Full Name: ${snapshot.data!.docs[index]['name']} ${snapshot.data!.docs[index]['time']}");
                });
          }

          return Text("loading");
        },
      ),
    );
  }
}
