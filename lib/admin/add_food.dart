// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, unrelated_type_equality_checks, unused_local_variable, unused_import, unnecessary_import, avoid_print

import 'dart:ffi';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fooddie/service/database.dart';
import 'package:fooddie/widgets/widget_support.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class AddFood extends StatefulWidget {
  const AddFood({super.key});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController detailcontroller = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage = File(image.path);
      setState(() {});
    }
  }

  uploadItem() async {
    if (selectedImage != null &&
        namecontroller.text != "" &&
        pricecontroller != "" &&
        detailcontroller != "") {
      String addId = randomAlphaNumeric(10);

      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child("blogImages").child(addId);
      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);
      var downloadUrl = await (await task).ref.getDownloadURL();
      Map<String, dynamic> addItem = {
        "Image": downloadUrl,
        "name": namecontroller.text,
        "price": pricecontroller.text,
        "detail": detailcontroller.text
      };
      await DatabaseMethods().addFoodItem(addItem, value!).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.black,
            content: Text(
              "Food Item has been added succesfully",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        );
      });
    }
  }
  // Future<void> uploadItem() async {
  //   if (selectedImage != null &&
  //       namecontroller.text.isNotEmpty &&
  //       pricecontroller.text.isNotEmpty &&
  //       detailcontroller.text.isNotEmpty) {
  //     String addId = randomAlphaNumeric(20);

  //     Reference firebaseStorageRef =
  //         FirebaseStorage.instance.ref().child("blogImages").child(addId);
  //     UploadTask task = firebaseStorageRef.putFile(selectedImage!);
  //     TaskSnapshot taskSnapshot = await task;

  //     if (taskSnapshot.state == TaskState.success) {
  //       String downloadUrl = await taskSnapshot.ref.getDownloadURL();

  //       Map<String, dynamic> addItem = {
  //         "Image": downloadUrl,
  //         "name": namecontroller.text,
  //         "price": pricecontroller.text,
  //         "detail": detailcontroller.text
  //       };

  //       // Now you can proceed to add the item to your database or perform any other necessary tasks.
  //     } else {
  //       // Handle the case where the upload task fails.
  //       print("Upload failed");
  //     }
  //   } else {
  //     // Handle the case where one or more required fields are empty.
  //     print("Please fill in all fields and select an image");
  //   }
  // }

  String? value;
  final List<String> items = ['Ice-cream', 'Pizza', 'Salad', 'Burger'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Color(0xff373866),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Add Item",
          style: AppWidget.headlineTextFieldStyle(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(
            top: 20,
            bottom: 50,
            left: 20,
            right: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Upload the Item Snap",
                style: AppWidget.semiBoldTextFieldStyle(),
              ),
              const SizedBox(
                height: 20,
              ),
              selectedImage == null
                  ? GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: Center(
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(
                              selectedImage!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Item Name",
                style: AppWidget.semiBoldTextFieldStyle(),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: Color(0xffececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: namecontroller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter item Name",
                      hintStyle: AppWidget.lightlineTextFieldStyle()),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Item Price",
                style: AppWidget.semiBoldTextFieldStyle(),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: Color(0xffececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: pricecontroller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter item Price",
                      hintStyle: AppWidget.lightlineTextFieldStyle()),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Item Details",
                style: AppWidget.semiBoldTextFieldStyle(),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: Color(0xffececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  maxLines: 6,
                  controller: detailcontroller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Describe the food taste",
                      hintStyle: AppWidget.lightlineTextFieldStyle()),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Food Menu",
                style: AppWidget.semiBoldTextFieldStyle(),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xffececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    items: items
                        .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            )))
                        .toList(),
                    onChanged: ((value) => setState(() {
                          this.value = value;
                        })),
                    dropdownColor: Colors.white,
                    hint: Text("Select Category"),
                    iconSize: 36,
                    borderRadius: BorderRadius.circular(5),
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    value: value,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  uploadItem();
                },
                child: Center(
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      width: 190,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Add",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
