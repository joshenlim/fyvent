import 'event_manager_test.dart';
import 'package:test/test.dart';

import 'white_box_list.dart';
import 'white_box_test_package.dart';
void main(){

    parseDateTimeRange_test p = parseDateTimeRange_test();
    test("Testing parsedateTimeRange - parameters '2019-04-04 16:30:00', '2019-04-04 20:30:00'", (){
      parseDatetimeRange("2019-04-04 16:30:00","2019-04-04 20:30:00");
      for(int i=0; i< runtimePath1.length; i++){
        expect(runtimePath1[i], p.getListi()[i]);
        if(runtimePath1[i] != p.getListi()[i] ){
          break;
        }
      }
      runtimePath1.clear();
      runtimePath2.clear();
    });

    
    test("Testing parsedateTimeRange - parameters '2019-04-04 16:00:00','2019-04-09 16:30:00'",(){
      parseDatetimeRange("2019-04-04 16:30:00","2019-04-09 16:30:00");
      for(int i=0; i< runtimePath1.length; i++){
        expect(runtimePath1[i], p.getListii()[i]);
        if(runtimePath1[i] != p.getListii()[i] ){
          break;
        }
      }
      runtimePath1.clear();
      runtimePath2.clear();
    });

    parseTime_test q = parseTime_test();

    test("Testing parseTime - parameters 10,'00'",(){
      parseTime(10,"00");
      for(int i=0; i< runtimePath2.length; i++){
        expect(runtimePath2[i], q.getListi()[i]);
        if(runtimePath2[i] != q.getListi()[i] ){
          break;
        }
      }
      runtimePath2.clear();

    });
    test("Testing parseTime - parameters 13, '00'",() {
      parseTime(13,"00");
      for(int i=0; i< runtimePath2.length; i++){
        expect(runtimePath2[i], q.getListii()[i]);
        if(runtimePath2[i] != q.getListii()[i] ){
          break;
        }
      }
      runtimePath2.clear();
    });

}


