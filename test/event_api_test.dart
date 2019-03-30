import 'package:fyvent/models/event.dart';
import 'package:fyvent/utils/api/event_api.dart';

import 'package:test/test.dart';

void main()
{
    test('test searchEvent(String str)', () async {

        List<Event> events = await searchEvents('a');

        expect(events.length > 0, isTrue);
    });
}