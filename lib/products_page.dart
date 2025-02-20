import 'package:flutter/material.dart';
import 'http_service.dart';
import 'product_model.dart';

class ProductsPage extends StatelessWidget {
  final HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: httpService.getProducts(),
          builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
            if (snapshot.hasData) {
              List<Product> products = snapshot.data!;
              return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  Product product = products[index];
                  return Card(
                    elevation: 4.0,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      title: Text(
                        product.name ?? "No Name",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Price: ${product.price ?? "N/A"}"),
                          Text("Stock: ${product.stock ?? "N/A"}"),
                          Text("Description: ${product.description ?? "No description"}"),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  "An error occurred: ${snapshot.error}",
                  style: TextStyle(color: Colors.red),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}