import 'package:fyvent/components/EventSearch.dart';
import 'package:fyvent/components/EventCard.dart';
import 'package:fyvent/models/event.dart';
import 'package:fyvent/utils/api_facade.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

/// control class that is being tested: EventSearch
/// method used: black-box testing
/// 
/// reference
/// https://github.com/flutter/flutter/blob/master/packages/flutter/test/material/search_test.dart
///
/// main() runs the tests
void main()
{
    group('UI tests', () {
        testWidgets('check required widgets exist', (WidgetTester tester) async {

            TestEventSearch eventSearchDelegate = new TestEventSearch();

            await tester.pumpWidget(new MaterialApp(home: TestHomePage(eventSearchDelegate)));

            // check AppBar exists
            expect(find.byType(AppBar), findsOneWidget);

            // check search button exists
            expect(find.widgetWithIcon(IconButton, Icons.search), findsOneWidget);

            // check that no event is found when no query is typed in yet
            expect(find.text('No event found'), findsOneWidget);

        });

        testWidgets('check tapping search button works', (WidgetTester tester) async {

            TestEventSearch eventSearchDelegate = new TestEventSearch();

            await tester.pumpWidget(new MaterialApp(home: TestHomePage(eventSearchDelegate)));

            // tap on the search button (proved to exist based on previous test)
            await tester.tap(find.widgetWithIcon(IconButton, Icons.search));
            await tester.pumpAndSettle();

            // search button has been tapped

            // check search button does not exist
            expect(find.widgetWithIcon(IconButton, Icons.search), findsNothing);

            // check filter event button button exists
            expect(find.widgetWithIcon(IconButton, Icons.filter_list), findsOneWidget);

            // check textfield for entering query exists
            expect(find.byType(TextField), findsOneWidget);
        });

        testWidgets('check querying works', (WidgetTester tester) async {

            TestEventSearch eventSearchDelegate = new TestEventSearch();

            await tester.pumpWidget(new MaterialApp(home: TestHomePage(eventSearchDelegate)));

            // tap on the search button (proved to exist based on previous test)
            await tester.tap(find.widgetWithIcon(IconButton, Icons.search));
            await tester.pumpAndSettle();

            // search button has been tapped

            // type a query into the textfield (proved to exist based on previous test)
            await tester.enterText(find.byType(TextField), 'Test');
            await tester.pump();

            // check that query matches whatever is entered into textfield
            expect(eventSearchDelegate.query, 'Test');
        });

        test('check that events can be displayed', () async {
            TestEventSearch eventSearchDelegate = new TestEventSearch();

            List<Event> milestones = [
                Event(name: 'birthday'),
                Event(name: 'graduation'),
                Event(name: 'marriage'),
                Event(name: 'promotion'),
                Event(name: 'funeral'),
            ];

            var output = eventSearchDelegate.buildEventSuggestions(milestones);

            // events will be displayed as ListView
            expect(output is ListView, isTrue);
        });
    });

    group('check querying return correct events', () {

        // start of test of valid equivalence class (1 character)
        testWidgets('check if query contains "a"', (WidgetTester tester) async {

            TestEventSearch eventSearchDelegate = new TestEventSearch();

            await tester.pumpWidget(new MaterialApp(home: TestHomePage(eventSearchDelegate)));

            // tap on the search button (proved to exist based on previous test)
            await tester.tap(find.widgetWithIcon(IconButton, Icons.search));
            await tester.pumpAndSettle();

            // search button has been tapped

            // type a query into the textfield (proved to exist based on previous test)
            await tester.enterText(find.byType(TextField), 'a');
            await tester.pumpAndSettle(new Duration(seconds: 10));

            // check that query matches whatever is entered into textfield
            expect(eventSearchDelegate.query, 'a');

            // works up to here

            // This test fails here because flutter_test uses mock http requests
            // in place of the actual http request.
            // Have to check if search result matches query
            // using test() instead of testWidget.
            // expect(eventSearchDelegate._eventList.length > 0, isTrue);
        });

        test('check if result contains query "a"', () async {
            List<Event> events = await searchEvents('a');
            
            for(Event event in events) {
                expect(event.name.contains('a') || event.description.contains('a'), isTrue);
            }
        });

        // end of test of valid equivalence class (1 character)

        // start of test of valid equivalence class (1 word)
        testWidgets('check if query contains "student"', (WidgetTester tester) async {

            TestEventSearch eventSearchDelegate = new TestEventSearch();

            await tester.pumpWidget(new MaterialApp(home: TestHomePage(eventSearchDelegate)));

            // tap on the search button (proved to exist based on previous test)
            await tester.tap(find.widgetWithIcon(IconButton, Icons.search));
            await tester.pumpAndSettle();

            // search button has been tapped

            // type a query into the textfield (proved to exist based on previous test)
            await tester.enterText(find.byType(TextField), 'student');
            await tester.pumpAndSettle(new Duration(seconds: 10));

            // check that query matches whatever is entered into textfield
            expect(eventSearchDelegate.query, 'student');

            // refer to test below to check that result contains query
        });

        test('check if result contains query "student"', () async {
            List<Event> events = await searchEvents('student');

            for(Event event in events) {
                expect(event.name.contains('student') ||
                       event.description.contains('student'), isTrue);
            }
        });

        // end of test of valid equivalence class (1 word)

        // start of test of invalid equivalence class (1 long string)
        // unlikely that event name or description would match this exact string
        testWidgets('check if query contains "The quick brown fox jumps over the lazy dog"',
                            (WidgetTester tester) async {

            TestEventSearch eventSearchDelegate = new TestEventSearch();

            await tester.pumpWidget(new MaterialApp(home: TestHomePage(eventSearchDelegate)));

            // tap on the search button (proved to exist based on previous test)
            await tester.tap(find.widgetWithIcon(IconButton, Icons.search));
            await tester.pumpAndSettle();

            // search button has been tapped

            // type a query into the textfield (proved to exist based on previous test)
            await tester.enterText(find.byType(TextField),
                                       'The quick brown fox jumps over the lazy dog');
            await tester.pumpAndSettle(new Duration(seconds: 10));

            // check that query matches whatever is entered into textfield
            expect(eventSearchDelegate.query, 'The quick brown fox jumps over the lazy dog');

            // refer to test below to check that result does not contain query
        });

        test('check if there is no result for query "The quick brown fox jumps over the lazy dog"',
                     () async {
            List<Event> events = await searchEvents('The quick brown fox jumps over the lazy dog');

            expect(events.length, 0);
        });

        // end of test of invalid equivalence class (1 long string)

        // start of test of invalid equivalence class (empty query)
        testWidgets('check if query contains ""', (WidgetTester tester) async {

            TestEventSearch eventSearchDelegate = new TestEventSearch();

            await tester.pumpWidget(new MaterialApp(home: TestHomePage(eventSearchDelegate)));

            // tap on the search button (proved to exist based on previous test)
            await tester.tap(find.widgetWithIcon(IconButton, Icons.search));
            await tester.pumpAndSettle();

            // search button has been tapped

            // type a query into the textfield (proved to exist based on previous test)
            await tester.enterText(find.byType(TextField), '');
            await tester.pumpAndSettle(new Duration(seconds: 10));

            // check that query matches whatever is entered into textfield
            expect(eventSearchDelegate.query, '');

            // refer to test below to check that result contains query
        });

        test('check if there is no result for ""', () async {
            List<Event> events = await searchEvents('');

            expect(events.length, 0);
        });

        // end of test of invalid equivalence class (empty query)
    });

}

