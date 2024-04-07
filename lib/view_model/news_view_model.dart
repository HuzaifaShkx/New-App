



import '../models/categories_news_model.dart';
import '../models/news_channles_headlines_model.dart';
import '../repository/news_repository.dart';

class NewsViewModel{
  final _rep=NewsRepository();

  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadlinesApi(String channelname)async{
    final response=await _rep.fetchNewsChannelHeadlinesApi(channelname);
    return response;
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category)async{
    final response=await _rep.fetchCategoriesNewsApi(category);
    return response;
  }
}