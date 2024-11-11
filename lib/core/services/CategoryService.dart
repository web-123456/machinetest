import 'package:marketky/core/model/Category.dart';

class CategoryService {
  static List<Category> categoryData = categoryRawData.map((data) => Category.fromJson(data)).toList();
}

var categoryRawData = [
  {
    'featured': false,
    'icon_url': 'assets/icons/Discount.svg',
    'name': 'best offer',
  },
 
  {
    'featured': false,
    'icon_url': 'assets/icons/Woman-dress.svg',
    'name': 'woman dress',
  },
  {
    'featured': false,
    'icon_url': 'assets/icons/Man-Clothes.svg',
    'name': 'men clothes',
  },
  {
    'featured': false,
    'icon_url': 'assets/icons/Man-Pants.svg',
    'name': 'Kids',
  },
 
];
