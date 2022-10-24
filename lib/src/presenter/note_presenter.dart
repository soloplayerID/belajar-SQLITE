// ignore_for_file: avoid_print

import '../model/note_model.dart';
import '../state/note_state.dart';

abstract class NotePresenterAbstract {
  set view(NoteState view) {}
}

class NotePresenter implements NotePresenterAbstract {
  final NoteModel _noteModel = NoteModel();
  late NoteState _noteState;

  @override
  set view(NoteState view) {
    _noteState = view;
    _noteState.refreshData(_noteModel);
  }
}
