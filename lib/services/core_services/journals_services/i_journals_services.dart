import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:powerhouse/core/models/_models.dart';

import 'journals_services.dart';

abstract class IJournalsService {
  Future<List<JournalModel>> fetchJournals();
  Future<void> createJournal(JournalModel journal);
  Future<void> editJournal(JournalModel journal);
  Future<void> deleteJournal(String journalId);
}

final journalsService = Provider<IJournalsService>((ref) => JournalsService());
