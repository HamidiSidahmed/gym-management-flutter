import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_sof/controller/data_controller.dart';
import 'package:gym_sof/model/member.dart';
import 'package:hive/hive.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireBaseController extends GetxController {
  late var storageRef;
  late var mountainsRef;
  @override
  void onInit() {
    storageRef =
        FirebaseStorage.instanceFor(bucket: "gs://gym-sof.appspot.com").ref();

    super.onInit();
  }

  bool data_added = false;
  bool image_added = false;

  Future upload_images(Box box) async {
    for (int i = 0; i < box.length; i++) {
      if (box.getAt(i).image == "") {
        print("empty");
      } else {
        File file = File(box.getAt(i).image);
        mountainsRef = storageRef.child(p.basename(box.getAt(i).image));
        try {
          try {
            await mountainsRef.delete();
          } catch (e) {}

          await mountainsRef.putFile(file);

          print("image done");
        } catch (e) {
          print("can'i added image");
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
            .set(member, SetOptions(merge: true));
      }
    }
  }

  Future<bool> isOffline() async {
    try {
      // Attempt a simple Firestore operation (e.g., get a document that likely exists)
      await FirebaseFirestore.instance
          .collection('yourCollection')
          .doc('someDocId')
          .get();
      return false; // Success indicates online mode
    } on FirebaseException catch (error) {
      if (error.code == 'offline') {
        return true; // Offline error code detected
      } else {
        return true;
      }
    }
  }

  Future<void> get_data(Data data) async {
    final membersCollection = FirebaseFirestore.instance
        .collection('members'); // Use collection name directly

    var querySnapshot = await membersCollection.get();

    for (final doc in querySnapshot.docs) {
      final memberData = Member(
        doc['name'],
        doc['phone'],
        doc['end day'].toDate(),
        doc['image'],
        true, // Assuming this is a default value
        doc['start day'].toDate(),
        doc['plan'],
        doc['paid'],
        doc['blocked'],
        doc['blocked day'].toDate(),
      );

      await data.push_data(memberData); // Call push_data directly

      // Check for image existence before attempting download
      if (doc['image'] != null && doc['image'].isNotEmpty) {
        final islandRef = storageRef.child(p.basename(doc['image']));
        final filePath = doc['image'];
        final file = File(filePath);
        await islandRef.writeToFile(file);
      }
      print(doc["phone"]);
    }
  }

  Future delete_data() async {
    QuerySnapshot querySnapshot = await membersCollection.get();
    if (querySnapshot.docs.isEmpty) {
      print("no data to delete");
    } else {
      querySnapshot.docs.forEach((element) {
        db
            .collection("members")
            .doc(element["phone"])
            .delete()
            .then((value) => print("deleted "));
      });
    }
  }
}
