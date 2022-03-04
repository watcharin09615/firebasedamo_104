import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasedamo/pages/showproduct.dart';
import 'package:flutter/material.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({ Key? key }) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  
  final TextEditingController _name = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _type = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Form(
        child: ListView(
          children: [
            input(_name , 'name'),
            input(_price , 'price'),
            input(_type , 'type'),
            submit(),

          ],
        ),
      ),
    );
  }

  CollectionReference products = FirebaseFirestore.instance.collection('Products');
  Future<void> addProduct() {
    return products
        .add({
          'product_name': _name.text,
          'price': _price.text,
          'product_type': _type.text,
        })
        .then((value) => print("Product data has been successfully"))
        .catchError((error) => print("Failed to add data: $error"));
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
          addProduct();
          var route = MaterialPageRoute(builder: (context) => const ShowProductPage(),);
          Navigator.push(context, route);
        },
        child: const Text('เพิ่ม'),
      ),
    );
  }

  Container input(a,b) {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(left: 32, right: 32, top: 8, bottom: 8),
      child: TextFormField(
        controller: a,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Enter Product ' + b;
          }
          return null;
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Colors.purple, width: 2),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Colors.purple, width: 2),
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
            style: TextStyle(color: Colors.purple),
          ),
        ),
      ),
    );
  }
}