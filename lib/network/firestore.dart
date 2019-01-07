import 'package:cloud_firestore/cloud_firestore.dart';

getRoutes(){
  return Firestore.instance.collection('routes').snapshots();
}