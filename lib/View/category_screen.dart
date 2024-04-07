import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../models/categories_news_model.dart';
import '../view_model/news_view_model.dart';
import 'news_detail_screen.dart';


class CategoryScreen extends StatefulWidget {
  const CategoryScreen({ Key? key }) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
    NewsViewModel newsViewModel = NewsViewModel();
  String categoryname="general";
  final format=DateFormat('MM dd,yyyy');

List<String> categoriesList=[
  'General','Entertainment','Health','Sports','Business','Technology'
];

  @override
  Widget build(BuildContext context) {

     final width = MediaQuery.sizeOf(context).width * 1;
     final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories News",style: GoogleFonts.poppins(fontSize: 20,color: Colors.black54,fontWeight: FontWeight.w800),),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoriesList.length,
                itemBuilder: (context,index){
                  return InkWell(
                    onTap: (){
                      categoryname=categoriesList[index];
                      setState((){});
                    },
                                      child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color:categoryname==categoriesList[index]? Colors.blue:Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Center(child: Text(categoriesList[index].toString(),style: GoogleFonts.poppins(fontSize: 12,color: Colors.white),)),
                        ),
                      ),
                    ),
                  );

                },

              ),
            ),
            SizedBox(height: 20,),
            Expanded(
                          child: FutureBuilder<CategoriesNewsModel>(
                future: newsViewModel.fetchCategoriesNewsApi(categoryname),
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
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (context, index) {
                          DateTime dateTime=DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                          return Padding(
                            padding: const EdgeInsets.only(bottom:15),
                            child: InkWell(
                              onTap:(){
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
                                                      Flexible(
                                                                                                              child: Text( snapshot
                                                  .data!.articles![index].source!.name
                                                  .toString(),
                                               
                                                  style: GoogleFonts.poppins(fontSize: 12,
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w600),
                                                  ),
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
          ],
        ),
      ),
    );
  }
}


const spinkit2 = SpinKitChasingDots(
  color: Colors.blue,
  size: 50,
);
