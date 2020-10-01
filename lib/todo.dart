import 'package:flutter_app_todo/db/db_provider.dart';

class Todo {
  int _id;
  String _body;
  bool _isComplete = false;

  Todo();

  int get id => this._id;

  bool get isComplete => this._isComplete;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();

    map[DbProvider.bodyColumn] = _body;
    map[DbProvider.isComplete] = _isComplete;

    return map;
  }

  Todo.fromMap(Map<String, dynamic> element) {
    _id = element[DbProvider.idColumn];
    _body = element[DbProvider.bodyColumn];
    _isComplete = element[DbProvider.isComplete] == 1;
  }
}
