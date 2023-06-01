import 'package:deuscurat_admin/Commons/colors.dart';
import 'package:deuscurat_admin/Commons/dimens.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({Key? key,required this.videoUrl}) : super(key: key);
  final String videoUrl;
  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}


class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..addListener(() {
        final bool isPlaying = _controller.value.isPlaying;
        if (isPlaying != _isPlaying) {
          setState(() {
            _isPlaying = isPlaying;
          });
        }

        if (_controller.value.position >= _controller.value.duration) {
          setState(() {
            _isPlaying = false;
          });
          Navigator.pop(context);
        }
      })
      ..setLooping(false)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int? secondsRemaining;
    if (_controller.value.isInitialized) {
      final Duration duration = _controller.value.duration;
      final int secondsPlayed = _controller.value.position.inSeconds;
      secondsRemaining = duration.inSeconds - secondsPlayed;
    }
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(onPressed: (){
              _isPlaying = false;
              _controller.pause();
              Navigator.pop(context);

            }, icon: Icon(Icons.close,color: kOrangeColor,))
          ],),),
      body: Center(
          child: _controller.value.isInitialized ?
          Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),


              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.05,
                color: Colors.black,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        InkWell(
                          child: Icon(
                            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Colors.white,
                            size: 50,
                          ),
                          onTap: () {
                            setState(() {
                              if (_controller.value.isPlaying) {
                                _controller.pause();
                              } else {
                                _controller.play();
                              }
                            });
                          },
                        ),
                        Text("${_printDuration(_controller.value.position)} / ${_printDuration(Duration(seconds: secondsRemaining!))}",
                          style: TextStyle(color: Colors.red,fontSize: kFontSize12),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 44,
                left: 0,
                right: 0,
                child: VideoProgressIndicator(
                  _controller,
                  allowScrubbing: true,
                  colors:  VideoProgressColors(
                    playedColor: kOrangeColor,
                    bufferedColor: Colors.grey,
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          )
              : const Center(child: CircularProgressIndicator())
      ),



    );
  }
}

String _printDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${duration.inHours}:$twoDigitMinutes:$twoDigitSeconds";
}

/*
 AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                      VideoPlayer(_controller),
                      _isPlaying
                      ? Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.05,
                        color: Colors.black,
                        child: Center(
                          child: InkWell(
                            hoverColor: whiteColor,
                            onTap: () {
                              setState(() {
                                _isPlaying = false;
                                _controller.pause();
                              });
                            },
                            child: Icon(
                              Icons.pause,
                              color: mainColor,
                              size: 50.0,
                            ),
                          ),
                        ),
                      )
                          : Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        color: Colors.black,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: InkWell(
                      onTap: () {
                      setState(() {
                      _isPlaying = true;
                      _controller.play();
                      });
                      },
                      child: Icon(
                      Icons.play_arrow,
                      color: mainColor,
                      size: 50.0,
                      ),
                      ),
                            ),
                          ),
                      ],
                      ))
* */