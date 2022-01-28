import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            child: ListView(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Title'),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_priceFocusNode);
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
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              focusNode: _descriptionFocusNode,
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
                          child: Image.network(_imageUrlTextController.text),
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
