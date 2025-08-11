import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';
import '../models/product.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteToggle;
  final double? width;
  final double? height;
  final Color cardColor;
  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onFavoriteToggle,
    this.width,
    this.height,
    required this.cardColor,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.product.isFavorite;
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    widget.onFavoriteToggle?.call();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.width ?? 159,
        height: widget.height ?? 281,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: widget.cardColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image with Favorite Button
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  color: colorScheme.surface,
                ),
                child: Stack(
                  children: [
                    // Product Image
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      child:
                          widget.product.imageUrls != null
                              ? Image.network(
                                widget.product.imageUrls![0],
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return _buildPlaceholder();
                                },
                              )
                              : _buildPlaceholder(),
                    ),
                    // Favorite Button
                    Positioned(
                      top: 9,
                      right: 16,
                      child: GestureDetector(
                        onTap: _toggleFavorite,
                        child: Icon(
                          _isFavorite
                              ? IconsaxPlusBold.heart
                              : IconsaxPlusBroken.heart,
                          color:
                              _isFavorite
                                  ? Colors.red
                                  : colorScheme.onSurface.withOpacity(0.7),
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Product Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Product Name
                  Text(
                    widget.product.name.length > 25
                        ? '${widget.product.name.substring(0, 25)}...'
                        : widget.product.name,
                    style: AppTextStyles.subTitle2(isDarkMode),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // Price Section
                  Row(
                    children: [
                      Text(
                        '\$${widget.product.price.toStringAsFixed(2)}',
                        style: AppTextStyles.heading6(isDarkMode),
                      ),
                      if (widget.product.isOnSale) ...[
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            '\$${widget.product.originalPrice!.toStringAsFixed(2)}',
                            style: AppTextStyles.faintGrey2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;

        return Container(
          width: double.infinity,
          height: double.infinity,
          color: colorScheme.surface,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.image_outlined,
                size: 48,
                color: colorScheme.onSurface.withValues(alpha: 0.4),
              ),
              const SizedBox(height: 8),
              const Text(
                'No Image',
                style: AppTextStyles.faintGrey2,
              ),
            ],
          ),
        );
      },
    );
  }
}
