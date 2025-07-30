import 'package:flutter/material.dart';
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

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 159,
        height: 281,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: widget.cardColor ?? colorScheme.surface,
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
                                widget.product.imageUrls! as String,
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
                          _isFavorite ? Icons.favorite : Icons.favorite_outline,
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
                    style: TextStyle(
                      fontFamily: 'Circular',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // Price Section
                  Row(
                    children: [
                      Text(
                        '\$${widget.product.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontFamily: 'Circular',
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      if (widget.product.isOnSale) ...[
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            '\$${widget.product.originalPrice!.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontFamily: 'Circular',
                              fontSize: 12,
                              color: colorScheme.onSurface.withOpacity(0.6),
                              decoration: TextDecoration.lineThrough,
                              decorationColor: colorScheme.onSurface
                                  .withOpacity(0.6),
                            ),
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
                color: colorScheme.onSurface.withOpacity(0.4),
              ),
              const SizedBox(height: 8),
              Text(
                'No Image',
                style: TextStyle(
                  color: colorScheme.onSurface.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
