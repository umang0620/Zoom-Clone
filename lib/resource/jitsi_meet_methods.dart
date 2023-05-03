import 'package:flutter/material.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:zoom_clone/resource/%20firestore_methods.dart';
import 'auth.methods.dart';

class JitsiMeetMethods {
  final AuthMethods _authMethods = AuthMethods();
  final FirestoreMethods _firestoreMethods = FirestoreMethods();

  void createMeeting({required String roomName,
    required bool isAudiomuted,
    required bool isVideomuted,
    String username = '',}) async{
    try{
     // String? serverUrl = serverText.text.trim().isEmpty ? null : serverText.text;
      Map<FeatureFlag, Object> featureFlags = {};
      String name;
      if(username.isEmpty){
        name = _authMethods.user.displayName!;
      }else{
        name = username;
      }
      // Define meetings options here
      var options = JitsiMeetingOptions(roomNameOrUrl: roomName,
        // token: tokenText.text,
        isAudioMuted: isAudiomuted,
        // isAudioOnly: true,
        isVideoMuted: isVideomuted,
        userDisplayName: name ,
        userEmail: _authMethods.user.email,
        userAvatarUrl: _authMethods.user.photoURL,
      );
      _firestoreMethods.addToMeetingHistory(roomName);
      await JitsiMeetWrapper.joinMeeting(options: options,
        listener: JitsiMeetingListener(
          onOpened: () => debugPrint("onOpened"),
          onConferenceWillJoin: (url) {
            print("onConferenceWillJoin: url: $url");
          },
          onConferenceJoined: (url) {
            print("onConferenceJoined: url: $url");
          },
          onConferenceTerminated: (url, error) {
            print("onConferenceTerminated: url: $url, error: $error");
          },
          onAudioMutedChanged: (isMuted) {
            print("onAudioMutedChanged: isMuted: $isMuted");
          },
          onVideoMutedChanged: (isMuted) {
            print("onVideoMutedChanged: isMuted: $isMuted");
          },
          onScreenShareToggled: (participantId, isSharing) {
            debugPrint(
              "onScreenShareToggled: participantId: $participantId, "
                  "isSharing: $isSharing",
            );
          },
          onParticipantJoined: (email, name, role, participantId) {
            debugPrint(
              "onParticipantJoined: email: $email, name: $name, role: $role, "
                  "participantId: $participantId",
            );
          },
          onParticipantLeft: (participantId) {
            debugPrint("onParticipantLeft: participantId: $participantId");
          },
          onParticipantsInfoRetrieved: (participantsInfo, requestId) {
            debugPrint(
              "onParticipantsInfoRetrieved: participantsInfo: $participantsInfo, "
                  "requestId: $requestId",
            );
          },
          onChatMessageReceived: (senderId, message, isPrivate) {
            debugPrint(
              "onChatMessageReceived: senderId: $senderId, message: $message, "
                  "isPrivate: $isPrivate",
            );
          },
          onChatToggled: (isOpen) => debugPrint("onChatToggled: isOpen: $isOpen"),
          onClosed: () => debugPrint("onClosed"),
        ),
      );
    }catch(error){
      print("error: $error");

    }
  }
}