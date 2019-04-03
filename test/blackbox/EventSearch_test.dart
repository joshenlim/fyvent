import 'package:fyvent/components/EventSearch.dart';
import 'package:fyvent/components/DropdownOption.dart';
import 'package:fyvent/components/SideMenu.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// control class that is being tested: EventSearch
/// method used: black-box testing
///
/// reference
/// https://github.com/flutter/flutter/blob/master/packages/flutter/test/material/search_test.dart
///
/// main() runs the tests
void main()
{
    // Fyvent must allow the user to filter the events by his/her preferences.

    testWidgets('test case: display IconButton (with search icon)', (WidgetTester tester) async {

        TestEventSearch testEventSearch = new TestEventSearch(
            categories: [{
                'id': '0',
                'name': 'All Events',
                'type': "category",
            },]);

        // entry to ‘event search screen’
        await tester.pumpWidget(new MaterialApp(
            home: TestEventSearchScreen(testEventSearch: testEventSearch,)
            ));

        expect(find.widgetWithIcon(IconButton, Icons.search), findsOneWidget);
        expect(find.widgetWithIcon(IconButton, Icons.error), findsNothing);
    });

    // Fyvent must allow the user to filter events by keywords
    // formed by entering text characters into a textfield

    testWidgets('test case: display Textfield', (WidgetTester tester) async {

        TestEventSearch testEventSearch = new TestEventSearch(
            categories: [{
                'id': '0',
                'name': 'All Events',
                'type': "category",
            },]);

        // entry to ‘event search screen’
        await tester.pumpWidget(new MaterialApp(
            home: TestEventSearchScreen(testEventSearch: testEventSearch,)
            ));

        // tap IconButton (with search icon)
        await tester.tap(find.widgetWithIcon(IconButton, Icons.search));
        await tester.pumpAndSettle();

        // test case: display Textfield
        expect(find.byType(TextField), findsOneWidget);
        expect(find.byType(RaisedButton), findsNothing);
    });

    testWidgets('test case: text entered into Textfield is stored as a SearchDelegate query',
                        (WidgetTester tester) async {

        TestEventSearch testEventSearch = new TestEventSearch(
            categories: [{
                'id': '0',
                'name': 'All Events',
                'type': "category",
            },]);

        // entry to ‘event search screen’
        await tester.pumpWidget(new MaterialApp(
            home: TestEventSearchScreen(testEventSearch: testEventSearch)
            ));

        // tap IconButton (with search icon)
        await tester.tap(find.widgetWithIcon(IconButton, Icons.search));
        await tester.pumpAndSettle();

        // entering text (e.g. test) into TextField
        await tester.enterText(find.byType(TextField), 'test');
        await tester.pump();

        expect(testEventSearch.query == 'test', isTrue);
        expect(testEventSearch.query == '', isFalse);
        expect(testEventSearch.query == 'bug in textfield', isFalse);
    });

    // Fyvent must allow the user to filter events by the mutually exclusive event categories...

    testWidgets('test case: display IconButton (with filter list icon)',
    (WidgetTester tester) async {
        TestEventSearch testEventSearch = new TestEventSearch(
            categories: [{
                'id': '0',
                'name': 'All Events',
                'type': "category",
            },
            ]);

        // entry to ‘event search screen’
        await tester.pumpWidget(new MaterialApp(
            home: TestEventSearchScreen(testEventSearch: testEventSearch)
            ));

        // tap IconButton (with search icon)
        await tester.tap(find.widgetWithIcon(IconButton, Icons.search));
        await tester.pumpAndSettle();

        expect(find.widgetWithIcon(IconButton, Icons.filter_list), findsOneWidget);
        expect(find.widgetWithIcon(IconButton, Icons.view_list), findsNothing);
    });

    testWidgets('test case: display DropDownOption', (WidgetTester tester) async {

        TestEventSearch testEventSearch = new TestEventSearch(
            categories: [{
                'id': '0',
                'name': 'All Events',
                'type': "category",
            },]);

        // entry to ‘event search screen’
        await tester.pumpWidget(new MaterialApp(
            home: TestEventSearchScreen(testEventSearch: testEventSearch)
            ));

        // tap IconButton (with search icon)
        await tester.tap(find.widgetWithIcon(IconButton, Icons.search));
        await tester.pumpAndSettle();

        expect(find.byType(DropdownOption), findsOneWidget);
        expect(find.byType(SideMenu), findsNothing);
    });

    testWidgets('test case: display "Filter events by:"', (WidgetTester tester) async {

        TestEventSearch testEventSearch = new TestEventSearch(
            categories: [{
                'id': '0',
                'name': 'All Events',
                'type': "category",
            },]);

        // entry to ‘event search screen’
        await tester.pumpWidget(new MaterialApp(
            home: TestEventSearchScreen(testEventSearch: testEventSearch)
            ));

        // tap IconButton (with search icon)
        await tester.tap(find.widgetWithIcon(IconButton, Icons.search));
        await tester.pumpAndSettle();

        expect(find.text('Filter events by:'), findsOneWidget);
        expect(find.text('Favourite events'), findsNothing);
    });

    testWidgets('test case: display DropDownButton', (WidgetTester tester) async {

        TestEventSearch testEventSearch = new TestEventSearch(
            categories: [{
                'id': '0',
                'name': 'All Events',
                'type': "category",
            },]);

        // entry to ‘event search screen’
        await tester.pumpWidget(new MaterialApp(
            home: TestEventSearchScreen(testEventSearch: testEventSearch)
            ));

        // tap IconButton (with search icon)
        await tester.tap(find.widgetWithIcon(IconButton, Icons.search));
        await tester.pumpAndSettle();

        expect(find.byType(DropdownButton), findsOneWidget);
        expect(find.byType(SimpleDialog), findsNothing);
    });

    testWidgets('test case: display DropDownButton', (WidgetTester tester) async {

        TestEventSearch testEventSearch = new TestEventSearch(
            categories: [{
                'id': '0',
                'name': 'All Events',
                'type': "category",
            },]);

        // entry to ‘event search screen’
        await tester.pumpWidget(new MaterialApp(
            home: TestEventSearchScreen(testEventSearch: testEventSearch)
            ));

        // tap IconButton (with search icon)
        await tester.tap(find.widgetWithIcon(IconButton, Icons.search));
        await tester.pumpAndSettle();

        expect(find.byType(DropdownButton), findsOneWidget);
        expect(find.byType(SimpleDialog), findsNothing);
    });

    testWidgets('test case: display "Category"', (WidgetTester tester) async {

        TestEventSearch testEventSearch = new TestEventSearch(
            categories: [{
                'id': '0',
                'name': 'All Events',
                'type': "category",
            },]);

        // entry to ‘event search screen’
        await tester.pumpWidget(new MaterialApp(
            home: TestEventSearchScreen(testEventSearch: testEventSearch)
            ));

        // tap IconButton (with search icon)
        await tester.tap(find.widgetWithIcon(IconButton, Icons.search));
        await tester.pumpAndSettle();

        expect(find.text('Category'), findsOneWidget);
        expect(find.text('Age'), findsNothing);
    });

    // Fyvent must allow the user to filter events by
    // the mutually exclusive event categories listed below:'
    // All Events
    // Concerts & Gig Guide
    // Performing Arts
    // Theater
    // Sports
    // Festivals & Lifestyle
    // Ballet
    // Exhibitions
    // Business & Education
    // Musicals

    testWidgets('test case: display the right number of DropdownMenuItem',
                        (WidgetTester tester) async {

        // categories for testing
        final List categories = [
            {
                'id': '0',
                'name': 'All Events',
                'type': "category",
            },
            {
                'id': '1',
                'name': 'Concerts & Gig Guide',
                'type': "category",
            },
            {
                'id': '2',
                'name': 'Performing Arts',
                'type': "category",
            },
            {
                'id': '3',
                'name': 'Theater',
                'type': "category",
            },
            {
                'id': '4',
                'name': 'Sports',
                'type': "category",
            },
            {
                'id': '5',
                'name': 'Festivals & Lifestyle',
                'type': "category",
            },
            {
                'id': '6',
                'name': 'Ballet',
                'type': "category",
            },
            {
                'id': '7',
                'name': 'Exhibitions',
                'type': "category",
            },
            {
                'id': '8',
                'name': 'Business & Education',
                'type': "category",
            },
            {
                'id': '9',
                'name': 'Musicals',
                'type': "category",
            },
        ];

        TestEventSearch testEventSearch = new TestEventSearch(categories: categories);

        // entry to ‘event search screen’
        await tester.pumpWidget(new MaterialApp(
            home: TestEventSearchScreen(testEventSearch: testEventSearch)
            ));

        // tap IconButton (with search icon)
        await tester.tap(find.widgetWithIcon(IconButton, Icons.search));
        await tester.pumpAndSettle();

        // tap on DowndownButton
        await tester.tap(find.byType(DropdownButton));
        await tester.pump();

        expect(find.byType(DropdownMenuItem), findsNWidgets(20));

        // invalid equivalence class; will fail when uncommented
//        expect(find.byType(DropdownMenuItem), findsNWidgets(19));
        // invalid equivalence class; will fail when uncommented
//        expect(find.byType(DropdownMenuItem), findsNWidgets(21));

    });

    testWidgets('test case: display all event categories', (WidgetTester tester) async {

        // categories for testing
        final List categories = [
            {
                'id': '0',
                'name': 'All Events',
                'type': "category",
            },
            {
                'id': '1',
                'name': 'Concerts & Gig Guide',
                'type': "category",
            },
            {
                'id': '2',
                'name': 'Performing Arts',
                'type': "category",
            },
            {
                'id': '3',
                'name': 'Theater',
                'type': "category",
            },
            {
                'id': '4',
                'name': 'Sports',
                'type': "category",
            },
            {
                'id': '5',
                'name': 'Festivals & Lifestyle',
                'type': "category",
            },
            {
                'id': '6',
                'name': 'Ballet',
                'type': "category",
            },
            {
                'id': '7',
                'name': 'Exhibitions',
                'type': "category",
            },
            {
                'id': '8',
                'name': 'Business & Education',
                'type': "category",
            },
            {
                'id': '9',
                'name': 'Musicals',
                'type': "category",
            },
        ];

        TestEventSearch testEventSearch = new TestEventSearch(categories: categories);

        // entry to ‘event search screen’
        await tester.pumpWidget(new MaterialApp(
            home: TestEventSearchScreen(testEventSearch: testEventSearch)
            ));

        // tap IconButton (with search icon)
        await tester.tap(find.widgetWithIcon(IconButton, Icons.search));
        await tester.pumpAndSettle();

        // tap on DowndownButton
        await tester.tap(find.byType(DropdownButton));
        await tester.pump();

        expect(find.widgetWithText(DropdownMenuItem,'All Events'), findsNWidgets(2));
        expect(find.widgetWithText(DropdownMenuItem,'Concerts & Gig Guide'), findsNWidgets(2));
        expect(find.widgetWithText(DropdownMenuItem,'Performing Arts'), findsNWidgets(2));
        expect(find.widgetWithText(DropdownMenuItem,'Theater'), findsNWidgets(2));
        expect(find.widgetWithText(DropdownMenuItem,'Sports'), findsNWidgets(2));
        expect(find.widgetWithText(DropdownMenuItem,'Festivals & Lifestyle'), findsNWidgets(2));
        expect(find.widgetWithText(DropdownMenuItem,'Ballet'), findsNWidgets(2));
        expect(find.widgetWithText(DropdownMenuItem,'Exhibitions'), findsNWidgets(2));
        expect(find.widgetWithText(DropdownMenuItem,'Business & Education'), findsNWidgets(2));
        expect(find.widgetWithText(DropdownMenuItem,'Musicals'), findsNWidgets(2));
        expect(find.widgetWithText(DropdownMenuItem,'Comics Convention'), findsNothing);
    });
}

