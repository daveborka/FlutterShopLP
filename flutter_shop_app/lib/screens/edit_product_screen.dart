import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static String routeName = "/edit-product";
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlTextController = TextEditingController();
  final _imageFocusNode = FocusNode();
  final _fomrKey = GlobalKey<FormState>();

  Product _edidetProduct =
      Product(id: null, title: '', description: '', price: 0, imageUrl: '');

  @override
  void dispose() {
    // TODO: implement dispose
    _imageFocusNode.removeListener(updateImageUrl);
    _descriptionFocusNode.dispose();
    _priceFocusNode.dispose();
    _imageUrlTextController.dispose();
    _imageFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _imageFocusNode.addListener(updateImageUrl);
    // TODO: implement initState
    super.initState();
  }

  void updateImageUrl() {
    if (!_imageFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var productContainer = Provider.of<Products>(context);

    void _saveForm() {
      _fomrKey.currentState.save();
      productContainer.addProduct(_edidetProduct);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [IconButton(onPressed: _saveForm, icon: Icon(Icons.save))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _fomrKey,
            child: ListView(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  onSaved: (newValue) {
                    _edidetProduct = Product(
                        title: newValue,
                        id: null,
                        description: _edidetProduct.description,
                        price: _edidetProduct.price,
                        imageUrl: _edidetProduct.imageUrl);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Price'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  onSaved: (newValue) {
                    _edidetProduct = Product(
                        title: _edidetProduct.title,
                        id: null,
                        description: _edidetProduct.description,
                        price: double.parse(newValue),
                        imageUrl: _edidetProduct.imageUrl);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionFocusNode,
                  onSaved: (newVal) {
                    _edidetProduct = Product(
                        title: _edidetProduct.title,
                        id: null,
                        description: newVal,
                        price: _edidetProduct.price,
                        imageUrl: _edidetProduct.imageUrl);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: _imageUrlTextController.text.isEmpty
                          ? Text('Enterl a URL')
                          : FittedBox(
                              child:
                                  Image.network(_imageUrlTextController.text),
                              fit: BoxFit.fill,
                            ),
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 8, right: 10),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'Image url'),
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          controller: _imageUrlTextController,
                          onSaved: (val) {
                            _edidetProduct = Product(
                                title: _edidetProduct.title,
                                id: null,
                                description: _edidetProduct.description,
                                price: _edidetProduct.price,
                                imageUrl: val);
                          },
                          onFieldSubmitted: (_) => _saveForm(),
                          onEditingComplete: () {
                            setState(() {});
                          },
                          focusNode: _imageFocusNode,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
