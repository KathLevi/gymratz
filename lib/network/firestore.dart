import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

getRoutes() {
  return Firestore.instance
      .collection('routes')
      .snapshots();
      // .listen((data) => data.documents.forEach((doc) => print(doc['name'])));
}
