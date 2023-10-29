import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:powerhouse/app/_app.dart';
import 'package:powerhouse/core/mixins/_mixins.dart';
import 'package:powerhouse/core/models/_models.dart';
import 'package:powerhouse/services/_services.dart';
import 'package:powerhouse/ui/constants/view_state.dart';
import 'package:powerhouse/ui/dialogs/_dialogs.dart';

import '../states/journal_state.dart';

typedef State = ViewState<JournalState>;

class JournalNotifier extends StateNotifier<State>
    with DialogAndSheetMixin, ToastMixin {
  final INavigationService navigationService;
  final IJournalsService journalsService;
  JournalNotifier({
    required this.navigationService,
    required this.journalsService,
  }) : super(State.idle(JournalState()));

  final _logger = Logger();

  void init() {
    fetchJournals();
  }

  Future<void> createJournal() async {
    await showAppDialog(const NewJournalDialog());
  }

  Future<void> fetchJournals() async {
    try {
      state = state.loading();
      state = state
          .idle(state.data!..journals = await journalsService.fetchJournals());
    } on Failure catch (e) {
      _logger.e(e.toString());
      showFailureToast(e.toString());
      state = state.failure(e);
    }
  }

  Future<void> onSaveJournal(JournalModel journal) async {
    try {
      FocusManager.instance.primaryFocus?.unfocus();
      if (journal.title.isEmpty) {
        throw Failure(message: "Title must not be empty.");
      }
      state = state.loading();
      navigationService.pop();
      if (journal.id == null) {
        await journalsService.createJournal(journal);
      } else {
        await journalsService.editJournal(journal);
      }
      await showAppDialog(const ConfirmationDialog(body: "Journal Saved"));
      if (journal.id == null) {
        navigationService.navigateTo(Routes.journalDetailView,
            arguments: journal);
      } else {
        navigationService.replaceWith(Routes.journalDetailView,
            arguments: journal);
      }
    } on Failure catch (e) {
      _logger.e(e.toString());
      showFailureToast(e.toString());
    } finally {
      state = state.idle();
    }
  }

  Future<void> onDeleteJournal(JournalModel journal) async {
    try {
      await journalsService.deleteJournal(journal.id!);
      state = state.idle(state.data!..journals.remove(journal));
      navigationService.pop();
      showAppDialog(const ConfirmationDialog(body: "Journal Deleted"));
    } on Failure catch (e) {
      _logger.e(e.toString());
      showFailureToast(e.toString());
    }
  }

  void onJournalMenuSelected(String value, JournalModel journal) async {
    switch (value) {
      case "delete":
        await onDeleteJournal(journal);
        break;
      default:
        await showAppDialog(NewJournalDialog(journal: journal));
        break;
    }
  }

  void navigateToSettings() {
    navigationService.navigateTo(Routes.settingsView);
  }

  void navigateToJournalDetail(JournalModel journal) {
    navigationService.navigateTo(Routes.journalDetailView, arguments: journal);
  }

  void navigateBack() => navigationService.pop();
}

final journalNotifier = StateNotifierProvider<JournalNotifier, State>(
  (ref) => JournalNotifier(
    navigationService: ref.watch(navigationService),
    journalsService: ref.watch(journalsService),
  ),
);
