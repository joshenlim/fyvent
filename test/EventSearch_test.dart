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
    // check that widgets required for EventSearch will perform actions correctly
    group('widget tests', () {
        testWidgets('check required widgets exist', (WidgetTester tester) async {

            TestEventSearch eventSearchDelegate = new TestEventSearch();

            await tester.pumpWidget(new MaterialApp(
                home: TestHomePage(eventSearchDelegate)
                ));

            // check AppBar exists
            expect(find.byType(AppBar), findsOneWidget);

            // check search button exists
            expect(find.widgetWithIcon(IconButton, Icons.search), findsOneWidget);

            // check that no event is found when no query is typed in yet
            expect(find.text('No event found'), findsOneWidget);
        });

        testWidgets('check tapping search button works', (WidgetTester tester) async {

            TestEventSearch eventSearchDelegate = new TestEventSearch();

            await tester.pumpWidget(new MaterialApp(
                home: TestHomePage(eventSearchDelegate)
                ));

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

            await tester.pumpWidget(new MaterialApp(
                home: TestHomePage(eventSearchDelegate)
                ));

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
    });

    // check that input entered will indeed be used for queries
    group('check if text input will be converted to query', () {

        // test for valid equivalence class (1 character)
        testWidgets('check if query contains "a"',  (WidgetTester tester) async {

            TestEventSearch eventSearchDelegate = new TestEventSearch();

            await tester.pumpWidget(new MaterialApp(
                home: TestHomePage(eventSearchDelegate)
                ));

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

            // test.expect(eventSearchDelegate._eventList.length > 0, isTrue);

            // This test fails here because flutter_test uses mock http requests
            // in place of the actual http request.

            // Have to check if search result matches query
            // using test.test() instead of testWidget.
            // refer to test in event_api_test
        });

        // test for valid equivalence class (1 word)
        testWidgets('check if query contains "student"', (WidgetTester tester) async {

            TestEventSearch eventSearchDelegate = new TestEventSearch();

            await tester.pumpWidget(new MaterialApp(
                home: TestHomePage(eventSearchDelegate)
                ));

            // tap on the search button (proved to exist based on previous test)
            await tester.tap(find.widgetWithIcon(IconButton, Icons.search));
            await tester.pumpAndSettle();

            // search button has been tapped

            // type a query into the textfield (proved to exist based on previous test)
            await tester.enterText(find.byType(TextField), 'student');
            await tester.pumpAndSettle(new Duration(seconds: 10));

            // check that query matches whatever is entered into textfield
            expect(eventSearchDelegate.query, 'student');

            // refer to test in event_api_test
        });

        // test for invalid equivalence class (1 long string)
        // unlikely that event name or description would match this exact string
        testWidgets('check if query contains '
                                    '"The quick brown fox jumps over the lazy dog"',
                                        (WidgetTester tester) async {

            TestEventSearch eventSearchDelegate = new TestEventSearch();

            await tester.pumpWidget(new MaterialApp(
                home: TestHomePage(eventSearchDelegate)
                ));

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

            // refer to test in event_api_test
        });

        // test for invalid equivalence class (empty query)
        testWidgets('check if query contains ""', (WidgetTester tester) async {

            TestEventSearch eventSearchDelegate = new TestEventSearch();

            await tester.pumpWidget(new MaterialApp(
                home: TestHomePage(eventSearchDelegate)
                ));

            // tap on the search button (proved to exist based on previous test)
            await tester.tap(find.widgetWithIcon(IconButton, Icons.search));
            await tester.pumpAndSettle();

            // search button has been tapped

            // type a query into the textfield (proved to exist based on previous test)
            await tester.enterText(find.byType(TextField), '');
            await tester.pumpAndSettle(new Duration(seconds: 10));

            // check that query matches whatever is entered into textfield
            expect(eventSearchDelegate.query, '');

            // refer to test in event_api_test
        });
    });

    // check that results of api calls and whatever backend logic will be reflected on frontend
    group('check if events returned will be displayed', () {
        testWidgets('check that events can be displayed as ListView', (WidgetTester tester) async {
            TestEventSearch eventSearchDelegate = new TestEventSearch();

            List<Event> milestones = [
                Event(
                    name: 'birthday',
                    category: 'Test',
                    imgUrl: 'https://tineye.com/images/widgets/mona.jpg'),
                Event(
                    name: 'graduation',
                    category: 'Test',
                    imgUrl: 'https://tineye.com/images/widgets/mona.jpg'),
                Event(
                    name: 'marriage',
                    category: 'Test',
                    imgUrl: 'https://tineye.com/images/widgets/mona.jpg'),
                Event(
                    name: 'promotion',
                    category: 'Test',
                    imgUrl: 'https://tineye.com/images/widgets/mona.jpg'),
                Event(
                    name: 'funeral',
                    category: 'Test',
                    imgUrl: 'https://tineye.com/images/widgets/mona.jpg'),
            ];

            var output = eventSearchDelegate.buildEventSuggestions(milestones);

            // events will be displayed as ListView
            expect(output is ListView, isTrue);

            //await tester.pumpWidget(new MaterialApp(
            //    home: TestDisplayEvents(output),
            //));

            //expect(find.byType(ListView), findsWidgets);
//            expect(find.byType(EventCard), findsNWidgets(5));
        });
    });
}

/// TestDisplayEvents serve as the frontend widget for displaying output
class TestDisplayEvents extends StatelessWidget {

    final ListView eventListView;

    TestDisplayEvents(this.eventListView);

    @override
    Widget build(BuildContext context) {

        return eventListView;
    }
}

/// TestHomePage serves as the frontend widget for entering input
class TestHomePage extends StatelessWidget {

    final TestEventSearch eventSearchDelegate;

    TestHomePage(this.eventSearchDelegate);

    @override
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