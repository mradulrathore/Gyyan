// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:bloc/bloc.dart';

// Project imports:
import 'package:gyaan/model/news_model.dart';
import 'package:gyaan/services/news/news_service.dart';
import 'search_feed_event.dart';
import 'search_feed_state.dart';

class SearchFeedBloc extends Bloc<SearchFeedEvent, SearchFeedState> {
  NewsFeedRepository repository;
  SearchFeedBloc({@required this.repository});

  @override
  SearchFeedState get initialState => SearchFeedInitialState();

  @override
  Stream<SearchFeedState> mapEventToState(SearchFeedEvent event) async* {
    if (event is FetchNewsBySearchQueryEvent) {
      yield SearchFeedLoadingState();
      try {
        List<Articles> news =
            await repository.getNewsBySearchQuery(event.query);
        yield SearchFeedLoadedState(news: news);
      } catch (e) {
        yield SearchFeedErrorState(message: e.toString());
      }
    }
  }
}
