class TodoModel {
  final int _taskId;
  final String _text;
  final String _deadline;

  int get taskId => _taskId;
  String get title => _text;
  String get deadline => _deadline;

  static List<TodoModel> instances = List.empty(growable: true);

  TodoModel(this._taskId, this._text, this._deadline) {
    instances.add(this);
  }

  static TodoModel createInstance(String title, String deadline) {
    if (instances.isNotEmpty) {
      int latestTaskId = instances.last._taskId;
      return TodoModel(latestTaskId + 1, title, deadline);
    } else {
      return TodoModel(1, title, deadline);
    }
  }
}
