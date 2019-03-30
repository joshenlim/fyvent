import 'package:fyvent/components/EventSearch.dart';
import 'package:fyvent/components/EventCard.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

/// reference
/// https://github.com/flutter/flutter/blob/master/packages/flutter/test/material/search_test.dart
void main()
{
    testWidgets('Requests suggestions', (WidgetTester tester) async {
        EventSearch delegate = new EventSearch();

        await tester.pumpWidget(TestHomePage(
            delegate: delegate,
            ));
        await tester.tap(find.byTooltip('Search'));
        await tester.pumpAndSettle();

        //expect(delegate.query, '');
        //expect(delegate.querysForSuggestions.last, '');
        //expect(delegate.querysForResults, hasLength(0));

        // Type W o w into search field
        //delegate.querysForSuggestions.clear();
//        await tester.enterText(find.byType(TextField), 'W');
//        await tester.pumpAndSettle();
//        expect(delegate.query, 'W');
//        await tester.enterText(find.byType(TextField), 'Wo');
//        await tester.pumpAndSettle();
//        expect(delegate.query, 'Wo');
        await tester.enterText(find.byType(TextField), 'Wow');
        await tester.pumpAndSettle();
        expect(delegate.query, 'Wow');

        //expect(delegate.querysForSuggestions, <String>['W', 'Wo', 'Wow']);
        //expect(delegate.querysForResults, hasLength(0));
    });

//    testWidgets('query in title or desc of every events', (WidgetTester tester) async {
//
//        EventSearch eventSearchDelegate = new EventSearch();
//
//        final List<String> selectedResults = <String>[];
//
//        await tester.pumpWidget(TestHomePage(
//            delegate: eventSearchDelegate,
//            results: selectedResults,
//            passInInitialQuery: true,
//            initialQuery: 'student',
//        ));
//
//        await tester.tap(find.byTooltip('Search'));
//        await tester.pumpAndSettle();
//
//        expect(find.byWidgetPredicate(
//                (Widget widget) => widget is EventCard,
//            description: 'event card with title or description containing the string "student"',
//                ), findsOneWidget);
//    });
}

class TestHomePage extends StatelessWidget {
    const TestHomePage({
                           this.results,
                           this.delegate,
                           this.passInInitialQuery = false,
                           this.initialQuery,
                       });

    final List<String> results;
    final SearchDelegate<String> delegate;
    final bool passInInitialQuery;
    final String initialQuery;

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            home: Builder(builder: (BuildContext context) {
                return Scaffold(
                    appBar: AppBar(
                        title: const Text('HomeTitle'),
                        actions: <Widget>[
                            IconButton(
                                tooltip: 'Search',
                                icon: const Icon(Icons.search),
                                onPressed: () async {
                                    String selectedResult;
                                    if (passInInitialQuery) {
                                        selectedResult = await showSearch<String>(
                                            context: context,
                                            delegate: delegate,
                                            query: initialQuery,
                                            );
                                    } else {
                                        selectedResult = await showSearch<String>(
                                            context: context,
                                            delegate: delegate,
                                            );
                                    }
                                    results?.add(selectedResult);
                                },
                                ),
                        ],
                        ),
                    body: const Text('HomeBody'),
                    );
            }),
            );
    }
}