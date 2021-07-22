import 'dart:convert';

import 'package:farmboxapp/Helper/config.dart';
import 'package:farmboxapp/Models/CategoryModel.dart';
import 'package:farmboxapp/Provider/CategoryProvider.dart';
import 'package:farmboxapp/Screens/Catogory/SubProductsList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
class HomeCategoryList extends StatefulWidget {
  const HomeCategoryList({Key key}) : super(key: key);

  @override
  _HomeCategoryListState createState() => _HomeCategoryListState();
}

class _HomeCategoryListState extends State<HomeCategoryList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }
  @override
  Widget build(BuildContext context) {

    return Consumer<CategoryProvider>(builder: (context, categoryProvider, child) {
          if(categoryProvider.count > 0){
            return ListView.builder(

                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: categoryProvider.count,
                itemBuilder: (context, index) {
                  String categoryname = categoryProvider.items[index].text;
                  return  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, "/subCategory",arguments: SubCategoryArguments(category: categoryname));
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>PremiumDetail()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        height: 100,
                        width:100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 0),
                              blurRadius: 3,
                              color: Colors.grey[400],
                            ),
                          ],
                        ),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  //borderRadius: BorderRadius.circular(0),
                                  //color: Colors.yellow,
                                  image: DecorationImage(
                                      image: NetworkImage(categoryProvider.items[index].thumbnail),
                                      fit: BoxFit.contain
                                  )
                              ),
                            ),
                            // CircleAvatar(
                            //   radius: 55,
                            //   child: Image.asset(
                            //     image,
                            //     // height: 100,
                            //     // width: 300,
                            //     fit: BoxFit.cover,
                            //   ),
                            // ),
                            SizedBox(height: 10,),
                            Text(categoryProvider.items[index].text.toUpperCase(),
                              style:
                              TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
        else {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
                child: CircularProgressIndicator(
                    backgroundColor: Colors.green,
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        Colors.green[100]))),
          ],
        );
      }

    },);
  }
  void fetchData() async {
    List<CategoryModel>list;
    final http.Response response = await http.get(
      Config.BASE_URL + '/inventory/allcategories',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    list = (json.decode(response.body) as List)
        .map((data) => new CategoryModel.fromJson(data))
        .toList();
    print(jsonEncode(response.body));
    Provider.of<CategoryProvider>(context, listen: false).setCategory(list);

  }
}