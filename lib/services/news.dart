import 'dart:convert';
import 'package:news_app/model/article/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];
  Future<List<ArticleModel>> getNews() async {
    try {
      String url =
          'https://newsapi.org/v2/top-headlines?country=in&apiKey=9a922478bde34c1298d3aba0b7a4f66d';

      var response = await http.get(Uri.parse(url));

      var jsonData = jsonDecode(response.body);
      final articleList = (jsonData["articles"] as List).map((e) {
        return ArticleModel.fromJson(e as Map<String, dynamic>);
      }).toList();

      return articleList;
    } catch (e) {
      return [];
    }
  }
}

class CategoryNewsClass {
  List<ArticleModel> news = [];
  Future<List<ArticleModel>> getCategoryNews(String category) async {
    try {
      String url =
          'https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=9a922478bde34c1298d3aba0b7a4f66d';

      var response = await http.get(Uri.parse(url));

      var jsonData = jsonDecode(response.body);
      final articleList = (jsonData["articles"] as List).map((e) {
        return ArticleModel.fromJson(e as Map<String, dynamic>);
      }).toList();
      return articleList;
    } catch (e) {
      return [];
    }
  }
}



// class News {
  // List<ArticleModel> news = [];


//**************************************************** */
  // Future<String> getName() async{
  //   String name = "ASDFGG";
  //   return name;
  // }
  
  // String? name;
  // void getNameFromServer()async{
  //    name = await getName();
  // }
//**************************************************** */


  // Future<void> getNews() async {
  //   String url =
  //       'https://newsapi.org/v2/top-headlines?country=in&apiKey=9a922478bde34c1298d3aba0b7a4f66d';

  //   var response = await http.get(Uri.parse(url));

  //   var jsonData = jsonDecode(response.body);

  //   if (jsonData['status'] == "ok") {
  //     jsonData["articles"].forEach((element) {
  //       if (element["urlToImage"] != null && element["description"] != null) {
  //          ArticleModel articleModel = ArticleModel(
  //             title: element['title'],
  //              author: element["author"],
  //              description: element["description"],
  //              url: element["url"],
  //              urlToImage: element["urlToImage"],
  //              content: element["content"]);

  //          news.add(articleModel);
  //       }
  //     });
  //   }
  // }
  // }


//   class CategoryNewsClass {
//   // List<ArticleModel> news = [];

//   Future<void> getNews(String category) async {
//     String url =
//         'https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=9a922478bde34c1298d3aba0b7a4f66d';

//     var response = await http.get(Uri.parse(url));

//     var jsonData = jsonDecode(response.body);

//     if (jsonData['status'] == "ok") {
//       jsonData["articles"].forEach((element) {
//         if (element["urlToImage"] != null && element["description"] != null) {
//           //changefromjson

//           ArticleModel articleModel = ArticleModel(
//               title: element['title'],
//               author: element["author"],
//               description: element["description"],
//               url: element["url"],
//               urlToImage: element["urlToImage"],
//               //  publishAt: element["publishedAt"],
//               content: element["content"]);

//           news.add(articleModel);
//         }
//       });
//     }
//   }
// }