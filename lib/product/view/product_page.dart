// ignore_for_file: library_private_types_in_public_api, avoid_print, unused_local_variable, unnecessary_string_interpolations, avoid_returning_null_for_void, unnecessary_null_comparison

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:bravo_bazzar_flutter_case_project/product/model/product_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:photo_view/photo_view.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../constants.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  String socketUrl = 'wss://api.bravoshopgo.com/ws/api/v1/?token=$accessToken';
  WebSocketChannel? channel;
  ProductResponseModel? productModel;
  List<ProductColors>? productImageList;

  @override
  void initState() {
    channel = IOWebSocketChannel.connect(Uri.parse(socketUrl), headers: {
      'Origin': 'https://api.bravoshopgo.com',
    });
    Map<String, dynamic> data = {
      "service": "trendyol",
      "product_url":
          "https://www.trendyol.com/bigdart/3900-oversize-uzun-basic-gomlek-kahverengi-p-241723910"
    };
    final json = jsonEncode(data);
    channel?.sink.add(json);
    super.initState();
  }

  ProductResponseModel convertData(String data) {
    final model = ProductResponseModel.fromJson(jsonDecode(data));
    productImageList = model.data?.productColors;
    return model;
  }

  ProductColors? selectedImage;
  bool isSelected = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: SvgPicture.network('${productModel?.data?.brandLogo}'),
        //actions: [SvgPicture.network('${productModel?.data?.brandLogo}')],
      ),

      body: StreamBuilder(
          stream: channel?.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              productModel = convertData(snapshot.data!);

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 350,
                        width: 200,
                        child: PhotoView(
                          backgroundDecoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onSurface),
                          imageProvider: selectedImage != null
                              ? NetworkImage('${selectedImage?.image}')
                              : NetworkImage(
                                  '${productModel?.data?.productColors![0].image}'),
                          minScale: 0.2,
                          maxScale: 0.8,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Text('${productModel?.data?.productName}',
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: List.generate(
                              productModel!.data!.productSizes!.length,
                              (index) => Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: OutlinedButton(
                                    onPressed: null,
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0))),
                                    ),
                                    child: Text(
                                        '${productModel!.data!.productSizes![index].size}',
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.purple)),
                                  )))),
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                              productModel!.data!.productColors!.length,
                              (index) => GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedImage =
                                            productImageList![index];
                                        isSelected = true;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        height: 150,
                                        width: 100,
                                        fadeInCurve: Curves.easeInQuart,
                                        imageUrl:
                                            productImageList?[index].image ?? '',
                                        placeholder: (context, url) {
                                          return const Center(
                                              child: CircularProgressIndicator(
                                                  strokeWidth: 1));
                                        },
                                        errorWidget: (context, url, error) {
                                          return Center(
                                            child: Image.asset(
                                              'asset/image/ShopGo_logo.png',
                                              scale: 5,
                                            ),
                                          );
                                        },
                                      ),

                                      // Image.network(
                                      //     '${productModel!.data!.productColors![index].image ?? ''}'),
                                    ),
                                  ))),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Theme.of(context).colorScheme.primary,
          label: const Text(
            'Add To Cart',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          icon: const Icon(Icons.add, size: 30, color: Colors.white),
          onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(13.0))),
                  content: const SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text('The product has been added to your cart.',
                            style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Ok', style: TextStyle(fontSize: 18)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              })),
      
    );
  }
}
