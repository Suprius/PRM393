import 'package:flutter/material.dart';

import '../../models/product.dart';

const productBlue = Color(0xFF0074CC);
const productRed = Color(0xFFE9303A);

String formatPrice(double price) => '\$${price.toStringAsFixed(2)}';

class ProductImage extends StatelessWidget {
  const ProductImage({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) => Image.asset(
    product.image,
    fit: BoxFit.contain,
    semanticLabel: product.name,
    errorBuilder: (_, error, stackTrace) => const Center(
      child: Icon(Icons.image_not_supported_outlined, color: Colors.grey),
    ),
  );
}

class DiscountBadge extends StatelessWidget {
  const DiscountBadge({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
    decoration: BoxDecoration(
      color: productRed,
      borderRadius: BorderRadius.circular(5),
    ),
    child: Text(
      '-${product.discountPercen.toStringAsFixed(0)}%',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 11,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

class ProductPrice extends StatelessWidget {
  const ProductPrice({super.key, required this.product, this.large = false});
  final Product product;
  final bool large;

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 6,
    runSpacing: 2,
    crossAxisAlignment: WrapCrossAlignment.center,
    children: [
      if (product.discountPercen > 0)
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            formatPrice(product.price),
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: large ? 17 : 12,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ),
      FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          formatPrice(product.discountedPrice),
          style: TextStyle(
            color: productRed,
            fontSize: large ? 23 : 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ],
  );
}

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key, required this.product, required this.onTap});
  final Product product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Card(
    margin: EdgeInsets.zero,
    elevation: 2,
    shadowColor: Colors.black26,
    surfaceTintColor: Colors.transparent,
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(flex: 3, child: ProductImage(product: product)),
            const SizedBox(width: 10),
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (product.discountPercen > 0)
                    Align(
                      alignment: Alignment.centerRight,
                      child: DiscountBadge(product: product),
                    ),
                  const SizedBox(height: 4),
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  ProductPrice(product: product),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
