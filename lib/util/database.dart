import 'package:localstore/localstore.dart';

class Database {
  final Localstore db;

  Database({
    required this.db,
  });

  CollectionRef collectionData() {
    return db.collection('clock_db');
  }

  String? collectionIdData() {
    return collectionData().doc().id;
  }
}