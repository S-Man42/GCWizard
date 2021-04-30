List<int> buildDivisorList(int number){
  if (number == null)
    return [];
  List<int> divisorList = new List<int>();
  for (int i = 1; i < number ~/ 2 + 1; i++)
    if (number % i == 0) divisorList.add(i);
    return divisorList;
}