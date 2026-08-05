import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/chat_video_player_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class FullScreenVideoPlayerScreen extends StatefulWidget {
  final String videoPath;
  final bool isLocal;

  const FullScreenVideoPlayerScreen({
    super.key,
    required this.videoPath,
    this.isLocal = false,
  });

  @override
  State<FullScreenVideoPlayerScreen> createState() =>
      _FullScreenVideoPlayerScreenState();
}

class _FullScreenVideoPlayerScreenState
    extends State<FullScreenVideoPlayerScreen> {
  VideoPlayerController? _controller;
  bool _isInitializing = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    setState(() {
      _isInitializing = true;
      _errorMessage = null;
    });

    _controller?.removeListener(_onVideoTick);
    await _controller?.dispose();
    _controller = null;

    try {
      final controller = await ChatVideoPlayerHelper.createController(
        sourcePath: widget.videoPath,
        isLocal: widget.isLocal,
      );
      controller.setLooping(false);
      controller.addListener(_onVideoTick);

      if (!mounted) {
        controller.removeListener(_onVideoTick);
        await controller.dispose();
        return;
      }

      setState(() {
        _controller = controller;
        _isInitializing = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isInitializing = false;
        _errorMessage = 'Unable to play this video.';
      });
    }
  }

  @override
  void dispose() {
    final controller = _controller;
    if (controller != null) {
      controller.removeListener(_onVideoTick);
      controller.pause();
      controller.dispose();
    }
    super.dispose();
  }

  void _onVideoTick() {
    if (mounted) setState(() {});
  }

  void _togglePlayback() {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return;

    setState(() {
      if (controller.value.isPlaying) {
        controller.pause();
      } else {
        controller.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        foregroundColor: AppColors.white,
        title: const Text('Video'),
      ),
      body: Center(
        child: _isInitializing
            ? const CircularProgressIndicator(color: AppColors.orange)
            : _errorMessage != null
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _errorMessage!,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 14.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        16.verticalSpace,
                        TextButton(
                          onPressed: _initializePlayer,
                          child: const Text(
                            'Retry',
                            style: TextStyle(color: AppColors.orange),
                          ),
                        ),
                      ],
                    ),
                  )
                : _buildPlayer(),
      ),
    );
  }

  Widget _buildPlayer() {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: _togglePlayback,
      child: Stack(
        alignment: Alignment.center,
        children: [
          RepaintBoundary(
            child: AspectRatio(
              aspectRatio: controller.value.aspectRatio == 0
                  ? 16 / 9
                  : controller.value.aspectRatio,
              child: VideoPlayer(controller),
            ),
          ),
          if (!controller.value.isPlaying)
            Container(
              decoration: BoxDecoration(
                color: AppColors.black.withValues(alpha: 0.45),
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(16.w),
              child: Icon(
                Icons.play_arrow_rounded,
                color: AppColors.white,
                size: 48.sp,
              ),
            ),
        ],
      ),
    );
  }
}
