import 'package:fyvent/components/EventSearch.dart';
import 'package:test/test.dart';


// placeholder
// gotta wait till search event filter by category is implemented
void main()
{
    EventSearch eventSearcher = new EventSearch();

    group('Upon clicking low-price button', ()
          {
              test('lower boundary, valid equivalence class', ()
                  {
                      eventSearcher.buildSuggestions(null);

                      for(var event in eventSearcher.noSuchMethod(null)) // get events
                      {
                          var price = event.noSuchMethod(null); // getPrice()

                          expect(price > 0 && price <= 10, true);
                      }
                  });

              test('upper boundary, valid equivalence class', ()
                  {
                      eventSearcher.buildSuggestions(null);

                      for(var event in eventSearcher.noSuchMethod(null)) // get events
                      {
                          var price = event.noSuchMethod(null); // getPrice()

                          expect(price > 0 && price <= 10, true);
                      }
                  });

              test('lower boundary, invalid equivalence class 1', ()
                  {
                      eventSearcher.buildSuggestions(null);

                      for(var event in eventSearcher.noSuchMethod(null)) // get events
                      {
                          var price = event.noSuchMethod(null); // getPrice()

                          expect(price > 0 && price <= 10, false);
                      }
                  });

              test('lower boundary, invalid equivalence class 2', ()
                  {
                      eventSearcher.buildSuggestions(null);

                      for(var event in eventSearcher.noSuchMethod(null)) // get events
                      {
                          var price = event.noSuchMethod(null); // getPrice()

                          expect(price > 0 && price <= 10, false);
                      }
                  });
          });
}