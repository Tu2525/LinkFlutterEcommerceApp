import 'package:flutter/material.dart';
import 'package:link_flutter_ecommerce_app/screens/categories_list_screen.dart';

class WithoutDataWidget extends StatelessWidget {
  const WithoutDataWidget({super.key, required this.img , required this.text});
  final String img; 
  final String text;
  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(img, width: 100),
          const SizedBox(height: 20),
          Text(
            text,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color:  isDarkMode ? Colors.white : const Color(0xff272727),),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF9D6BFD),
              shape: const StadiumBorder(),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CategoriesList()),
              );
            },
            child:  Text("Explore Categories",
            style: TextStyle(
              color: isDarkMode ? Colors.white : const Color(0xff272727),
            ),),
          ),
        ],
      ),
    );
  }
}
