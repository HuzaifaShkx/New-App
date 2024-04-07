import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/categories_news_model.dart';
import '../models/news_channles_headlines_model.dart';



class NewsRepository{
  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadlinesApi(String channelname)async{
    String url='https://newsapi.org/v2/top-headlines?sources=${channelname}&apiKey=a49bc1fbbd754180b41593a39f954d3e';
    final response=await http.get(Uri.parse(url));

    if(kDebugMode){
      print(response.body);
    }
    if(response.statusCode==200){
      final body=jsonDecode(response.body);
      return NewsChannelsHeadlinesModel.fromJson(body);
    }
    throw Exception('Error');
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category)async{
    String url='https://newsapi.org/v2/everything?q=${category}&apiKey=a49bc1fbbd754180b41593a39f954d3e';
    final response=await http.get(Uri.parse(url));

    if(kDebugMode){
      print(response.body);
    }
    if(response.statusCode==200){
      final body=jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    }
    throw Exception('Error');
  }
}