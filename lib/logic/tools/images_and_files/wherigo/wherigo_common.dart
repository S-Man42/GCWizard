String getLUAName(String line) {
  String result = '';
  int i = 0;
  while (line[i] != ' ') {
    result = result + line[i];
    i++;
  }
}

String getLineData(String line, LUAname, type){
  return line.replaceAll(LUAname + '.' + type + ' = ', '').replaceAll('""', '""');
}

String getStructData(String line, type){
  return line.trimLeft().replaceAll(type + ' = ', '').replaceAll('""', '""');
}

