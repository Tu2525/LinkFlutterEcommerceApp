import 'package:flutter/material.dart';
import 'package:link_flutter_ecommerce_app/model/category_model.dart';
import 'package:link_flutter_ecommerce_app/widgets/categories.dart';

class CategoriesSection extends StatelessWidget {
  CategoriesSection({super.key});


  final List<CategoryModel> allCategories= [
    CategoryModel(categoryName:'Hoodies' , imgPath: 'images/Ellipse 1.png', ontap: (){}),
    CategoryModel(categoryName:'Shorts' , imgPath:  'images/Ellipse 2.png', ontap: (){}),
    CategoryModel(categoryName:'Shoes' , imgPath: 'images/Ellipse 3.png', ontap: (){}),
    CategoryModel(categoryName:'Bag', imgPath: 'images/Ellipse 4.png', ontap: (){}),
    CategoryModel(categoryName:'Accessories', imgPath: 'images/Ellipse 3 (1).png', ontap: (){}),
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(
            height: screenHeight *0.09,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              const Text("Categories",style: TextStyle(
                fontWeight: FontWeight.bold
              ),),
              const Spacer(flex: 1,),
              GestureDetector(
                onTap: (){  },
                child:const Text("See All")),
            ],),
          ),
          Row(
            children: getAllCategories(),
          )],
        ),
      ),
    );
  }


  List<Categories> getAllCategories(){
    List<Categories> categoriesList=[];
    for(int i=0;i <allCategories.length;i++){
      categoriesList.add(Categories(imgPath:allCategories[i].imgPath
    , title: allCategories[i].categoryName));
    } 
    return categoriesList;
  }
}
