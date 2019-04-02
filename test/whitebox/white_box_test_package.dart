import 'package:test/test.dart';

class parseDateTimeRange_test{
  List<int> i = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25];
  List<int> ii = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,26,27,28,29,30,31,32,33];

  List<int> getListi(){
    return i;
  }

  List<int> getListii(){
    return ii;
  }

}

class parseTime_test{
  List<int> i =[1,2,5];
  List<int> ii =[1,2,3,4,5];
  
  List<int> getListi(){
    return i;
  }

  List<int> getListii(){
    return ii;
  }
}

class Counter{
  int i = 0;
  List testflow;

  Counter(list){
    testflow = list;
  }
  int add(){
    i = i+1;
    return i;
  }
}

void comparator(count,line){
  expect(count, line);
  print("line" + line.toString());
}