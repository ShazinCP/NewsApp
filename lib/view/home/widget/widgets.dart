import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/view/article_view/article_screen.dart';
import 'package:news_app/view/category_news/category_news.dart';

class CategoryTile extends StatelessWidget {
  final imageUrl, categoryName;
  const CategoryTile({super.key, this.imageUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CategoryNews(
          category: categoryName.toLowerCase(),
        ),));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 120,
                  height: 60,
                  fit: BoxFit.cover,
                )),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
              width: 120,
              height: 60,
              child: Text(
                categoryName,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final imageUrl, title, desc, Url;
  BlogTile(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.desc,
      required this.Url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleScreen(
                blogUrl: Url,
              ),
            ));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            if(imageUrl != null)
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(imageUrl ?? "https://www.smaroadsafety.com/wp-content/uploads/2022/06/no-pic.png")),
            const SizedBox(
              height: 10,
            ),
            Text(
              title ?? "Text Note Found",
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              desc ?? "Text Not Found",
              style: const TextStyle(color: Color.fromARGB(123, 51, 46, 46)),
            )
          ],
        ),
      ),
    );
  }
}
