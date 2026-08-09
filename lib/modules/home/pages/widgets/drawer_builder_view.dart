import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:news_app_cycle19_sun/core/gen/assets.gen.dart';
import 'package:news_app_cycle19_sun/core/providers/settings_provider.dart';
import 'package:news_app_cycle19_sun/core/theme/app_colors.dart';
import 'package:provider/provider.dart';

class DrawerBuilderView extends StatelessWidget {
  final void Function()? goToHome;

  const DrawerBuilderView({super.key, required this.goToHome});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final vm = Provider.of<SettingsProvider>(context);
    return Column(
      children: [
        Container(
          height: 165,
          width: double.infinity,
          alignment: Alignment.center,
          // margin: const EdgeInsets.symmetric(vertical: 40.0),
          decoration: BoxDecoration(color: Colors.white),
          child: Text("News App", style: theme.textTheme.headlineSmall),
        ),

        GestureDetector(
          onTap: goToHome,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              spacing: 10,
              children: [
                Assets.icons.homeIcn.svg(),
                Text(
                  "Go To Home",
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),

        Divider(height: 35, indent: 25, endIndent: 25),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            spacing: 10,
            children: [
              Assets.icons.translateIcn.svg(),
              Text(
                "Language",
                style: theme.textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomDropdown<String>(
            hintText: 'Select Language',
            items: ["Arabic", "English"],
            initialItem: vm.currentLanguage == "ar" ? "Arabic" : "English",
            decoration: CustomDropdownDecoration(
              listItemStyle: theme.textTheme.bodyLarge,
              listItemDecoration: ListItemDecoration(
                selectedColor: AppColors.mainText,
              ),
              headerStyle: theme.textTheme.titleLarge?.copyWith(
                color: Colors.white,
              ),
              closedFillColor: Colors.transparent,
              closedBorder: Border.all(color: Colors.white),
              closedSuffixIcon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.white,
              ),
            ),
            animation: const CustomDropdownAnimation(
              type: DropdownAnimationType.scaleFade,
              // size, fade, sizeFade, scale, scaleFade, slide
              duration: Duration(milliseconds: 350),
              curve: Curves.easeOutCubic,
              staggerItems: true, // cascading list-item entrance
            ),
            onChanged: (value) {
              if (value == "Arabic") {
                vm.changeLanguage("ar");
              } else {
                vm.changeLanguage("en");
              }
            },
          ),
        ),
      ],
    );
  }
}
