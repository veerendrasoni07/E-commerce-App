import 'package:frontend/controller/category_controller.dart';
import 'package:frontend/provider/categoryProvider.dart';
import 'package:frontend/views/nav_screen/category_screen.dart';
import 'package:frontend/views/screens/details/screens/inner_category_screen.dart';
import 'package:frontend/views/widgets/reuseable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryWidget extends ConsumerStatefulWidget {
  const CategoryWidget({super.key});

  @override
  ConsumerState<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends ConsumerState<CategoryWidget> {
  @override
  void initState() {
    super.initState();
    _fetchCategory();
  }

  void _fetchCategory()async{
    final CategoryController categoryController = CategoryController();
    final categories = await categoryController.loadCategory();
    ref.read(categoryProvider.notifier).setCategory(categories);
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoryProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: ReuseableTextWidget(title: "Categories", subtitle: "View All", onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryScreen()))),
        ),
         GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  crossAxisCount: 4,
                ),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return InkWell(
                    onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>InnerCategoryScreen(category: category))),
                    child: SizedBox(
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              category.image,
                              height: 50,
                              width: 50,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Text(category.name,style: TextStyle(fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,)
                        ],
                      ),
                    ),
                  );
                },
              )
      ],
    );
  }
}

