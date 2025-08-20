import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeshop/models/user.dart';

class Database {
  final String uid;
  Database({required this.uid});

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference favoriteCollection =
      FirebaseFirestore.instance.collection('favourite');

  Future addFavorite(coffe) async {
    return await favoriteCollection
        .doc(uid)
        .collection('items')
        .doc(coffe['id'].toString())
        .set({
      "id": coffe['id'],
      "name": coffe['name'],
      "price": coffe['price'],
      "type": coffe['type'],
      "image": coffe['image']
    });
  }

  Future removeFavourite(id) async {
    return await favoriteCollection
        .doc(uid)
        .collection('items')
        .doc(id)
        .delete();
  }

  Stream<List<Map>> get favourites =>
      favoriteCollection.doc(uid).collection('items').snapshots().map(
        (snapshot) {
          return snapshot.docs.map((doc) {
            return doc.data();
          }).toList();
        },
      );

  Future updateUser(
      {required String name,
      required String email,
      String? location,
      String? phonenumber}) async {
    return await usersCollection.doc(uid).set({
      'name': name,
      'email': email,
      'location': location ?? '',
      'phone number': phonenumber ?? ''
    });
  }

  UserData _toUser(DocumentSnapshot data) {
    final map = data.data() as Map<String, dynamic>;

    return UserData(
        map['name'], map['email'], map['location'], map['phone number']);
  }

  Stream<UserData> get users =>
      usersCollection.doc(uid).snapshots().map(_toUser);
}
