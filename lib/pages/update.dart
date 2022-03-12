import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasedamo/pages/showproduct.dart';
import 'package:flutter/material.dart';

class UpdateProductPages extends StatefulWidget {
  const UpdateProductPages({ Key? key , this.id}) : super(key: key);
  
  final String? id;

  @override
  State<UpdateProductPages> createState() => _UpdateProductPagesState();
}

class _UpdateProductPagesState extends State<UpdateProductPages> {

  final TextEditingController _name = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _type = TextEditingController();

  
  CollectionReference product = FirebaseFirestore.instance.collection('Products');

  Future<void> updateProduct() {
  return product.doc(widget.id).update
  ({
      'product_name': _name.text,
      'price': _price.text,
      'product_type': _type.text,
    })
    .then((value) => print("Products Updated"))
    .catchError((error) => print("Failed to update product: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Form(
          child: ListView(
            children: [
              updatetext(_name , 'Product name' , 'product_name' ),
              updatetext(_price , 'price' , 'price' ),
              updatetext(_type , 'Product type' , 'product_type' ),
              submit(),
            ],
          ),
        ),
      ), 
    );
  }

  SizedBox submit() {
    return SizedBox(
      width: 130,
      height: 45,
      child: TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
        ),
        onPressed: () {
          updateProduct();
          var route = MaterialPageRoute(builder: (context) => const ShowProductPage(),);
          Navigator.push(context, route);
        },
        child: const Text('Update'),
      ),
    );
  }

  Widget updatetext(a,b,c){
    return FutureBuilder<DocumentSnapshot>(
      future: product.doc(widget.id).get(),
      builder: (context, snapshot){
        Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
        a.text = data[c].toString();
        return Container(
          width: 250,
          margin: const EdgeInsets.only(left: 32, right: 32, top: 8, bottom: 8),
          child: TextFormField(
            // autofocus: false,
            // controller: a,
            // keyboardType: const TextInputType.numberWithOptions(decimal: true),
            // // initialValue: c,
            // validator: (value) {
            //   if (value!.isEmpty) {
            //     return 'Please Enter Product ' + b;
            //   }
            //   return null;
            // }
            controller: a,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                borderSide: BorderSide(color: Color.fromARGB(255, 212, 255, 21), width: 2),
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                borderSide: BorderSide(color: Color.fromARGB(255, 0, 255, 191), width: 2),
              ),
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                borderSide: BorderSide(color: Colors.red, width: 2),
              ),
              prefixIcon: const Icon(
                Icons.sell,
                color: Colors.purple,
              ),
              label: Text(
                b,
                style: const TextStyle(color: Colors.purple),
              ),
            ),
          ),
        );
      }
    );
  }
  // Widget updatetextint(a,b,c){
  //   return FutureBuilder<DocumentSnapshot>(
  //     future: product.doc(widget.id).get(),
  //     builder: (context, snapshot){
  //       Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
  //       a.text = data[c].toString();
  //       return Container(
  //         width: 250,
  //         margin: const EdgeInsets.only(left: 32, right: 32, top: 8, bottom: 8),
  //         child: TextFormField(
  //           // autofocus: false,
  //           // controller: a,
  //           // keyboardType: const TextInputType.numberWithOptions(decimal: true),
  //           // // initialValue: c,
  //           // validator: (value) {
  //           //   if (value!.isEmpty) {
  //           //     return 'Please Enter Product ' + b;
  //           //   }
  //           //   return null;
  //           // }
  //           controller: a,
  //           decoration: InputDecoration(
  //             border: const OutlineInputBorder(
  //               borderRadius: BorderRadius.all(Radius.circular(16)),
  //               borderSide: BorderSide(color: Color.fromARGB(255, 212, 255, 21), width: 2),
  //             ),
  //             enabledBorder: const OutlineInputBorder(
  //               borderRadius: BorderRadius.all(Radius.circular(16)),
  //               borderSide: BorderSide(color: Color.fromARGB(255, 0, 255, 191), width: 2),
  //             ),
  //             errorBorder: const OutlineInputBorder(
  //               borderRadius: BorderRadius.all(Radius.circular(16)),
  //               borderSide: BorderSide(color: Colors.red, width: 2),
  //             ),
  //             prefixIcon: const Icon(
  //               Icons.sell,
  //               color: Colors.purple,
  //             ),
  //             label: Text(
  //               b,
  //               style: const TextStyle(color: Colors.purple),
  //             ),
  //           ),
  //         ),
  //       );
  //     }
  //   );
  // }

  // Container input(a,b) {
  //   return Container(
  //     width: 250,
  //     margin: const EdgeInsets.only(left: 32, right: 32, top: 8, bottom: 8),
  //     child: TextFormField(

  //       autofocus: false,
  //       controller: a,
  //       keyboardType: const TextInputType.numberWithOptions(decimal: true),
  //       // initialValue: c,
  //       validator: (value) {
  //         if (value!.isEmpty) {
  //           return 'Please Enter Product ' + b;
  //         }
  //         return null;
  //       },
  //       decoration: InputDecoration(
  //         border: const OutlineInputBorder(
  //           borderRadius: BorderRadius.all(Radius.circular(16)),
  //           borderSide: BorderSide(color: Color.fromARGB(255, 212, 255, 21), width: 2),
  //         ),
  //         enabledBorder: const OutlineInputBorder(
  //           borderRadius: BorderRadius.all(Radius.circular(16)),
  //           borderSide: BorderSide(color: Color.fromARGB(255, 0, 255, 191), width: 2),
  //         ),
  //         errorBorder: const OutlineInputBorder(
  //           borderRadius: BorderRadius.all(Radius.circular(16)),
  //           borderSide: BorderSide(color: Colors.red, width: 2),
  //         ),
  //         prefixIcon: const Icon(
  //           Icons.sell,
  //           color: Colors.purple,
  //         ),
  //         label: Text(
  //           b,
  //           style: const TextStyle(color: Colors.purple),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}