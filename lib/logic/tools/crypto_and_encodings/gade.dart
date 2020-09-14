String buildGade(String input){
  var outputList = new List<String>();
  String output = '';

  outputList = input.split(RegExp(r'[^0123456789]'));
  outputList.sort();

  for (int index = 0; index < outputList.length; index++) {
    output = output + String.fromCharCode(index + 97) + ' = ' + outputList[index] + '\n';
  }
  return output;
}