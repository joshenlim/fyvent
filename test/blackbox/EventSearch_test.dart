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
    testWidgets('Fyvent must allow the user to filter the events by his/her preferences.',
                        (WidgetTester tester) async {

                        // entry to ‘event search screen’
                        await tester.pumpWidget(new MaterialApp(
                            home: TestEventSearchScreen()
                            ));

                        // test case: display IconButton (with search icon)
                        expect(find.widgetWithIcon(IconButton, Icons.search), findsOneWidget);
                        expect(find.widgetWithIcon(IconButton, Icons.error), findsNothing);

                        // tap IconButton (with search icon)
                        await tester.tap(find.widgetWithIcon(IconButton, Icons.search));
                        await tester.pumpAndSettle();

                        // test case: display IconButton (with filter list icon)
                        expect(find.widgetWithIcon(IconButton, Icons.filter_list), findsOneWidget);
                        expect(find.widgetWithIcon(IconButton, Icons.view_list), findsNothing);

                        // test case: display DropDownOption
                        expect(find.byType(DropdownOption), findsOneWidget);
                        expect(find.byType(SideMenu), findsNothing);

                        // test case: display “Filter events by:”
                        expect(find.text('Filter events by:'), findsOneWidget);
                        expect(find.text('Favourite events'), findsNothing);

                        // test case: display DropDownButton
                        expect(find.byType(DropdownButton), findsOneWidget);
                        expect(find.byType(SimpleDialog), findsNothing);

                        // test case: display “Category”
                        expect(find.text('Category'), findsOneWidget);
                        expect(find.text('Age'), findsNothing);

                        // tap on DowndownButton
                        await tester.tap(find.byType(DropdownButton));
                        await tester.pump();

                        // test case: display the right number of DropdownMenuItem
                        expect(find.byType(DropdownMenuItem), findsNWidgets(20));

                        // invalid equivalence class; will fail when uncommented
//                        expect(find.byType(DropdownMenuItem), findsNWidgets(19));
                        // invalid equivalence class; will fail when uncommented
//                        expect(find.byType(DropdownMenuItem), findsNWidgets(21));

                        // test case: display all event categories
                        expect(find.text('All Events'),
                                   findsNWidgets(2));
                        expect(find.widgetWithText(DropdownMenuItem,'Concerts & Gig Guide'),
                                   findsNWidgets(2));
                        expect(find.widgetWithText(DropdownMenuItem,'Performing Arts'),
                                   findsNWidgets(2));
                        expect(find.widgetWithText(DropdownMenuItem,'Theater'),
                                   findsNWidgets(2));
                        expect(find.widgetWithText(DropdownMenuItem,'Sports'),
                                   findsNWidgets(2));
                        expect(find.widgetWithText(DropdownMenuItem,'Festivals & Lifestyle'),
                                   findsNWidgets(2));
                        expect(find.widgetWithText(DropdownMenuItem,'Ballet'),
                                   findsNWidgets(2));
                        expect(find.widgetWithText(DropdownMenuItem,'Exhibitions'),
                                   findsNWidgets(2));
                        expect(find.widgetWithText(DropdownMenuItem,'Business & Education'),
                                   findsNWidgets(2));
                        expect(find.widgetWithText(DropdownMenuItem,'Musicals'),
                                   findsNWidgets(2));
                        expect(find.widgetWithText(DropdownMenuItem,'Comics Convention'),
                                   findsNothing);
                    });
}

/// display screen for TestEventSearch
class TestEventSearchScreen extends StatelessWidget {

    // categories for testing
    final List _categoriesList = [
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
                            delegate: TestEventSearch(categories: _categoriesList)
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