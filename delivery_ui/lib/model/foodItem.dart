import 'package:flutter/material.dart';



FoodItemList foodItemList = FoodItemList(foodItems: [


  FoodItem(
    id: 1,
    title: "Pizza Calabresa",
    hotel: "Monstrão",
    price: 15.00,
    imgURL: "https://blog.novasafra.com.br/wp-content/uploads/2016/01/accb7d_37d37d9f1001e88384dafc6e5cc60c4f.jpg_1024-780x450.jpg"
  ),


  FoodItem(
    id: 2,
    title: "Burger",
    hotel: "Rangô",
    price: 21.00,
    imgURL: "https://food.fnr.sndimg.com/content/dam/images/food/fullset/2017/5/10/0/FNM_060117-Smashburger-Style-Burgers-Recipe_s4x3.jpg.rend.hgtvcom.826.620.suffix/1494459418304.jpeg"
  ),

  FoodItem(
    id: 3,
    title: "Pirão",
    hotel: "Pirão do Recôncavo",
    price: 25.00,
    imgURL: "https://correio-cdn3.cworks.cloud/fileadmin/_processed_/8/5/csm_camarao_f515288b58.jpg"
  ),


]);




class FoodItemList{
  List<FoodItem> foodItems;

  FoodItemList({@required this.foodItems});
}
class FoodItem {

  int id;
  String title;
  String hotel;
  double price;
  String imgURL;
  int quantity;

  
  FoodItem({

    // inicializando as variáveis

    @required this.id,
    @required this.title,
    @required this.hotel,
    @required this.price,
    @required this.imgURL,

    this.quantity = 1

  });

  void incrementQuantity(){
    
    this.quantity = this.quantity + 1;

  }
  
  void decrementQuantity(){
    this.quantity = this.quantity - 1;
  }


}