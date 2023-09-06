import 'package:flutter/material.dart';
import 'package:news_app/controller/news_provider.dart';
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

  @override
  void initState() {
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    // CategoryNewsClass newsClass = CategoryNewsClass();
    // await newsClass.getCategoryNews(widget.category);
    // articles = newsClass.news;

    Provider.of<NewsProvider>(context, listen: false)
        .getAllCategoryNews(widget.category);

    // ignore: use_build_context_synchronously
    Provider.of<NewsProvider>(context, listen: false).changeLoading();
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
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            ),
            Text(
              'App',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
            )
          ],
        ),
        actions: const [
          Opacity(
            opacity: 0,
            child: SizedBox(
              child: Icon(Icons.abc),
            ),
          )
        ],
        elevation: 0,
      ),
      body: Consumer<NewsProvider>(
        builder: (context, value, child) {
          return 
          // value.loading
          //     ? const Center(
          //         child: SizedBox(
          //           child: CircularProgressIndicator(),
          //         ),
          //       )
              // : 
              SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        SizedBox(
                          child: ListView.builder(
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
                              }),
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
