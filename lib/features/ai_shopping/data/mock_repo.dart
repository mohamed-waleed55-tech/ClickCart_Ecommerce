import 'package:ecommerce_app/features/ai_shopping/data/ai_repo.dart';
import 'package:ecommerce_app/features/ai_shopping/data/ai_shopping_response.dart';

/// Development-only smart mock.
///
/// This repository simulates the behavior of the real AI service
/// without consuming any API quota.
class AiAssistantMockRepositoryImp implements AiAssistantRepository {
  @override
  Future<AiShoppingResponse> getShoppingIntent(
    String userMessage,
  ) async {
    // Simulate network / AI processing delay.
    await Future.delayed(
      const Duration(milliseconds: 800),
    );

    final message = userMessage.toLowerCase().trim();

    // ─────────────────────────────────────────────
    // Price
    // ─────────────────────────────────────────────

    final maxPrice = _extractPrice(message);

    // ─────────────────────────────────────────────
    // Category detection
    // ─────────────────────────────────────────────

    final category = _detectCategory(message);

    // ─────────────────────────────────────────────
    // Search query
    // ─────────────────────────────────────────────

    final searchQuery = _buildSearchQuery(
      message: message,
      category: category,
    );

    // ─────────────────────────────────────────────
    // AI-like response
    // ─────────────────────────────────────────────

    final replyText = _buildReply(
      category: category,
      maxPrice: maxPrice,
      searchQuery: searchQuery,
    );

    return AiShoppingResponse(
      category: category,
      maxPrice: maxPrice,
      searchQuery: searchQuery,
      replyText: replyText,
    );
  }

  // ═══════════════════════════════════════════════
  // CATEGORY DETECTION
  // ═══════════════════════════════════════════════

  String _detectCategory(String message) {
    // Watches
    if (_containsAny(message, [
      'watch',
      'watches',
      'ساعة',
      'ساعه',
      'ساعات',
      'wrist watch',
    ])) {
      if (_containsAny(message, [
        'men',
        'mens',
        'man',
        'رجل',
        'رجالي',
        'رجاليه',
        'رجالية',
      ])) {
        return 'mens-watches';
      }

      if (_containsAny(message, [
        'women',
        'womens',
        'woman',
        'نسائي',
        'نسائية',
        'حريمي',
        'حريميه',
      ])) {
        return 'womens-watches';
      }

      return 'mens-watches';
    }

    // Laptops
    if (_containsAny(message, [
      'laptop',
      'laptops',
      'notebook',
      'لاب',
      'لابتوب',
      'لابتوبات',
      'كمبيوتر محمول',
    ])) {
      return 'laptops';
    }

    // Smartphones
    if (_containsAny(message, [
      'phone',
      'phones',
      'mobile',
      'smartphone',
      'موبايل',
      'موبايلات',
      'تليفون',
      'تليفونات',
      'هاتف',
      'هواتف',
    ])) {
      return 'smartphones';
    }

    // Tablets
    if (_containsAny(message, [
      'tablet',
      'tablets',
      'ipad',
      'تابلت',
      'تابلتات',
    ])) {
      return 'tablets';
    }

    // Shoes
    if (_containsAny(message, [
      'shoe',
      'shoes',
      'sneaker',
      'sneakers',
      'جزمة',
      'جزمه',
      'جزم',
      'حذاء',
      'احذية',
      'أحذية',
      'كوتشي',
    ])) {
      if (_containsAny(message, [
        'men',
        'mens',
        'man',
        'رجل',
        'رجالي',
      ])) {
        return 'mens-shoes';
      }

      if (_containsAny(message, [
        'women',
        'womens',
        'woman',
        'نسائي',
        'نسائية',
        'حريمي',
      ])) {
        return 'womens-shoes';
      }

      return 'mens-shoes';
    }

    // Bags
    if (_containsAny(message, [
      'bag',
      'bags',
      'handbag',
      'شنطة',
      'شنط',
      'حقيبة',
      'حقائب',
    ])) {
      return 'womens-bags';
    }

    // Dresses
    if (_containsAny(message, [
      'dress',
      'dresses',
      'فستان',
      'فساتين',
    ])) {
      return 'womens-dresses';
    }

    // Jewellery
    if (_containsAny(message, [
      'jewellery',
      'jewelry',
      'necklace',
      'bracelet',
      'ring',
      'مجوهرات',
      'دهب',
      'ذهب',
      'خاتم',
      'سلسلة',
      'سلسله',
      'اسورة',
      'اسوارة',
    ])) {
      return 'womens-jewellery';
    }

    // Sunglasses
    if (_containsAny(message, [
      'sunglasses',
      'glasses',
      'نظارة',
      'نظاره',
      'نظارات',
      'شمس',
    ])) {
      return 'sunglasses';
    }

    // Fragrances
    if (_containsAny(message, [
      'perfume',
      'perfumes',
      'fragrance',
      'عطر',
      'عطور',
      'برفان',
      'برفانات',
    ])) {
      return 'fragrances';
    }

    // Beauty
    if (_containsAny(message, [
      'beauty',
      'makeup',
      'مكياج',
      'ميكب',
      'تجميل',
    ])) {
      return 'beauty';
    }

    // Skin care
    if (_containsAny(message, [
      'skin',
      'skincare',
      'skin care',
      'بشرة',
      'بشره',
      'العناية بالبشرة',
      'العنايه بالبشره',
    ])) {
      return 'skin-care';
    }

    // Furniture
    if (_containsAny(message, [
      'furniture',
      'sofa',
      'chair',
      'table',
      'أثاث',
      'اثاث',
      'كنبة',
      'كنبه',
      'كرسي',
      'كرسى',
      'ترابيزة',
    ])) {
      return 'furniture';
    }

    // Groceries
    if (_containsAny(message, [
      'grocery',
      'groceries',
      'food',
      'طعام',
      'اكل',
      'أكل',
      'بقالة',
      'بقاله',
    ])) {
      return 'groceries';
    }

    // Sports
    if (_containsAny(message, [
      'sport',
      'sports',
      'football',
      'gym',
      'كرة',
      'رياضة',
      'رياضه',
      'جيم',
    ])) {
      return 'sports-accessories';
    }

    // Vehicles
    if (_containsAny(message, [
      'car',
      'cars',
      'vehicle',
      'سيارة',
      'سياره',
      'سيارات',
    ])) {
      return 'vehicle';
    }

    // Motorcycle
    if (_containsAny(message, [
      'motorcycle',
      'bike',
      'motorbike',
      'موتوسيكل',
      'موتسيكل',
      'دراجة نارية',
    ])) {
      return 'motorcycle';
    }

    // Default
    return 'all';
  }

