import 'package:fyvent/models/event.dart';
import 'package:fyvent/utils/api/event_api.dart';

import 'package:test/test.dart';

void main()
{
    // test for valid equivalence class (1 character)
//    test('check if result contains query "a"', () async {
//        List<Event> events = await searchEvents('a');
//
//        expect(events.isNotEmpty, isTrue);
//
//        for(Event event in events) {
//            print(event.name);
//            expect(event.name.contains('a') || event.description.contains('a'), isTrue);
//        }
//    });

    // test for valid equivalence class (1 word)
//    test('check if result contains query "student"', () async {
//
//        List<Event> events = await searchEvents('student');
//
//        expect(events.isNotEmpty, isTrue);
//
//        for(Event event in events) {
//            print('event name: ' + event.name + '\nevent desc: ' + event.description);
//            expect(event.name.contains('student') ||
//                        event.description.contains('student'), isTrue);
//        }
//    });

//    // test for invalid equivalence class (1 long string)
//    // unlikely that event name or description would match this exact string
//    test('check if there is no result for query "The quick brown fox jumps over the lazy dog"',
//                      () async {
//        List<Event> events = await searchEvents('The quick brown fox jumps over the lazy dog');
//        print(events);
//        expect(events.length, 0);
//    });
//
//    // test for invalid equivalence class (empty query)
//    test('check if there is no result for ""', () async {
//        List<Event> events = await searchEvents('');
//        print(events);
//        expect(events.length, 0);
//    });
}