/// TestHomePage serves as the displaying widget
class TestHomePage extends StatelessWidget {

    final TestEventSearch eventSearchDelegate;

    TestHomePage(this.eventSearchDelegate);

    //@override
    Widget build(BuildContext context) {

        var width = MediaQuery.of(context).size.width;

        Widget _appBar = new AppBar(
            title: new Text('Search Test'),
            actions: [
                new IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () =>
                        showSearch(
                            context: context,
                            delegate: eventSearchDelegate,
                            )
                    ),
            ],
            );

        Widget body = new Container(
            width: width,
            child: new RefreshIndicator(
                onRefresh: eventSearchDelegate.refreshList,
                child: eventSearchDelegate._eventList.length != 0 ? new ListView.builder(
                    itemCount: eventSearchDelegate._eventList.length + 2,
                    itemBuilder: (context, index) {
                            return EventCard(event: eventSearchDelegate._eventList[index - 2]);
                    },
                    ) : new Center(
                    child: Text('No event found'),
                        ),
                    )
            );

        return new Scaffold(
            appBar: _appBar,
            body: Stack(
                children: <Widget>[
                    body,
                ],
                ),
            );
    }
}

/// TestEventSearch wraps EventSearch within itself, for testing of EventSearch
/// note that TestEventSearch did not override any methods in EventSearch
class TestEventSearch extends EventSearch {

    List<Event> _eventList = List<Event>();

    Future<void> refreshList() async {

        _eventList = await getEvents(20);

        for(Event event in _eventList)
            print(event.name);
    }
}