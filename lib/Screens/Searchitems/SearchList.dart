
import 'package:farmboxapp/Constraints.dart';
import 'package:farmboxapp/Provider/CartProvider.dart';
import 'package:farmboxapp/Provider/ProductProvider.dart';
import 'package:farmboxapp/Screens/ProductScreen/DetailPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchList extends StatefulWidget {
  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsProvider>(
        builder: (context,productItems,child){

            return Container(
              margin: EdgeInsets.only(left: 15,right: 15),
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 14.0,

                        childAspectRatio: 0.90

                    ),
                    itemCount: productItems.filteredItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/product-detail',
                                  arguments: ProductArguments(
                                    name: productItems.filteredItems[index].name,
                                    sId: productItems.filteredItems[index].sId,
                                    description:
                                    productItems.filteredItems[index].description,
                                    mrp: productItems.filteredItems[index].mrp,
                                    featuredImage:
                                    productItems.filteredItems[index].featuredImage,
                                    unit: productItems.filteredItems[index].unit,
                                  ));
                            },
                          child: Container(

                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 0),
                                  blurRadius: 3,
                                  color: Colors.grey[400],
                                ),
                              ],
                            ),


                            child: Stack(
                              children: [
                                Positioned(
                                  right:0,
                                  child: Container(
                                    height: 15,
                                    width: 45,
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          //topLeft: Radius.circular(5),
                                          topRight: Radius.circular(10),
                                        )),
                                    child: Center(
                                      child: Text(
                                          productItems.filteredItems[index].unit,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 35),
                                  child: Center(
                                    child: Hero(
                                      tag: productItems.filteredItems[index].sId,
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        child: Image.network(
                                          productItems.filteredItems[index].featuredImage,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(top: 90),
                                  child: Center(
                                    child: Container(
                                        padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                        child: Text(
                                          productItems.filteredItems[index].name,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black, fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 137),
                                  child: Center(
                                    child: Text("₹ "+productItems.filteredItems[index].mrp.toString(),
                                      style: TextStyle(
                                        color:PrimaryColor,
                                        fontSize: 14
                                      ),),
                                  ),
                                )

                              ],

                            ),

                          ),
                        ),
                      );
                    }));
        });
  }
}
