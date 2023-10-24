import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class FormCreateProductView extends StatefulWidget {
  const FormCreateProductView({super.key});

  @override
  State<FormCreateProductView> createState() => _FormCreateProductViewState();
}

class _FormCreateProductViewState extends State<FormCreateProductView> {
  final GlobalKey<FormFieldState<String>> _productName =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _productPrice =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _stockQty =
      GlobalKey<FormFieldState<String>>();

  String productName = "";
  double productPrice = 0.0;
  int stockQty = 0;
  bool isSuggest = false;
  bool isPromotion = false;

  File? image;
  String filename = "keplerImage";

  Future<void> saveImageToCustomLocation(File imageData) async {
    Uint8List image = await convertImageToUint8List(imageData);
    final file = File(r'D:\Dev\Project\new_kepler_POS\assets\images\imageProducts\'+filename);
    await file.writeAsBytes(image);
  }

  Future getImage() async {
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        filename = pickedFile.name;
      } else {
        print("no image selected");
      }
    });
  }
  Future<Uint8List> convertImageToUint8List(File imageFile) async {
    Uint8List uint8list = await imageFile.readAsBytes();
    return uint8list;
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;





    return AlertDialog(
      title: const Text("Create Product"),
      content: SizedBox(
        width: 700,
        height: 450,
        child: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Product Name"),
                      SizedBox(
                        width: double.infinity,
                        height: 70,
                        child: TextFormField(
                          key: _productName,
                          controller: null,
                          initialValue: null,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ),
                      // _buildTextFormField(
                      //   key: _productName,
                      //   controller: null,
                      //   initialValue: null,
                      // ),
                      const Text("Product price"),
                      SizedBox(
                        width: double.infinity,
                        height: 70,
                        child: TextFormField(
                          key: _productPrice,
                          controller: null,
                          initialValue: null,
                          validator: (value) {
                            if (value == null || double.tryParse(value) == null) {
                              return 'price is not correct';
                            }
                            return null;
                          },
                        ),
                      ),
                      // _buildTextFormField(
                      //   key: _productPrice,
                      //   controller: null,
                      //   initialValue: null,
                      // ),
                      const Text("stock"),
                      SizedBox(
                        width: double.infinity,
                        height: 70,
                        child: TextFormField(
                          key: _stockQty,
                          controller: null,
                          initialValue: null,
                          validator: (value) {
                            if (value == null || int.tryParse(value) == null) {
                              return 'number is not correct';
                            }
                            return null;
                          },
                        ),
                      ),
                      // _buildTextFormField(
                      //   key: _stockQty,
                      //   controller: null,
                      //   initialValue: null,
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text("isSuggest"),
                            Switch(
                                value: isSuggest,
                                onChanged: (value) {
                                  setState(() {
                                    isSuggest = value;
                                  });
                                },
                                activeColor: theme.onBackground),
                            const Text("isPromotion"),
                            Switch(
                                value: isPromotion,
                                onChanged: (value) {
                                  setState(() {
                                    isPromotion = value;
                                  });
                                },
                                activeColor: theme.onBackground),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    height: 300,
                    child: Center(
                      child: image != null ? Image.file(image!,width: 200, height: 200,fit: BoxFit.cover,):
                      Image.asset('assets/images/imageProducts/noImageKeplerProduuct.png',width: 200 , height: 200 , fit: BoxFit.cover,),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async{
                      await getImage();
                    },
                    child: const Text("Change Image"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            print("DADAADADA");
            if (_productName.currentState!.validate()) {
              productName = _productName.currentState!.value.toString();
            }
            print("DADAADADA");
            if (_productPrice.currentState!.validate()) {
              productPrice = double.parse(_productPrice.currentState!.value!.toString());
            }
            print("DADAADADA");
            if (_stockQty.currentState!.validate()) {
              stockQty = int.parse(_stockQty.currentState!.value!.toString());
            }


            await saveImageToCustomLocation(image!);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.onSurface,
          ),
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
