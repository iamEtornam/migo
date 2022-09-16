import 'package:flutter/material.dart';
import 'package:migo/view/responsive.dart';
import 'package:migo/widgets/product_link_opener.dart';

class ProductCard extends StatelessWidget {
  final int price;
  final String name;
  final int quantity;
  final String url;
  const ProductCard({
    Key? key,
    required this.price,
    required this.name,
    required this.url,
    this.quantity = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Responsive.isDesktop(context)
          ? (MediaQuery.of(context).size.width - 100) / 3
          : 315,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Image.asset(
                        "assets/mi_watch_img.png",
                        scale: Responsive.isMobile(context) ? 1 : 1.5,
                      ),
                    ],
                  ),
                  Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.w800, fontSize: 28),
                  ),
                  Row(
                    children: [
                      const Text(
                        "Price: ",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 22),
                      ),
                      Text(
                        "₹" + price.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 28),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Variants: ",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 22),
                        ),
                        Row(
                          children: const [
                            VariantCircle(),
                            VariantCircle(),
                            VariantCircle(),
                          ],
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Amount in Stock: " + quantity.toString(),
                        style: const TextStyle(
                          color: Color(0xffB9B7FF),
                          fontSize: 18,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          ProductDescriptionLinkOpener(url: url),
        ],
      ),
    );
  }
}

class VariantCircle extends StatelessWidget {
  const VariantCircle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: 36,
      margin: const EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xffFF6900), width: 2.0),
      ),
    );
  }
}
