// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ecommerce_app/widget_book/widget_book_usecases/ai_chat_usecase.dart'
    as _ecommerce_app_widget_book_widget_book_usecases_ai_chat_usecase;
import 'package:ecommerce_app/widget_book/widget_book_usecases/cart_usecase.dart'
    as _ecommerce_app_widget_book_widget_book_usecases_cart_usecase;
import 'package:ecommerce_app/widget_book/widget_book_usecases/details_usecase.dart'
    as _ecommerce_app_widget_book_widget_book_usecases_details_usecase;
import 'package:ecommerce_app/widget_book/widget_book_usecases/login_usecase.dart'
    as _ecommerce_app_widget_book_widget_book_usecases_login_usecase;
import 'package:ecommerce_app/widget_book/widget_book_usecases/onboarding_usecase.dart'
    as _ecommerce_app_widget_book_widget_book_usecases_onboarding_usecase;
import 'package:ecommerce_app/widget_book/widget_book_usecases/profile_usecase.dart'
    as _ecommerce_app_widget_book_widget_book_usecases_profile_usecase;
import 'package:ecommerce_app/widget_book/widget_book_usecases/register_usecase.dart'
    as _ecommerce_app_widget_book_widget_book_usecases_register_usecase;
import 'package:widgetbook/widgetbook.dart' as _widgetbook;

final directories = <_widgetbook.WidgetbookNode>[
  _widgetbook.WidgetbookFolder(
    name: 'features',
    children: [
      _widgetbook.WidgetbookFolder(
        name: 'ai_shopping',
        children: [
          _widgetbook.WidgetbookFolder(
            name: 'presentation',
            children: [
              _widgetbook.WidgetbookFolder(
                name: 'screen',
                children: [
                  _widgetbook.WidgetbookComponent(
                    name: 'AiChatScreen',
                    useCases: [
                      _widgetbook.WidgetbookUseCase(
                        name: 'Default',
                        builder:
                            _ecommerce_app_widget_book_widget_book_usecases_ai_chat_usecase
                                .loginScreenUseCase,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'authentication',
        children: [
          _widgetbook.WidgetbookFolder(
            name: 'presentation',
            children: [
              _widgetbook.WidgetbookFolder(
                name: 'screens',
                children: [
                  _widgetbook.WidgetbookComponent(
                    name: 'LoginScreen',
                    useCases: [
                      _widgetbook.WidgetbookUseCase(
                        name: 'Default',
                        builder:
                            _ecommerce_app_widget_book_widget_book_usecases_login_usecase
                                .loginScreenUseCase,
                      ),
                    ],
                  ),
                  _widgetbook.WidgetbookComponent(
                    name: 'SignUp',
                    useCases: [
                      _widgetbook.WidgetbookUseCase(
                        name: 'Default',
                        builder:
                            _ecommerce_app_widget_book_widget_book_usecases_register_usecase
                                .loginScreenUseCase,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'cart',
        children: [
          _widgetbook.WidgetbookFolder(
            name: 'presentation',
            children: [
              _widgetbook.WidgetbookFolder(
                name: 'screens',
                children: [
                  _widgetbook.WidgetbookComponent(
                    name: 'Cart',
                    useCases: [
                      _widgetbook.WidgetbookUseCase(
                        name: 'Default',
                        builder:
                            _ecommerce_app_widget_book_widget_book_usecases_cart_usecase
                                .loginScreenUseCase,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'home',
        children: [
          _widgetbook.WidgetbookFolder(
            name: 'presentation',
            children: [
              _widgetbook.WidgetbookFolder(
                name: 'screens',
                children: [
                  _widgetbook.WidgetbookComponent(
                    name: 'ProductDetails',
                    useCases: [
                      _widgetbook.WidgetbookUseCase(
                        name: 'Default',
                        builder:
                            _ecommerce_app_widget_book_widget_book_usecases_details_usecase
                                .productDetailsUseCase,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'onboarding',
        children: [
          _widgetbook.WidgetbookFolder(
            name: 'presentation',
            children: [
              _widgetbook.WidgetbookFolder(
                name: 'screens',
                children: [
                  _widgetbook.WidgetbookComponent(
                    name: 'Onboarding',
                    useCases: [
                      _widgetbook.WidgetbookUseCase(
                        name: 'Default',
                        builder:
                            _ecommerce_app_widget_book_widget_book_usecases_onboarding_usecase
                                .loginScreenUseCase,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'profile',
        children: [
          _widgetbook.WidgetbookFolder(
            name: 'presentation',
            children: [
              _widgetbook.WidgetbookFolder(
                name: 'screens',
                children: [
                  _widgetbook.WidgetbookComponent(
                    name: 'Profile',
                    useCases: [
                      _widgetbook.WidgetbookUseCase(
                        name: 'Default',
                        builder:
                            _ecommerce_app_widget_book_widget_book_usecases_profile_usecase
                                .loginScreenUseCase,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  ),
];
