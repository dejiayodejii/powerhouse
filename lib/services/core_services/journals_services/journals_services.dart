import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:powerhouse/core/constants/_constants.dart';
import 'package:powerhouse/core/models/journal_model.dart';
import 'package:uuid/uuid.dart';

import 'i_journals_services.dart';

class JournalsService extends IJournalsService {
  static const uuid = Uuid();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<void> createJournal(JournalModel journal) async {
    journal = journal.copyWith(id: uuid.v4());
    await userJournalColl.doc(journal.id!).set(journal.toMap());
  }

  @override
  Future<void> deleteJournal(String journalId) async {
    await userJournalColl.doc(journalId).delete();
  }

  @override
  Future<void> editJournal(JournalModel journal) async {
    await userJournalColl.doc(journal.id!).update(journal.toMap());
  }

  @override
  Future<List<JournalModel>> fetchJournals() async {
    final data =
        await userJournalColl.get() as QuerySnapshot<Map<String, dynamic>>;
    return data.docs.map((doc) => JournalModel.fromMap(doc.data())).toList();
  }

  String get userId => _auth.currentUser!.uid;

  CollectionReference get journalColl =>
      _firestore.collection(ApiKeys.journals);

  CollectionReference get userJournalColl =>
      journalColl.doc(userId).collection(ApiKeys.journals);
}