/// display screen for TestEventSearch
class TestEventSearchScreen extends StatelessWidget {

    final TestEventSearch testEventSearch;

    TestEventSearchScreen({this.testEventSearch});

    void updateSelected(Map option) {

    }

    @override
    Widget build(BuildContext context) {
        Widget _appBar = new AppBar(
            title: Text('test EventSearch'),
            actions: [
                new IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                        showSearch(
                            context: context,
                            delegate: testEventSearch
                            );
                    },
                    ),
            ]);

        Widget _body = new Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                new Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 15.0),
                    child: new Text("Filter events by:"),
                    ),
                new ListTile(
                    leading: new Icon(Icons.category),
                    title: new Text('Category',),
                    ),
                new Padding(padding: const EdgeInsets.only(bottom: 10.0)),
            ],
            );

        return new Scaffold(
            appBar: _appBar,
            body: _body,
            );
    }


}

class TestEventSearch extends EventSearch {
    final List categories;

    TestEventSearch({this.categories}): super(categories: categories);

    void _updateQuery(Map activeValue) {
//        if (activeValue.isNotEmpty) {
//            if (activeValue["type"] == "category") selectedCategory = activeValue;
//        }
    }

    @override
    Widget buildLeading(BuildContext context) {
        return IconButton(
            icon: Icon(Icons.clear), // placeholder
            onPressed: () {},
            );
    }

    @override
    Widget buildResults(BuildContext context) {
        return new Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                new Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 15.0),
                    child: new Text("Filter events by:"),
                    ),
                new ListTile(
                    leading: new Icon(Icons.category),
                    title: new Text('Category',),
                    trailing: DropdownOption(categories, categories[0], _updateQuery)
                    ),
                new Padding(padding: const EdgeInsets.only(bottom: 10.0)
                ),
            ],
            );

    }
}