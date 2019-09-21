import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'bloc/cardListBloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

import 'model/foodItem.dart';

class Cart extends StatelessWidget {
  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();

  @override
  Widget build(BuildContext context) {
    List<FoodItem> foodItems;
    return StreamBuilder(
      stream: bloc.listStream,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          foodItems = snapshot.data;
          return Scaffold(
            body: SafeArea(
              child: Container(
                child: CartBody(foodItems),
              ),
            ),
            bottomNavigationBar: BottomBar(foodItems),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class BottomBar extends StatelessWidget {
  final List<FoodItem> foodItems;
  BottomBar(this.foodItems);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 35, bottom: 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          totalAmount(foodItems), // VALOR TOTAL
          Divider(height: 1, color: Colors.grey),
          persons(),
          nextButtonBar(),
        ],
      ),
    );
  }

  Container nextButtonBar() {
    return Container(
      margin: EdgeInsets.only(right: 25),
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
          color: Color(0xfffeb324), borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "15-25 min",
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
          ),
          Text(
            "Next",
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Container persons() {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Quantidade",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          CustomPersonWidget()
        ],
      ),
    );
  }

  Container totalAmount(List<FoodItem> foodItem) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Total:",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
          ),
          Text(
            "\$${returnTotalAmount(foodItems)}",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28),
          )
        ],
      ),
    );
  }

  // CALCULANDO VALOR

  String returnTotalAmount(List<FoodItem> foodItems) {
    double totalAmount = 0.0;
    for (var i = 0; i < foodItems.length; i++) {
      totalAmount = totalAmount + foodItems[i].price * foodItems[i].quantity;
    }
    return totalAmount.toStringAsFixed(2); // 2 DECIMAIS
  }
}

class CustomPersonWidget extends StatefulWidget {
  @override
  _CustomPersonWidgetState createState() => _CustomPersonWidgetState();
}

class _CustomPersonWidgetState extends State<CustomPersonWidget> {
  int noOfPersons = 1;
  double _buttonWidth = 30;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 25),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(vertical: 5),
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            width: _buttonWidth,
            height: _buttonWidth,
            child: FlatButton(
              child: Text(
                "-",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              onPressed: () {
                setState(() {
                  if (noOfPersons > 1) {
                    noOfPersons--;
                  }
                });
              },
            ),
          ),
          Text(
            noOfPersons.toString(),
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          SizedBox(
            width: _buttonWidth,
            height: _buttonWidth,
            child: FlatButton(
              child: Text(
                "+",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              onPressed: () {
                setState(() {
                  noOfPersons++;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CartBody extends StatelessWidget {
  final List<FoodItem> foodItems;
  CartBody(this.foodItems);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(35, 40, 25, 0),
      child: Column(
        children: <Widget>[
          CustomAppBar(),
          title(),
          Expanded(
            flex: 1,
            child: foodItems.length > 0 ? foodItemList() : noItemContainer(),
          )
        ],
      ),
    );
  }

  // TEXTO PARA DIZER QUE NÃO TEM MAIS ITENS

  Container noItemContainer() {
    return Container(
      child: Text(
        "No more items left in the cart",
        style: TextStyle(
            fontWeight: FontWeight.w600, color: Colors.grey[500], fontSize: 20),
      ),
    );
  }

  // LIST VIEW PARA LISTAR OS PRODUTOS

  ListView foodItemList() {
    return ListView.builder(
        itemCount: foodItems.length,
        itemBuilder: (builder, index) {
          return CartListItem(foodItem: foodItems[index]);
        });
  }

  Widget title() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Meu",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 35),
              ),
              Text(
                "Carrinho",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 35),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CartListItem extends StatelessWidget {
  final FoodItem foodItem;

  CartListItem({@required this.foodItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      child: ItemContent(foodItem: foodItem),
    );
  }
}

// CONTEUDO DO PRODUTO

class ItemContent extends StatelessWidget {
  final FoodItem foodItem;

  ItemContent({@required this.foodItem});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              foodItem.imgURL,
              fit: BoxFit.fitHeight,
              height: 55,
              width: 80,
            ),
          ),
          RichText(
            text: TextSpan(
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
                children: [
                  TextSpan(text: foodItem.quantity.toString()),
                  TextSpan(text: " x "),
                  TextSpan(text: foodItem.title)
                ]),
          ),
          Text("\$${foodItem.quantity * foodItem.price}",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400))
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(5),
          child: GestureDetector(
            child: Icon(CupertinoIcons.back, size: 30),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        GestureDetector(
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Icon(
              CupertinoIcons.delete,
              size: 35,
            ),
          ),
          onTap: () {},
        ),
      ],
    );
  }
}
