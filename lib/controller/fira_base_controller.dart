import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_sof/controller/data_controller.dart';
import 'package:gym_sof/model/member.dart';
import 'package:hive/hive.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireBaseController extends GetxController {
  late final storageRef;
  late final mountainsRef;
  @override
  void onInit() {
    storageRef =
        FirebaseStorage.instanceFor(bucket: "gs://gym-sof.appspot.com").ref();

    super.onInit();
  }

  Future upload_images(Box box) async {
    for (int i = 0; i < box.length; i++) {
      if (box.getAt(i).image == "") {
        print("empty");
      } else {
        print("empty");
        File file = File(box.getAt(i).image);
        mountainsRef = storageRef.child(p.basename(box.getAt(i).image));
        try {
          await mountainsRef.delete();
          await mountainsRef.putFile(file);

          print("image done");
        } catch (e) {
          print(e);
        }
      }
    }
  }

  CollectionReference membersCollection =
      FirebaseFirestore.instance.collection('members');
  final db = FirebaseFirestore.instance;
  Map<String, dynamic> member = {
    "name": "",
    "phone": "",
    "start day": "",
    "end day": "",
    "image": "",
    "blocked": "",
    "blocked day": "",
    "paid": "",
    "plan": ""
  };
  Future upload_member_doc(
    Box box,
  ) async {
    if (box.isEmpty) {
      print("no data");
    } else {
      for (int i = 0; i < box.length; i++) {
        Map<String, dynamic> member = {
          "name": box.getAt(i).name,
          "phone": box.getAt(i).phone,
          "start day": Timestamp.fromDate(box.getAt(i).start_date),
          "end day": Timestamp.fromDate(box.getAt(i).end_date),
          "image": box.getAt(i).image,
          "blocked": box.getAt(i).blocked,
          "blocked day": Timestamp.fromDate(box.getAt(i).blocked_date),
          "paid": box.getAt(i).paid,
          "plan": box.getAt(i).plan,
        };
        db
            .collection("members")
            .doc(box.getAt(i).phone)
            .set(member, SetOptions(merge: true))
            .onError((error, stackTrace) => print(""));
      }
    }
  }

  Future get_data(Data data) async {
    // Query the documents in the collection
    QuerySnapshot querySnapshot = await membersCollection.get();
    querySnapshot.docs.forEach((doc) async {
      try {
        await data.push_data(Member(
            doc["name"],
            doc["phone"],
            doc["end day"].toDate(),
            doc["image"],
            true,
            doc["start day"].toDate(),
            doc["plan"],
            doc["paid"],
            doc["blocked"],
            doc["blocked day"].toDate()));
      } catch (e) {
        print(e);
      }
      try {
        if (doc["image"] != "") {
          var islandRef = storageRef.child(p.basename(doc["image"]));
          String filePath = doc["image"];
          var file = File(filePath);
          islandRef.writeToFile(file);
        }
      } catch (e) {}
    });
  }

  Future delete_data() async {
    QuerySnapshot querySnapshot = await membersCollection.get();
    querySnapshot.docs.forEach((element) {
      db
          .collection("members")
          .doc(element["phone"])
          .delete()
          .then((value) => print("deleted "));
    });
  }

  Future delete_file() async {}
  @override
  void onClose() {
    FirebaseFirestore.instance.terminate();
    super.onClose();
  }
}
