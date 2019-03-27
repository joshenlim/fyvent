import 'package:fyvent/components/EventSearch.dart';
import 'package:test/test.dart';


/// archived test
/// event price is not going to be implemented
void main()
{
    EventSearch eventSearcher = new EventSearch();

    group('Upon clicking low-price button', ()
          {
              test('lower boundary, valid equivalence class', ()
                  {
                      eventSearcher.buildSuggestions(null);

                      for(var event in eventSearcher.getSearchEvents)
                      {
                          var price = event.noSuchMethod(null); // getPrice()

                          expect(price > 0 && price <= 10, true);
                      }
                  });

              test('upper boundary, valid equivalence class', ()
                  {
                      eventSearcher.buildSuggestions(null);

                      for(var event in eventSearcher.getSearchEvents)
                      {
                          var price = event.noSuchMethod(null); // getPrice()

                          expect(price > 0 && price <= 10, true);
                      }
                  });

              test('lower boundary, invalid equivalence class 1', ()
                  {
                      eventSearcher.buildSuggestions(null);

                      for(var event in eventSearcher.getSearchEvents)
                      {
                          var price = event.noSuchMethod(null); // getPrice()

                          expect(price > 0 && price <= 10, false);
                      }
                  });

              test('lower boundary, invalid equivalence class 2', ()
                  {
                      eventSearcher.buildSuggestions(null);

                      for(var event in eventSearcher.getSearchEvents)
                      {
                          var price = event.noSuchMethod(null); // getPrice()

                          expect(price > 0 && price <= 10, false);
                      }
                  });
          });
}