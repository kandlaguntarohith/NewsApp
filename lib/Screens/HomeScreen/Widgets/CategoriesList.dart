import 'package:flutter/material.dart';
import 'package:news/Models/Category.dart';
import 'package:shimmer/shimmer.dart';

class CategoriesList extends StatefulWidget {
  final Function selectedCategory;
  final String category;

  const CategoriesList({Key key, this.selectedCategory, this.category})
      : super(key: key);
  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  String selected;

  @override
  void initState() {
    super.initState();
    selected = widget.category;
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      height: 30,
      width: maxWidth,
      // width: double.infinity,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        cacheExtent: maxWidth + 100,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            setState(() {
              selected = categories[index].name;
            });
            widget.selectedCategory(selected);
          },
          child: CategoryTile(
            category: categories[index],
            isSelected: selected == categories[index].name,
          ),
        ),
        itemCount: categories.length,
      ),
      // child: SingleChildScrollView(
      //   scrollDirection: Axis.horizontal,
      //   child: Row(
      //     children: categories
      //         .map((e) => CategoryTile(
      //               category: e,
      //             ))
      //         .toList(),
      //   ),
      // ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final Category category;
  final bool isSelected;
  const CategoryTile({Key key, this.category, this.isSelected})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 30,
        width: 90,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              alignment: Alignment.center,
              height: double.infinity,
              decoration: BoxDecoration(
                color: isSelected ? null : Colors.grey[900],
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10),
                ),
                image: DecorationImage(
                  image: AssetImage(category.imageAdd),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.amber[600]
                    : Colors.black.withOpacity(0.25),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: isSelected
                  ? Shimmer.fromColors(
                      child: Text(
                        category.name.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 9,
                        ),
                      ),
                      baseColor: Colors.white,
                      highlightColor: Colors.pink,
                    )
                  : Text(
                      category.name.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 8,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
