import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app_cycle19_sun/modules/home/pages/widgets/button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../models/article_model.dart';

class ArticleDetails extends StatelessWidget {
  final ArticleModel article;
  const ArticleDetails({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (article.urlToImage.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  article.urlToImage,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                  const SizedBox(height: 200, child: Icon(Icons.broken_image)),
                ),
              ),
            const SizedBox(height: 16),
            Text(
              article.description,
              style: const TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16,),
            Button(text: "View Full Article", onPressed: () async {
              final url = Uri.parse(article.url);
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.inAppWebView);
              } else {
                Fluttertoast.showToast(
                    msg: "Could not open article",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              }
            },)
          ],
        ),
      ),
    );
  }
}