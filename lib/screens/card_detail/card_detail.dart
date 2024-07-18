import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../card_edit/card_edit.models.dart';
import 'card_detail_presenter.dart';

class CardDetail extends StatelessWidget {
  const CardDetail({super.key, required this.card});

  final CardDetailModel card;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        cardDetailParamsProvider.overrideWithValue(card),
        cardDetailPresProvider,
      ],
      child: const _CardDetail(),
    );
  }
}

class _CardDetail extends ConsumerStatefulWidget {
  const _CardDetail({super.key});

  @override
  ConsumerState<_CardDetail> createState() => _CardDetailState();
}

class _CardDetailState extends ConsumerState<_CardDetail>
    with WidgetsBindingObserver {
  final webViewKey = GlobalKey();
  final dateFormat = DateFormat('HH:mm:ss');

  InAppWebViewController? webViewController;
  String url = "";
  double progress = 0;

  bool canPop = false;

  @override
  void initState() {
    super.initState();
    presenter = ref.read(cardDetailPresProvider.notifier);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    webViewController?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      presenter.startCountdown();
    } else {
      presenter.pauseCountdown();
    }
  }

  late CardDetailPres presenter;

  @override
  Widget build(BuildContext context) {
    final params = ref.read(cardDetailParamsProvider);

    return PopScope(
      canPop: canPop,
      onPopInvoked: (didPop) async {
        final canGoback = await webViewController?.canGoBack() ?? false;

        if (!canPop && canGoback) {
          webViewController?.goBack();
        } else {
          setState(() {
            canPop = true;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              SchedulerBinding.instance.addPostFrameCallback(
                (timeStamp) => context.pop(),
              );
            },
            icon: const Icon(Icons.close),
          ),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            mainAxisSize: MainAxisSize.min,
            textBaseline: TextBaseline.alphabetic,
            children: [
              const Expanded(
                child: Text(
                  'Facebook',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Consumer(
                builder: (context, ref, child) {
                  final timeLeft = ref.watch(cardDetailPresProvider.select(
                    (value) => value.timeLeft,
                  ));

                  return Text(
                    dateFormat.format(DateTime(0, 0, 0, 0, 0, timeLeft)),
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  );
                },
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () => webViewController?.reload(),
              icon: const Icon(Icons.refresh),
            ),
            const SizedBox(width: 16),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(14),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                url,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: [
                    InAppWebView(
                      key: webViewKey,
                      initialUrlRequest: URLRequest(url: WebUri(params.url)),
                      initialSettings: InAppWebViewSettings(
                        isInspectable: kDebugMode,
                        mediaPlaybackRequiresUserGesture: false,
                        allowsInlineMediaPlayback: true,
                        iframeAllowFullscreen: true,
                      ),
                      onWebViewCreated: (controller) {
                        webViewController = controller;
                        presenter.startCountdown();
                      },
                      onLoadStart: (controller, url) {
                        setState(() {
                          this.url = url.toString();
                        });
                      },
                      onPermissionRequest: (controller, request) async =>
                          PermissionResponse(
                        resources: request.resources,
                        action: PermissionResponseAction.GRANT,
                      ),
                      shouldOverrideUrlLoading:
                          (controller, navigationAction) async {
                        var uri = navigationAction.request.url!;

                        if (![
                          "http",
                          "https",
                          "file",
                          "chrome",
                          "data",
                          "javascript",
                          "about"
                        ].contains(uri.scheme)) {
                          if (await canLaunchUrl(uri)) {
                            // Launch the App
                            await launchUrl(uri);
                            // and cancel the request
                            return NavigationActionPolicy.CANCEL;
                          }
                        }

                        return NavigationActionPolicy.ALLOW;
                      },
                      onLoadStop: (controller, url) async {
                        setState(() {
                          this.url = url.toString();
                        });
                      },
                      onProgressChanged: (controller, progress) {
                        setState(() {
                          this.progress = progress / 100;
                        });
                      },
                      onUpdateVisitedHistory:
                          (controller, url, androidIsReload) {
                        setState(() {
                          this.url = url.toString();
                        });
                      },
                      onConsoleMessage: (controller, consoleMessage) {
                        if (kDebugMode) {
                          print(consoleMessage);
                        }
                      },
                    ),
                    progress < 1.0
                        ? LinearProgressIndicator(value: progress)
                        : Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
