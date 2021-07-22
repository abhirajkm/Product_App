import 'dart:convert';
import 'dart:ui';


import 'package:bexindia/Helper/PrefsHelper.dart';
import 'package:bexindia/Helper/config.dart';
import 'package:bexindia/Models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddAddress extends StatefulWidget {
  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  List<Address> list;
  bool args, progress = false;
  Future addressFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      addressFuture= _fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,),
              onPressed: (){
                Navigator.pop(context);
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
              }),
          backgroundColor:Colors.white,
          elevation: 0,
          title:Text("My Address",style: TextStyle(
              fontWeight: FontWeight.w600,

              letterSpacing: 1.5,
              color: Colors.black
          )),
        ),
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),

                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/add-address", arguments: args);
                  },
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(color: Colors.black38),
                    ]),
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          size: 20,
                        ),
                        Text(
                          "Add Address",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),

                FutureBuilder(
                  builder: (context, addressSnap) {
                    if (addressSnap.connectionState == ConnectionState.none &&
                        addressSnap.hasData == null) {
                      return Container(

                      );
                    }
                    return addressSnap.data != null
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 8),
                          child: Text(addressSnap.data.length.toString()+" SAVED ADDRESSES",
                            style: TextStyle(color: Colors.black45,fontSize: 10,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        if (progress==true)

                          Center(child: CircularProgressIndicator())
                        else
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            reverse: true,
                            shrinkWrap: true,
                            itemCount: addressSnap.data.length,
                            itemBuilder: (context, index) {
                              Address address = addressSnap.data[index];
                              return Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(color: Colors.black38),
                                    ]),
                                padding: EdgeInsets.only( left: 10),
                                child: InkWell(
                                  onTap: () {
                                    if (args=true) {
                                      saveAddress(address);
                                      // Navigator.pushNamed(
                                      //     context, '/checkout');
                                    }
                                  },
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        child: popMenu(address),
                                        right: -10,
                                      ),
                                      Container(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                address.name.toUpperCase(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                    FontWeight.w600),
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                (address.addressLine1 +
                                                    " , " +
                                                    address.addressLine2)
                                                    .toUpperCase(),
                                                style:
                                                TextStyle(fontSize: 14),
                                              ),
                                              Text(
                                                address.pincode +
                                                    " , ".toUpperCase(),
                                                style:
                                                TextStyle(fontSize: 14),
                                              ),
                                              Text(
                                                address.phone +
                                                    " , ".toUpperCase(),
                                                style:
                                                TextStyle(fontSize: 14),
                                              ),
                                              Text(
                                                address.landmark ,
                                                    //+
                                                   // " , ".toUpperCase(),
                                                style:
                                                TextStyle(fontSize: 14),
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                      ],
                    )
                        : Container();
                  },
                  future: addressFuture,
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
        ));
  }

  Future<void> removeAddress(addressId) async {
    setState(() {
      progress = true;
    });
    final prefs = await SharedPreferences.getInstance();
    String userDetails = prefs.getString("USER");
    Userdetails user = Userdetails.fromJson(json.decode(userDetails));
    String url = Config.BASE_URL + "/auth/user/address/" + addressId;


    final http.Response response = await http.put(
      url,
      headers: <String, String>{
        'Authorization': user.token,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    setState(() {
      addressFuture = _fetchData();
      progress = false;

    });

    return list;

  }

  Future<void> _fetchData() async {

    final prefs = await SharedPreferences.getInstance();
    String userDetails = prefs.getString("USER");
    Userdetails user = Userdetails.fromJson(json.decode(userDetails));
    String url = Config.BASE_URL + "/auth/user/details";

    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': user.token
      },
    );

    var responseJson = json.decode(response.body);
    setState(() {
      list = (responseJson['user']['address'] as List)
          .map((data) => new Address.fromJson(data))
          .toList();

    });


    return list;
  }

  void saveAddress(address) {
    PrefsHelper.setAddress(jsonEncode({
      "name": address.name,
      "address_line1": address.addressLine1,
      "address_line2": address.addressLine2,
      "phone": address.phone,
      "pincode": address.pincode,
      "landmark": address.landmark
    }));
  }

  Widget popMenu(address) {
    return PopupMenuButton(
        iconSize: 20,
        onSelected: (value) {
          if (value == 1) {
            saveAddress(address);
            print("1");
          }
          if (value == 2) {
            removeAddress(address.sId);
            print(address.sId);
            print("2");
          }
        },
        itemBuilder: (context) => [
          PopupMenuItem(value: 1, child: Text('Default')),
          PopupMenuItem(value: 2, child: Text('Remove')),
        ]);
  }
}
