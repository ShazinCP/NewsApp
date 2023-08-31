import 'package:flutter/material.dart';
import 'package:news_app/controller/news_provider.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/model/article/article_model.dart';
import 'package:news_app/services/news.dart';
import 'package:news_app/view/home/widget/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ArticleModel> articles = <ArticleModel>[];

  @override
  void initState() {
    super.initState();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    // ignore: use_build_context_synchronously
    Provider.of<NewsProvider>(context, listen: false).changeLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'News',
                style: TextStyle(color: Colors.black),
              ),
              Text(
                'App',
                style: TextStyle(color: Colors.blue),
              )
            ],
          ),
          elevation: 0,
        ),
        body: Consumer<NewsProvider>(
          builder: (context, value, child) {
            // return value.loading
            //     ? Center(
            //         child: Container(
            //           child: const CircularProgressIndicator(),
            //         ),
            //       )
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    //categories
                    Container(
                      height: 70,
                      child: ListView.builder(
                          itemCount: categories.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return CategoryTile(
                              imageUrl: categories[index].imageUrl,
                              categoryName: categories[index].categoryName,
                            );
                          }),
                    ),

                    //Blogs
                    Container(
                      child: ListView.builder(
                          itemCount: articles.length,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return BlogTile(
                              imageUrl: articles[index].urlToImage,
                              title: articles[index].title,
                              desc: articles[index].description,
                              Url: articles[index].url,
                            );
                          }),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
