// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:bloc/bloc.dart';

// Project imports:
import 'package:gyaan/bloc/feed/news_feed_event.dart';
import 'package:gyaan/bloc/feed/news_feed_state.dart';
import 'package:gyaan/controller/settings.dart';
import 'package:gyaan/model/news_model.dart';
import 'package:gyaan/services/news/news_service.dart';
import 'package:provider/provider.dart';

class NewsFeedBloc extends Bloc<NewsFeedEvent, NewsFeedState> {
  NewsFeedRepository repository;
  NewsFeedBloc({@required this.repository});

  @override
  NewsFeedState get initialState => NewsFeedInitialState();

  @override
  Stream<NewsFeedState> mapEventToState(NewsFeedEvent event) async* {
    if (event is FetchNewsByCategoryEvent) {
      yield NewsFeedLoadingState();
      try {
        List<Articles> news =
            await repository.getNewsByCategory(event.category);

        yield NewsFeedLoadedState(news: news);
      } catch (e) {
        yield NewsFeedErrorState(message: e.toString());
      }
    } else if (event is FetchNewsByTopicEvent) {
      yield NewsFeedLoadingState();
      try {
        List<Articles> news = await repository.getNewsByTopic(event.topic);
        yield NewsFeedLoadedState(news: news);
      } catch (e) {
        yield NewsFeedErrorState(message: e.toString());
      }
    } else if (event is FetchNewsFromLocalStorageEvent) {
      yield NewsFeedLoadingState();
      try {
        List<Articles> news =
            await repository.getNewsFromLocalStorage(event.box);
        yield NewsFeedLoadedState(news: news);
      } catch (e) {
        yield NewsFeedErrorState(message: e.toString());
      }
    }
  }
}
