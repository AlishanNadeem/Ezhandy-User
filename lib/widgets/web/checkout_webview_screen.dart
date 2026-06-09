import 'package:ezhandy_user/module/core/community/routing_arguments/checkout_routing_arguments.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/constant.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class CheckoutWebViewScreen extends StatefulWidget {
  const CheckoutWebViewScreen({super.key, required this.args});

  final CheckoutRoutingArguments args;

  @override
  State<CheckoutWebViewScreen> createState() => _CheckoutWebViewScreenState();
}

class _CheckoutWebViewScreenState extends State<CheckoutWebViewScreen> {
  WebViewController? _controller;
  var _loading = true;
  var _handledRedirect = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initController();
  }

  Future<void> _initController() async {
    try {
      late final PlatformWebViewControllerCreationParams params;
      if (WebViewPlatform.instance is WebKitWebViewPlatform) {
        params = WebKitWebViewControllerCreationParams(
          allowsInlineMediaPlayback: true,
          mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
        );
      } else {
        params = const PlatformWebViewControllerCreationParams();
      }

      final controller = WebViewController.fromPlatformCreationParams(params)
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(AppColors.white)
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (url) {
              if (mounted) setState(() => _loading = true);
              _handleRedirect(url);
            },
            onPageFinished: (_) {
              if (mounted) setState(() => _loading = false);
            },
            onWebResourceError: (error) {
              if (!mounted || _handledRedirect) return;
              setState(() {
                _loading = false;
                _errorMessage = error.description;
              });
            },
            onNavigationRequest: (request) {
              if (_isSuccessUrl(request.url)) {
                _onCheckoutSuccess();
                return NavigationDecision.prevent;
              }
              if (_isCancelUrl(request.url)) {
                _onCheckoutCancel();
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
            onUrlChange: (change) {
              final url = change.url;
              if (url != null) _handleRedirect(url);
            },
          ),
        );

      if (controller.platform is AndroidWebViewController) {
        AndroidWebViewController.enableDebugging(kDebugMode);
        await (controller.platform as AndroidWebViewController)
            .setMediaPlaybackRequiresUserGesture(false);
      }

      await controller.loadRequest(Uri.parse(widget.args.checkoutUrl));

      if (!mounted) return;
      setState(() => _controller = controller);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _errorMessage = e.toString();
      });
    }
  }

  bool _isSuccessUrl(String url) => _matchesRedirectUrl(url, widget.args.successUrl);

  bool _isCancelUrl(String url) => _matchesRedirectUrl(url, widget.args.cancelUrl);

  bool _matchesRedirectUrl(String currentUrl, String redirectUrl) {
    final current = Uri.tryParse(currentUrl);
    final target = Uri.tryParse(redirectUrl);
    if (current == null || target == null) return false;

    final currentPath = current.path.replaceAll(RegExp(r'/$'), '');
    final targetPath = target.path.replaceAll(RegExp(r'/$'), '');
    if (currentPath == targetPath) return true;

    return currentUrl.startsWith(redirectUrl);
  }

  void _handleRedirect(String url) {
    if (_handledRedirect) return;

    if (_isSuccessUrl(url)) {
      _onCheckoutSuccess();
      return;
    }

    if (_isCancelUrl(url)) {
      _onCheckoutCancel();
    }
  }

  void _onCheckoutSuccess() {
    if (_handledRedirect) return;
    _handledRedirect = true;

    final successRoute = widget.args.successRoute;
    AppNavigation.navigatorPop(context);

    Future.microtask(() {
      final navContext = Constants.navigatorKey.currentContext;
      if (navContext != null) {
        AppNavigation.navigateTo(navContext, successRoute);
      }
    });
  }

  void _onCheckoutCancel() {
    if (_handledRedirect) return;
    _handledRedirect = true;
    AppNavigation.navigatorPop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        top: true,
        bottom: false,
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: AppColors.orange, size: 48),
              const SizedBox(height: 16),
              CustomText(
                text: 'Unable to load checkout',
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 8),
              CustomText(
                text: _errorMessage!,
                color: AppColors.greyLight,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _errorMessage = null;
                    _loading = true;
                    _controller = null;
                    _handledRedirect = false;
                  });
                  _initController();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (_controller == null) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.orange),
      );
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        WebViewWidget(controller: _controller!),
        if (_loading)
          const Center(
            child: CircularProgressIndicator(color: AppColors.orange),
          ),
      ],
    );
  }
}
