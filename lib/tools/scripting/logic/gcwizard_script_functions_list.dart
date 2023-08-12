part of 'package:gc_wizard/tools/scripting/logic/gcwizard_script.dart';

class _GCWList {
  late List<Object> _contents;

  _GCWList() {
    _contents = <Object>[];
  }

  int length() {
    return _contents.length;
  }

  List<Object> get(){
    return _contents;
  }

  void add(Object? value ) {
    if (value != null) _contents.add(value);
  }

  void addall(_GCWList? list) {
    if (list != null) _contents.addAll(list._contents);
  }

  void clear() {
    _contents = [];
  }

  void shuffle() {
    _contents.shuffle();
  }

  void sort(){
    _contents.sort();
  }

  void insert(int index, Object? value){
    if (value != null) _contents.insert(index, value);
  }

  void remove(int index,){
    _contents.remove(index);
  }

}



_GCWList _listclear() {
  return _GCWList();

}_GCWList _listnew() {
  return _GCWList();
}

_GCWList _listadd(_GCWList? list, Object? value){
  print('inside listadd');
  print(list.runtimeType.toString()+' '+value.runtimeType.toString());
  if (list == null) {
    return _GCWList();
  } else {
    if (_isNotList(list)) {
      _handleError(_INVALIDTYPECAST);
      return _GCWList();
    }
    if (value != null) {
      list.add(value);
    }
    return list;
  }
}

_GCWList _listsort(_GCWList? list){
  if (list == null) {
    return _GCWList();
  } else {
    return list.sort() as _GCWList;
  }
}

_GCWList _listshuffle(_GCWList? list){
  if (list == null) {
    return _GCWList();
  } else {
    return list.shuffle() as _GCWList;
  }
}

String _listtostring(_GCWList? list){
  if (list == null) {
    return '';
  } else {
    return list.toString();
  }
}

_GCWList _listaddall(_GCWList? listto, _GCWList? listfrom){
  if (listto == null) {
    return _GCWList();
  } else  {
    return listto.addall(listfrom) as _GCWList;
  }
}

_GCWList _listinsert(_GCWList? list, int index, Object? value){
  if (list == null) {
    return _GCWList();
  } else {
    return list.insert(index, value) as _GCWList;
  }
}

_GCWList _listremove(_GCWList? list, int index){
  if (list == null) {
    return _GCWList();
  } else {
    return list.remove(index) as _GCWList;
  }
}

int _listlength(_GCWList? list){
  if (list == null) {
    return 0;
  } else {
    return list.length();
  }
}

bool _listisempty(_GCWList? list){
  return (_listlength(list) == 0);
}

bool _listisnotempty(_GCWList? list){
  return (_listlength(list) != 0);
}
