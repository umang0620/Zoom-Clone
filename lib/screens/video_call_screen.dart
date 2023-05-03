import 'package:flutter/material.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import '../resource/jitsi_meet_methods.dart';
import '../resource/auth.methods.dart';
import '../utils/colors.dart';
import '../widgets/meeting_options.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({Key? key}) : super(key: key);

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final AuthMethods _authMethods  = AuthMethods();
  late TextEditingController meetingIdcontroller;
  late TextEditingController namecontroller;
  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();

  bool isAudioMuted = true;
  bool isVideoMuted = true;


  @override
  void initState() {
   meetingIdcontroller = TextEditingController();
   namecontroller = TextEditingController(text: _authMethods.user.displayName);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    meetingIdcontroller.dispose();
    namecontroller.dispose();
   // JitsiMeetingListener.removeAllListerners();
  }

  _joinMeeting() {
    _jitsiMeetMethods.createMeeting(
      roomName: meetingIdcontroller.text,
      isVideomuted: isVideoMuted,
      username: namecontroller.text,
      isAudiomuted: isAudioMuted,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        title: const Text('Join a Meeting',
            style:TextStyle(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Column(children: [
        SizedBox(
          height: 60,
          child: TextField(
            controller: meetingIdcontroller,
            maxLines: 1,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              fillColor: secondaryBackgroundColor,
              filled: true,
              border: InputBorder.none,
              hintText: 'Room ID',
              contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0),
            ),
          ),
        ),
        SizedBox(
          height: 60,
          child: TextField(
            controller: namecontroller,
            maxLines: 1,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              fillColor: secondaryBackgroundColor,
              filled: true,
              border: InputBorder.none,
              hintText: 'Name',
              contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0),
            ),
          ),
        ),
        const SizedBox(height: 20,),
        InkWell(
          onTap: _joinMeeting,
          child: const Padding(padding: EdgeInsets.all(8),
            child: Text('Join',style: TextStyle(fontSize: 16),),
          ),
        ),
        const SizedBox(height: 20,),
        MeetingOption(
          text: 'Mute Audio',
          isMute: isAudioMuted,
          onChange: onAudioMuted,
        ),
        MeetingOption(text: 'Turn off My Video',
          isMute: isVideoMuted,
          onChange: onVideoMuted,
        ),
      ],
      ),
    );
  }

  onAudioMuted(bool val) {
    setState(() {
      isAudioMuted = val;
    });
  }

  onVideoMuted(bool val) {
    setState(() {
      isVideoMuted = val;
    });
  }
}
