import 'package:flutter/material.dart';
import 'package:news_app/controller/news_provider.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/model/article/article_model.dart';
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
    // News newsClass = News();
    // articles = await newsClass.getNews();
    Provider.of<NewsProvider>(context, listen: false).getAllNews();
    Provider.of<NewsProvider>(context, listen: false).changeLoading();
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'News',
                style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),
              ),
              Text(
                'App',
                style: TextStyle(color: Colors.red,fontWeight: FontWeight.w600),
              )
            ],
          ),
          elevation: 0,
        ),
        body: Consumer<NewsProvider>(
          builder: (context, value, child) {
            return value.loading
                ? const Center(
                    child: SizedBox(
                      child: CircularProgressIndicator(),
                    ),
                  )
            : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    //categories
                    SizedBox(
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
                    SizedBox(
                      child: Consumer<NewsProvider>(
                        builder: (context, value, child) {
                           return ListView.builder(
                            itemCount: value.articles.length,
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return BlogTile(
                                imageUrl: value.articles[index].urlToImage,
                                title: value.articles[index].title,
                                desc: value.articles[index].description,
                                Url: value.articles[index].url,
                              );
                            });
                        },
                       
                      ),
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
