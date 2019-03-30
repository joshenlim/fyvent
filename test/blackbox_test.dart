import 'package:fyvent/components/EventSearch.dart';
import 'package:test/test.dart';

void main()
{
    EventSearch eventSearcher = new EventSearch();

    // start of tests of filtering by categories

    group('on filter by business & education', ()
    {
        test('valid equivalent class', ()
        {
            // temp method to represent filtering by 'Business & Education'
            // eventSearcher.constructQuery('Business & Education');
            eventSearcher.noSuchMethod(null);

            for(var event in eventSearcher.getSearchEvents)
            {
                expect(event.category, 'Business & Education');
            }
        });

        test('invalid equivalent class', ()
        {
            // temp method to represent incorrect construction of query
            // eventSearcher.constructQuery('Business & Educatiol');
            eventSearcher.noSuchMethod(null);

            for(var event in eventSearcher.getSearchEvents)
            {
                expect(event.category, 'Business & Education');
            }
        });
    });

    group('on filter by exhibitions', ()
    {
        test('valid equivalent class', ()
        {
            // temp method to represent filtering by 'Exhibitions'
            // eventSearcher.constructQuery('Exhibitions');
            eventSearcher.noSuchMethod(null);

            for(var event in eventSearcher.getSearchEvents)
            {
                expect(event.category, 'Exhibitions');
            }
        });

        test('invalid equivalent class', ()
        {
            // temp method to represent incorrect construction of query
            // eventSearcher.constructQuery('Exhibition');
            eventSearcher.noSuchMethod(null);

            for(var event in eventSearcher.getSearchEvents)
            {
                expect(event.category, 'Exhibitions');
            }
        });
    });

    group('on filter by performing arts', ()
    {
        test('valid equivalent class', ()
        {
            // temp method to represent filtering by 'Performing Arts'
            // eventSearcher.constructQuery('Performing Arts');
            eventSearcher.noSuchMethod(null);

            for(var event in eventSearcher.getSearchEvents)
            {
                expect(event.category, 'Performing Arts');
            }
        });

        test('invalid equivalent class', ()
        {
            // temp method to represent incorrect construction of query
            // eventSearcher.constructQuery('Performing Art1');
            eventSearcher.noSuchMethod(null);

            for(var event in eventSearcher.getSearchEvents)
            {
                expect(event.category, 'Performing Arts');
            }
        });
    });

    group('on filter by concerts & gig', ()
    {
        test('valid equivalent class', ()
        {
            // temp method to represent filtering by 'Concerts & Gig'
            // eventSearcher.constructQuery('Concerts & Gig');
            eventSearcher.noSuchMethod(null);

            for(var event in eventSearcher.getSearchEvents)
            {
                expect(event.category, 'Concerts & Gig');
            }
        });

        test('invalid equivalent class', ()
        {
            // temp method to represent incorrect construction of query
            // eventSearcher.constructQuery('Business & Education');
            eventSearcher.noSuchMethod(null);

            for(var event in eventSearcher.getSearchEvents)
            {
                expect(event.category, 'Concerts & Gig');
            }
        });
    });

    group('on filter by festivals & lifestyle', ()
    {
        test('valid equivalent class', ()
        {
            // temp method to represent filtering by 'Festivals & Lifestyle'
            // eventSearcher.constructQuery('Festivals & Lifestyle');
            eventSearcher.noSuchMethod(null);

            for(var event in eventSearcher.getSearchEvents)
            {
                expect(event.category, 'Festivals & Lifestyle');
            }
        });

        test('invalid equivalent class', ()
        {
            // temp method to represent incorrect construction of query
            // eventSearcher.constructQuery('Festival & Lifestyle');
            eventSearcher.noSuchMethod(null);

            for(var event in eventSearcher.getSearchEvents)
            {
                expect(event.category, 'Festivals & Lifestyle');
            }
        });
    });

    // end of tests of filtering by categories
}