  // ═══════════════════════════════════════════════
  // PRICE EXTRACTION
  // ═══════════════════════════════════════════════

  double? _extractPrice(String message) {
    final patterns = [
      RegExp(
        r'(?:under|below|less than|up to|maximum|max|budget)\s*(?:\$|egp|جنيه)?\s*(\d+(?:\.\d+)?)',
        caseSensitive: false,
      ),

      RegExp(
        r'(\d+(?:\.\d+)?)\s*(?:\$|egp|جنيه)',
        caseSensitive: false,
      ),

      RegExp(
        r'(?:تحت|اقل من|أقل من|حد أقصى|ميزانية)\s*(\d+(?:\.\d+)?)',
        caseSensitive: false,
      ),
    ];

    for (final pattern in patterns) {
      final match = pattern.firstMatch(message);

      if (match != null) {
        final value = double.tryParse(match.group(1)!);

        if (value != null) {
          return value;
        }
      }
    }

    return null;
  }

  // ═══════════════════════════════════════════════
  // SEARCH QUERY
  // ═══════════════════════════════════════════════

  String _buildSearchQuery({
    required String message,
    required String category,
  }) {
    switch (category) {
      case 'mens-watches':
        return 'men watch';

      case 'womens-watches':
        return 'women watch';

      case 'laptops':
        if (_containsAny(message, [
          'gaming',
          'جيمينج',
          'العاب',
          'ألعاب',
        ])) {
          return 'gaming laptop';
        }

        return 'laptop';

      case 'smartphones':
        return 'smartphone';

      case 'tablets':
        return 'tablet';

      case 'mens-shoes':
        return 'men shoes';

      case 'womens-shoes':
        return 'women shoes';

      case 'womens-bags':
        return 'women bags';

      case 'womens-dresses':
        return 'women dresses';

      case 'womens-jewellery':
        return 'women jewellery';

      case 'sunglasses':
        return 'sunglasses';

      case 'fragrances':
        return 'fragrance perfume';

      case 'skin-care':
        return 'skin care';

      case 'furniture':
        return 'furniture';

      case 'groceries':
        return 'groceries';

      case 'sports-accessories':
        return 'sports accessories';

      case 'vehicle':
        return 'vehicle';

      case 'motorcycle':
        return 'motorcycle';

      default:
        return message;
    }
  }

  // ═══════════════════════════════════════════════
  // AI RESPONSE
  // ═══════════════════════════════════════════════

  String _buildReply({
    required String category,
    required double? maxPrice,
    required String searchQuery,
  }) {
    String categoryName;

    switch (category) {
      case 'mens-watches':
        categoryName = 'ساعات رجالي';
        break;

      case 'womens-watches':
        categoryName = 'ساعات حريمي';
        break;

      case 'laptops':
        categoryName = 'لابتوبات';
        break;

      case 'smartphones':
        categoryName = 'موبايلات';
        break;

      case 'tablets':
        categoryName = 'تابلت';
        break;

      case 'mens-shoes':
        categoryName = 'أحذية رجالي';
        break;

      case 'womens-shoes':
        categoryName = 'أحذية حريمي';
        break;

      case 'womens-bags':
        categoryName = 'شنط حريمي';
        break;

      case 'womens-dresses':
        categoryName = 'فساتين حريمي';
        break;

      case 'womens-jewellery':
        categoryName = 'مجوهرات';
        break;

      case 'sunglasses':
        categoryName = 'نظارات شمسية';
        break;

      case 'fragrances':
        categoryName = 'عطور';
        break;

      case 'skin-care':
        categoryName = 'منتجات العناية بالبشرة';
        break;

      case 'furniture':
        categoryName = 'أثاث';
        break;

      case 'groceries':
        categoryName = 'منتجات غذائية';
        break;

      case 'sports-accessories':
        categoryName = 'منتجات رياضية';
        break;

      case 'vehicle':
        categoryName = 'سيارات';
        break;

      case 'motorcycle':
        categoryName = 'موتوسيكلات';
        break;

      default:
        return 'أكيد! قل لي المنتج الذي تبحث عنه وسأساعدك في العثور عليه.';
    }

    if (maxPrice != null) {
      return 'تمام! هساعدك في البحث عن $categoryName '
          'بميزانية لحد ${maxPrice.toStringAsFixed(0)} جنيه.';
    }

    return 'تمام! هساعدك في البحث عن $categoryName '
        'المناسب لاحتياجاتك.';
  }

  // ═══════════════════════════════════════════════
  // HELPERS
  // ═══════════════════════════════════════════════

  bool _containsAny(
    String message,
    List<String> keywords,
  ) {
    return keywords.any(
      (keyword) => message.contains(keyword.toLowerCase()),
    );
  }
}