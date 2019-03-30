import 'package:fyvent/components/EventSearch.dart';
import 'package:fyvent/components/EventCard.dart';
//import 'package:fyvent/screens/upcoming_events_screen.dart';
import 'package:fyvent/models/event.dart';
import 'package:fyvent/utils/api_facade.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

/// reference
/// package:fyvent/screens/upcoming_events_screen.dart
/// https://github.com/flutter/flutter/blob/master/packages/flutter/test/material/search_test.dart
void main()
{
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

    testWidgets('check querying return correct events',
                        (WidgetTester tester) async {

        await tester.runAsync(() async {

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
            print('query: ' + eventSearchDelegate.query);

            // works up to here

            print('About to get events...');
            await eventSearchDelegate.refreshList(); // this line does not make it work either
            print('updated eventSearchDelegate list of events');

            //expect(eventSearchDelegate._eventList.length > 0, isTrue);
            List<Event> eventList = await searchEvents('a');
            // expect(eventList.length > 0, isTrue);
            if (eventList.length == 0) {
                print('search event failed');
            }

            expect(eventList.length > 0, isTrue);

            // expect(find.byType(RefreshIndicator), findsOneWidget);
        });

    });
}

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

class TestEventSearch extends EventSearch {

    List<Event> _eventList = List<Event>();

    Future<void> refreshList() async{
        print('Getting events...');
//        _eventList = await getEvents(20);
        getEvents(20).then((response) {
            _eventList = response;
        });
        print('Updated event list');

        for(Event event in _eventList)
            print(event.name);
    }
}