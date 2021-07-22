import 'package:flutter/material.dart';
class SingleCategory extends StatelessWidget {
  const SingleCategory({
    Key key,
    this.image,
    this.title
  }) : super(key: key);
  final String image, title;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
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

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                //color: Colors.yellow,
                image: DecorationImage(
                    image: NetworkImage(image),
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
            Text(title.toUpperCase(),
              style:
              TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
