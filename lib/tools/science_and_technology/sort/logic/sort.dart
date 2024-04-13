enum SortingMode {ASCENDING, DESCENDING}

List<T> _sortList<T>(List<T> list, SortingMode mode) {
  list.sort();

  if (mode == SortingMode.DESCENDING) {
    list = list.reversed.toList();
  }

  return list;
}

String sortTextASCII(String input, SortingMode mode) {
  var sort = input.split('').toList();
  return _sortList<String>(sort, mode).join();
}

List<T> sortBlocks<T>(List<T> input, SortingMode mode) {
  var sort = List<T>.from(input);
  return _sortList<T>(sort, mode);
}