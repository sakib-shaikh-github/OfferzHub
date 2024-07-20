import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Firebase
final FirebaseFirestore firestore = FirebaseFirestore.instance;

final FirebaseAuth auth = FirebaseAuth.instance;

final FirebaseStorage fireStorage = FirebaseStorage.instance;

//Getit
final getIt = GetIt.instance;

//Shared Preferences
late final SharedPreferences gloabal_prefs;
