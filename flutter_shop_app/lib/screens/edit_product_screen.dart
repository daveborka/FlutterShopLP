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
  var isLoading = false;
  Product _editedProduct = Product(
      id: null, title: null, description: null, price: null, imageUrl: null);

  var _isInit = true;
  var initValue = {
    'title': '',
    'price': '',
    'description': '',
    'imageUrl': '',
  };
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

  @override
  void didChangeDependencies() {
    if (_isInit) {
      var routeArg = ModalRoute.of(context).settings.arguments as String;
      if (routeArg != null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findById(routeArg);
        initValue['title'] = _editedProduct.title;
        initValue['price'] = _editedProduct.price.toString();
        initValue['description'] = _editedProduct.description;
        _imageUrlTextController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void updateImageUrl() {
    if (!_imageFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var productContainer = Provider.of<Products>(context);

    Future<void> _saveForm() async {
      final isValid = _fomrKey.currentState.validate();
      if (!isValid) {
        return;
      }
      setState(() {
        isLoading = true;
      });
      _fomrKey.currentState.save();
      try {
        if (_editedProduct.id != null) {
          await productContainer.updateProduct(
              _editedProduct.id, _editedProduct);
        } else {
          await productContainer.addProduct(_editedProduct);
        }
      } catch (error) {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('Error Occurred'),
                  content: Text('Something went wrong'),
                  actions: [
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'))
                  ],
                ));
      } finally {
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pop();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [IconButton(onPressed: _saveForm, icon: Icon(Icons.save))],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                  key: _fomrKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        initialValue: initValue['title'],
                        decoration: InputDecoration(labelText: 'Title'),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_priceFocusNode);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please provide a value';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _editedProduct = Product(
                              title: newValue,
                              id: _editedProduct.id,
                              description: _editedProduct.description,
                              price: _editedProduct.price,
                              imageUrl: _editedProduct.imageUrl,
                              isFavorite: _editedProduct.isFavorite);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        initialValue: initValue['price'],
                        decoration: InputDecoration(labelText: 'Price'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _priceFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_descriptionFocusNode);
                        },
                        onSaved: (newValue) {
                          _editedProduct = Product(
                              title: _editedProduct.title,
                              id: _editedProduct.id,
                              description: _editedProduct.description,
                              price: double.parse(newValue),
                              imageUrl: _editedProduct.imageUrl,
                              isFavorite: _editedProduct.isFavorite);
                        },
                        validator: (value) {
                          double price = double.tryParse(value);
                          if (price == null) {
                            return "Please provide me numbers only.";
                          }
                          if (price <= 0.0) {
                            return "The price should be greater than zero.";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        initialValue: initValue['description'],
                        decoration: InputDecoration(labelText: 'Description'),
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        focusNode: _descriptionFocusNode,
                        onSaved: (newVal) {
                          _editedProduct = Product(
                              title: _editedProduct.title,
                              id: _editedProduct.id,
                              description: newVal,
                              price: _editedProduct.price,
                              imageUrl: _editedProduct.imageUrl,
                              isFavorite: _editedProduct.isFavorite);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a description';
                          }

                          if (value.length < 10) {
                            return 'The description shoul be at least 10 character long.';
                          }

                          return null;
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
                                : Image.network(_imageUrlTextController.text),
                            width: 100,
                            height: 100,
                            margin: EdgeInsets.only(top: 8, right: 10),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Image url'),
                                keyboardType: TextInputType.url,
                                textInputAction: TextInputAction.done,
                                controller: _imageUrlTextController,
                                onSaved: (val) {
                                  _editedProduct = Product(
                                      title: _editedProduct.title,
                                      id: _editedProduct.id,
                                      description: _editedProduct.description,
                                      price: _editedProduct.price,
                                      imageUrl: val,
                                      isFavorite: _editedProduct.isFavorite);
                                },
                                onFieldSubmitted: (_) => _saveForm(),
                                onEditingComplete: () {
                                  setState(() {});
                                },
                                focusNode: _imageFocusNode,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter an image URL';
                                  }

                                  if (!value.startsWith('http') &&
                                      !value.startsWith('https')) {
                                    return 'Please enter a valid image URL';
                                  }

                                  if (!value.endsWith('jpg') &&
                                      !value.endsWith('png')) {
                                    return 'Please enter a valid image URL';
                                  }
                                  return null;
                                },
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
