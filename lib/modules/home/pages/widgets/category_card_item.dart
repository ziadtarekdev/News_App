import 'package:flutter/material.dart';
import 'package:news_app_cycle19_sun/core/theme/app_colors.dart';
import 'package:news_app_cycle19_sun/models/category_model.dart';

class CategoryCardItem extends StatelessWidget {
  final int index;
  final CategoryModel categoryModel;

  const CategoryCardItem({
    super.key,
    required this.categoryModel,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 200,
      width: double.infinity,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(24),
        image: DecorationImage(
          image: AssetImage(categoryModel.image),
          fit: BoxFit.cover,
        ),
      ),
      child: Directionality(
        textDirection: index % 2 == 0 ? TextDirection.rtl : TextDirection.ltr,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              categoryModel.name,
              style: theme.textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.circular(84),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar
                    (
                    radius: 27,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 30,
                      color: AppColors.mainText,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 16,
                    ),
                    child: Text(
                      "View All",
                      style: theme.textTheme.headlineSmall,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
