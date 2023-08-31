import 'package:flutter/material.dart';
import 'package:news_app/controller/news_provider.dart';
import 'package:news_app/model/article/article_model.dart';
import 'package:news_app/services/news.dart';
import 'package:news_app/view/home/home.dart';
import 'package:news_app/view/home/widget/widgets.dart';
import 'package:provider/provider.dart';

class CategoryNews extends StatefulWidget {
  final category;
  const CategoryNews({super.key, this.category});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel> articles = <ArticleModel>[];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;

    // ignore: use_build_context_synchronously
    Provider.of<NewsProvider>(context, listen: false).changeLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop(MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ));
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          backgroundColor: Colors.white,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
          actions: [
            Opacity(
              opacity: 0,
              child: Container(
                child: const Icon(Icons.abc),
              ),
            )
          ],
          elevation: 0,
        ),
        body: _loading
            ? Center(
                child: Container(
                  child: const CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
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
                      ),
                    ],
                  ),
                ),
              ));
  }
}
