import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import '../models/categories_news_model.dart';
import '../models/news_channles_headlines_model.dart';
import '../view_model/news_view_model.dart';
import 'category_screen.dart';
import 'news_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _home_screenState createState() => _home_screenState();
}

enum FilterList{bbcNews, aryNews,independent,reuters,cnn,alJqazeera}

class _home_screenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();

  FilterList? selectedmenu;
  String name="bbc-news";
  final format=DateFormat('MM dd,yyyy');
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryScreen()));
          },
          icon:Icon(Icons.apps_rounded),
         ),
        actions: [
          PopupMenuButton<FilterList>(
            initialValue: selectedmenu,
            onSelected: (FilterList item){

              if(FilterList.bbcNews.name==item.name){
                name='bbc-news';
              }
                if(FilterList.aryNews.name==item.name){
                name='ary-news';
              }
               if(FilterList.cnn.name==item.name){
                name='cnn';
              }            
               if(FilterList.independent.name==item.name){
                name='abc-news-au';
              }
               if(FilterList.alJqazeera.name==item.name){
                name='al-jazeera-english';
              }
               if(FilterList.reuters.name==item.name){
                name='reuters';
              }
           
            setState(() {
                         selectedmenu=item;
                        
                        });

            },
            itemBuilder: (BuildContext context)=><PopupMenuEntry<FilterList>>[
            PopupMenuItem<FilterList>(
              value: FilterList.bbcNews,
              child: Text("BBC News"),
            ),
             PopupMenuItem<FilterList>(
              value: FilterList.aryNews,
              child: Text("ARY News"),
            ),
             PopupMenuItem<FilterList>(
              value: FilterList.alJqazeera,
              child: Text("Al Jazeera News"),
            ),
             PopupMenuItem<FilterList>(
              value: FilterList.cnn,
              child: Text("CNN News"),
            ),
             PopupMenuItem<FilterList>(
              value: FilterList.independent,
              child: Text("Independent News"),
            ),
             PopupMenuItem<FilterList>(
              value: FilterList.reuters,
              child: Text("Reuters News"),
            ),
          ],)
        ],
        title: Text(
          'News',
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
        SizedBox(
          height: height * .55,
          width: width,
          child: FutureBuilder<NewsChannelsHeadlinesModel>(
              future: newsViewModel.fetchNewsChannelHeadlinesApi(name),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitFadingFour(
                      size: 50,
                      color: Colors.blue,
                    ),
                  );
                } else {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context, index) {
                        DateTime dateTime=DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsDetailScreen(
                              newsImage: snapshot.data!.articles![index].urlToImage.toString(),
                              newsTitle: snapshot.data!.articles![index].title.toString(),
                              description: snapshot.data!.articles![index].description.toString(),
                              author: snapshot.data!.articles![index].author.toString(),
                              content: snapshot.data!.articles![index].content.toString(),
                              newsDate: snapshot.data!.articles![index].publishedAt.toString(),
                              source: snapshot.data!.articles![index].source!.name.toString(),

                            )));
                          },
                                                  child: SizedBox(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: height * .6,
                                  width: width * 0.9,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: height * .02,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Container(
                                        child: spinkit2,
                                      ),
                                        errorWidget: (context, url, error) => Icon(
                                        Icons.error_outline,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                           bottom: 20,                    
                                            child: Card(
                                              elevation: 5,
                                              color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.all(15),
                                      height: height*0.22,
                                      alignment: Alignment.bottomCenter,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: width*0.7,
                                            child: Text(snapshot.data!.articles![index].title.toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(fontSize: 17,fontWeight: FontWeight.bold),),
                                          ),
                                          Spacer(),
                                          Container(
                                            width: width*0.7,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(snapshot.data!.articles![index].source!.name.toString(),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: GoogleFonts.poppins(fontSize: 13,fontWeight: FontWeight.w600),
                                                ),
                                                Text(format.format(dateTime),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: GoogleFonts.poppins(fontSize: 12,fontWeight: FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    

                                  ),
                                )
                             
                              ],
                            ),
                          ),
                        );
                      });
                }
              }),
        )
      ,
         Padding(
           padding: const EdgeInsets.all(8),
           child: FutureBuilder<CategoriesNewsModel>(
                  future: newsViewModel.fetchCategoriesNewsApi('General'),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: SpinKitFadingFour(
                          size: 50,
                          color: Colors.blue,
                        ),
                      );
                    } else {
                      return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.articles!.length,
                            itemBuilder: (context, index) {
                              DateTime dateTime=DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                              return Padding(
                                padding: const EdgeInsets.only(bottom:15),
                                child: InkWell(
                                  onTap: (){
                                             Navigator.push(context,MaterialPageRoute(builder: (context)=>NewsDetailScreen(
                            newsTitle: snapshot.data!.articles![index].title.toString(),
                            newsDate: snapshot.data!.articles![index].publishedAt.toString(),
                            author: snapshot.data!.articles![index].author.toString(),
                            content: snapshot.data!.articles![index].content.toString(),
                            newsImage: snapshot.data!.articles![index].urlToImage.toString(),
                            description: snapshot.data!.articles![index].description.toString(),
                            source: snapshot.data!.articles![index].source!.name.toString(),
                          )));
                                          },
                                                                  child: Row(
                                    children: [
                                       ClipRRect(
                                          borderRadius: BorderRadius.circular(15),
                                          child: CachedNetworkImage(
                                              imageUrl: snapshot
                      .data!.articles![index].urlToImage
                      .toString(),
                                              fit: BoxFit.cover,
                                              height: height*.18,
                                              width: width*.3,
                                              placeholder: (context, url) => Container(
                                                child: spinkit2,
                                              ),
                                                errorWidget: (context, url, error) => Icon(
                                                Icons.error_outline,
                                                color: Colors.red,
                                              ),
                                            ),
                                        ),
                                       Expanded(
                                         child:Container(
                                           height: height*.18,
                                           padding: EdgeInsets.only(left: 15),
                                           child:Column(
                                             children: [
                                               Text( snapshot
                      .data!.articles![index].title
                      .toString(),
                      maxLines: 3,
                      style: GoogleFonts.poppins(fontSize: 15,
                      color: Colors.black54,
                      fontWeight: FontWeight.w700),
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text( snapshot
                      .data!.articles![index].source!.name
                      .toString(),
                                               
                      style: GoogleFonts.poppins(fontSize: 12,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600),
                      ),
                       Text( format.format(dateTime),
                                               
                      style: GoogleFonts.poppins(fontSize: 12,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600),
                      ),
                        ],
                      )
                                             ],
                                           ) ,
                                         ) ,),
                                    ],
                                  ),
                                ),
                              );
                            });
                    }
                  }),
         ),
      ]),
    );
  }
}

const spinkit2 = SpinKitChasingDots(
  color: Colors.blue,
  size: 50,
);
