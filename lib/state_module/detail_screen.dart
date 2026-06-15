import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'product_model.dart';
import 'url_utill.dart'; 

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.item});

  final ProductModel item;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  
  
  
  
  
  
  final _urlUtil = UrlUtil();
  
  
  

  
  
  
  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: FilledButton.icon(
              onPressed: () {
                const phone = "+85568733380";
                _urlUtil.open("tel:$phone");
              },
              label: const Text("Contact Seller"),
              icon: const Icon(Icons.call),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: FilledButton.icon(
              onPressed: () {
                const map = "https://www.google.com/maps/place/%E1%9E%95%E1%9F%92%E1%9E%9F%E1%9E%B6%E1%9E%9A%E1%9E%92%E1%9F%86%E1%9E%90%E1%9F%92%E1%9E%98%E1%9E%B8/@11.5708512,104.9212477,907m"; 
                _urlUtil.open(map);
              },
              label: const Text("Find Location"),
              icon: const Icon(Icons.pin_drop),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return Scaffold(
      appBar: AppBar(title: Text(item.title)),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // 1. Slideshow at the top
            _buildSlideshow(item.images),

            // 2. Title Card (Moved above the buttons)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Card(
                child: ListTile(
                  leading: const FaIcon(FontAwesomeIcons.cartShopping),
                  title: Text(item.title),
                ),
              ),
            ),

            // 3. Action Buttons Row (Placed right below the title)
            _buildContent(),
            
            const SizedBox(height: 4),

            // 4. Description Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Card(
                child: ListTile(
                  title: Text(item.description),
                ),
              ),
            ),

            // 5. Price Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Card(
                child: ListTile(
                  leading: const FaIcon(FontAwesomeIcons.dollarSign),
                  title: Text("USD ${item.price.toStringAsFixed(2)}"),
                ),
              ),
            ),

            // 6. Category Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Card(
                child: ListTile(
                  leading: const Icon(Icons.text_fields),
                  title: Text("In ${item.category.name} Category"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  






  Widget _buildSlideshow(List<String> images) {
    if (images.isEmpty) return const SizedBox.shrink();

    return CarouselSlider.builder(
      itemCount: images.length,
      options: CarouselOptions(aspectRatio: 4 / 3, viewportFraction: 0.8),
      itemBuilder: (context, index, viewIndex) {
        final imageUrl = images[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (_, _) => Container(color: Colors.grey),
              errorWidget: (_, _, _) => Container(color: Colors.grey.shade800),
              width: double.maxFinite,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}