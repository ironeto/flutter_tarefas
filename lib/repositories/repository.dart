import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:http/http.dart' as http;

abstract class Repository {
  final db = FirebaseFirestore.instance;
  // final _baseUrl = "https://dmcflutter23t2-default-rtdb.firebaseio.com/";
  final String _collection; // collection
  // final auth = FirebaseAuth.instance;

  Repository(this._collection);

  Future<QuerySnapshot<Map<String, dynamic>>> list() {
    // return db.collection(_collection).where("users_id", ).get(); 
    // return db.collection(_collection).limit(10).get(); 
    return db.collection(_collection).get(); 
  } 

  Future<DocumentReference<Map<String, dynamic>>> insert(Map<String, dynamic> data) {
    return db.collection(_collection).add(data);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> show(String id) {
    return db.collection(_collection).doc(id).get();
  }

  Future<void> update(String id, Map<String, dynamic> data) {
    return db.collection(_collection).doc(id).set(data);
  }

 Future<void> delete(String id) {
    return db.collection(_collection).doc(id).delete();
  }
}