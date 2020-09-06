class TodoModel {
  int _id;
  String _title;
  String _description;
  bool _isCompleted;
  DateTime _deadline;
  int _priority;

  TodoModel(
    this._title,
    this._description,
    this._isCompleted,
    this._deadline,
    this._priority,
  );

  TodoModel.withId(
    this._id,
    this._title,
    this._description,
    this._isCompleted,
    this._deadline,
    this._priority,
  );

  // Getters
  int get id => this._id;
  String get title => this._title;
  String get description => this._description;
  bool get isCompleted => this._isCompleted;
  DateTime get deadline => this._deadline;
  int get priority => this._priority;

  // Setters
  set id(int newId) => this._id = this._id;
  set title(String newTitle) => this._title = newTitle;
  set description(String newDesc) => this._description = newDesc;
  set isCompleted(bool status) => this._isCompleted = status;
  set deadline(DateTime newDeadline) => this._deadline = newDeadline;
  set priority(int newPriority) => this._priority = newPriority;

  TodoModel.fromJson(Map<String, dynamic> json) {
    this._id = json['id'] ?? 0;
    this._title = json['title'] ?? 'Title';
    this._description = json['description'] ?? 'Description';
    this._isCompleted = json['is_completed'] ?? false;
    this._priority = json['priority'] ?? 0;

    try {
      this._deadline = DateTime.parse(json['deadline'].toString()) ?? null;
    } catch (e) {
      print('🍕 Error: $e');
      this._deadline = null;
    }
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['id'] = this._id;
    map['title'] = this._title;
    map['description'] = this._description;
    map['is_completed'] = this._isCompleted;
    map['priority'] = this._priority;

    if (this._deadline != null) {
      String deadlineTmp = this._deadline.toString();
      String date = deadlineTmp.split(' ')[0];
      String time = deadlineTmp.split(' ')[1];
      String hour = time.split(':')[0];
      String min = time.split(':')[1];
      map['deadline'] = '${date}T$hour:$min';
    } else {
      map['deadline'] = null;
    }

    return map;
  }
}
