import '../model/note_model.dart';

abstract class NoteState {
  void refreshData(NoteModel noteModel);
  void onSuccess(String success);
  void onError(String error);
}
