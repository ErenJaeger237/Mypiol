import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserdetailRecord extends FirestoreRecord {
  UserdetailRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "Name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  void _initializeFields() {
    _name = snapshotData['Name'] as String?;
    _image = snapshotData['image'] as String?;
    _email = snapshotData['email'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('userdetail');

  static Stream<UserdetailRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UserdetailRecord.fromSnapshot(s));

  static Future<UserdetailRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UserdetailRecord.fromSnapshot(s));

  static UserdetailRecord fromSnapshot(DocumentSnapshot snapshot) =>
      UserdetailRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UserdetailRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UserdetailRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UserdetailRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UserdetailRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUserdetailRecordData({
  String? name,
  String? image,
  String? email,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'Name': name,
      'image': image,
      'email': email,
    }.withoutNulls,
  );

  return firestoreData;
}

class UserdetailRecordDocumentEquality implements Equality<UserdetailRecord> {
  const UserdetailRecordDocumentEquality();

  @override
  bool equals(UserdetailRecord? e1, UserdetailRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.image == e2?.image &&
        e1?.email == e2?.email;
  }

  @override
  int hash(UserdetailRecord? e) =>
      const ListEquality().hash([e?.name, e?.image, e?.email]);

  @override
  bool isValidKey(Object? o) => o is UserdetailRecord;
}
