import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_recorder/components/record_and_store.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseAnalytics analytics = FirebaseAnalytics();
final FirebaseFirestore firestore = FirebaseFirestore.instance;

final Record userRecord = Record();

String userID;

final CollectionReference firestoreRecord = firestore.collection('users');
