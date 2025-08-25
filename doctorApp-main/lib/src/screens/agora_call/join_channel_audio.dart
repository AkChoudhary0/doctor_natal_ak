// ignore_for_file: deprecated_member_use, unnecessary_string_interpolations

import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:resize/resize.dart';

import '../../api_services/post_service.dart';
import '../../api_services/urls.dart';
import '../../config/app_colors.dart';
import '../../config/app_font.dart';
import '../../controllers/general_controller.dart';
import '../../repositories/appointment_status_update_repo.dart';
import 'agora.config.dart' as config;
import 'repo.dart';

/// JoinChannelAudio Example

class JoinChannelAudio extends StatefulWidget {
  final String? channelId;

  const JoinChannelAudio({super.key, this.channelId});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<JoinChannelAudio> {
  late final RtcEngine _engine;
  bool isJoined = false,
      openMicrophone = true,
      enableSpeakerphone = false,
      playEffect = false;
  int? remoteUid;
  int callerType2 = 1;

  _callEndCheckMethod() {
    if (callEnd == 2) {
      _leaveChannel();
    }
  }

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    postMethod(
        context,
        makeAgoraCall,
        {
          "appointment": {
            "patient_id": Get.find<GeneralController>()
                .selectedAppointmentHistoryForView
                .patientId,
            "id": Get.find<GeneralController>()
                .selectedAppointmentHistoryForView
                .id
          },
          "channel": Get.find<GeneralController>().channelForCall,
          "token": Get.find<GeneralController>().tokenForCall
        },
        true,
        makeAgoraCallRepo);
    // _joinChannel();
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _callEndCheckMethod();
    });
    _initEngine();
    // if (Get.find<GeneralController>().callerType == 1) {
    Future.delayed(
      const Duration(seconds: 2),
    ).whenComplete(() => _joinChannel());
    // }
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
    _engine.release();
  }

  int? callEnd = 0;

  _initEngine() async {
    // _engine =
    //     await RtcEngine.createWithContext(RtcEngineContext(config.agoraAppId));
    // _addListeners();

    // await _engine.enableAudio();
    // await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    // await _engine.setClientRole(ClientRole.Broadcaster);

    _engine = createAgoraRtcEngineEx();
    await _engine.initialize(RtcEngineContext(
      appId: config.agoraAppId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _addListeners();

    await _engine.enableAudio();
    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
  }

  _addListeners() {
    // _engine.registerEventHandler(RtcEngineEventHandler(
    //   joinChannelSuccess: (channel, uid, elapsed) {
    //     setState(() {
    //       isJoined = true;
    //     });
    //   },
    //   leaveChannel: (stats) async {
    //     _leaveChannel();
    //     setState(() {
    //       isJoined = false;
    //     });
    //   },
    //   userJoined: (uid, elapsed) {
    //     setState(() {
    //       callEnd = 1;
    //     });
    //   },
    //   userOffline: (uid, reason) {
    //     setState(() {
    //       if (callEnd == 1) {
    //         callEnd = 2;
    //       }
    //     });
    //   },
    // ));

    _engine.registerEventHandler(RtcEngineEventHandler(
      onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
        isJoined = true;
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        isJoined = false;
      },
      onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
        callEnd = 1;
        var generalController = Get.put(GeneralController());
        generalController.isCallCompleted.value = true;
        generalController.update();
        print("generalController.isCallCompleted.value :${ generalController.isCallCompleted.value }");
      },
      onUserOffline: (RtcConnection connection, int remoteUid,
          UserOfflineReasonType reason) {
        if (callEnd == 1) {
          callEnd = 2;
        }
      },
    ));
  }

  // _addListeners() {
  //   _engine.setEventHandler(RtcEngineEventHandler(
  //     joinChannelSuccess: (channel, uid, elapsed) {
  //       setState(() {
  //         isJoined = true;
  //       });
  //     },
  //     leaveChannel: (stats) async {
  //       setState(() {
  //         isJoined = false;
  //       });
  //     },
  //     userJoined: (uid, elapsed) {
  //       setState(() {
  //         callEnd = 1;
  //       });
  //     },
  //     userOffline: (uid, reason) {
  //       setState(() {
  //         if (callEnd == 1) {
  //           callEnd = 2;
  //         }
  //       });
  //     },
  //   ));
  // }

  _joinChannel() async {
    // if (defaultTargetPlatform == TargetPlatform.android) {
    //   await Permission.microphone.request();
    // }

    // await _engine
    //     .joinChannel(
    //         Get.find<GeneralController>().tokenForCall,
    //         Get.find<GeneralController>().channelForCall!,
    //         null,
    //         Get.find<GeneralController>().callerType)
    //     .catchError((onError) {});
    if (defaultTargetPlatform == TargetPlatform.android) {
      await Permission.microphone.request();
    }

    await _engine
        .joinChannel(
          token: Get.find<GeneralController>().tokenForCall!,
          channelId: Get.find<GeneralController>().channelForCall!,
          uid: Get.find<GeneralController>().callerType,
          options: const ChannelMediaOptions(),
        )
        .catchError((onError) {});
  }

  _leaveChannel() async {
    await _engine.leaveChannel();
    Get.back();
  }

  _switchMicrophone() {
    _engine.enableLocalAudio(!openMicrophone).then((value) {
      setState(() {
        openMicrophone = !openMicrophone;
      });
    }).catchError((err) {});
  }

  _switchSpeakerphone() {
    _engine.setEnableSpeakerphone(!enableSpeakerphone).then((value) {
      setState(() {
        enableSpeakerphone = !enableSpeakerphone;
      });
    }).catchError((err) {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child:
          // callEnd == 0
          //     ?
          // callerType2 == 1
          //     ?
          // _receiverView()
          // :
          // _ringingView()
          // :
          Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/call-bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .1,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      '$mediaUrl${Get.find<GeneralController>().currentDoctorModel!.loginInfo!.image}'),
                  radius: 75.h,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .2,
                ),
                Expanded(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ///---mute
                            InkWell(
                              onTap: () {
                                _switchMicrophone();
                              },
                              child: CircleAvatar(
                                radius: 30.r,
                                backgroundColor: !openMicrophone
                                    ? AppColors.primaryColor
                                    : Colors.white,
                                child: Icon(
                                  openMicrophone ? Icons.mic : Icons.mic_off,
                                  color: openMicrophone
                                      ? AppColors.primaryColor
                                      : Colors.white,
                                  size: 25,
                                ),
                              ),
                            ),

                            ///---speaker
                            InkWell(
                              onTap: () {
                                _switchSpeakerphone();
                              },
                              child: CircleAvatar(
                                radius: 30.r,
                                backgroundColor: enableSpeakerphone
                                    ? AppColors.primaryColor
                                    : AppColors.white,
                                child: Icon(
                                  enableSpeakerphone
                                      ? Icons.volume_off
                                      : Icons.volume_up,
                                  color: enableSpeakerphone
                                      ? AppColors.white
                                      : AppColors.primaryColor,
                                  size: 25,
                                ),
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            _leaveChannel();
                            if (remoteUid != null) {
                              var generalController =
                                  Get.put(GeneralController());
                              Get.find<GeneralController>()
                                  .updateAppointmentStatusLoaderController(
                                      true);
                              postMethod(
                                  context,
                                  "$updateAppointmentStatusCodeURL${generalController.selectedAppointmentHistoryForView.id}",
                                  {"appointment_status_code": 5},
                                  true,
                                  appointmentStatusUpdateRepo);
                            }
                          },
                          child: const CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.red,
                            child: Icon(
                              Icons.call_end,
                              color: AppColors.white,
                              size: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onCallEnd(BuildContext context) {
    Navigator.pop(context);
  }

  ringingView() {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              AppColors.primaryColor,
              AppColors.customDialogSuccessColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .1,
              ),
              Container(
                height: 130.h,
                width: 130.w,
                decoration: const BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(
                        image: AssetImage('assets/Icons/splash_logo.png'))),
              ),
              isJoined
                  ? Padding(
                      padding: EdgeInsets.fromLTRB(0, 27.h, 0, 0),
                      child: Text(
                        'Ringing',
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontFamily: AppFont.primaryFontFamily,
                            color: Colors.white),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.fromLTRB(0, 27.h, 0, 0),
                      child: Text(
                        'Calling',
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontFamily: AppFont.primaryFontFamily,
                            color: Colors.white),
                      ),
                    ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: RawMaterialButton(
                      onPressed: () {
                        _leaveChannel();
                        _onCallEnd(context);
                      },
                      shape: const CircleBorder(),
                      elevation: 2.0,
                      fillColor: Colors.redAccent,
                      padding: const EdgeInsets.all(15.0),
                      child: const Icon(
                        Icons.clear,
                        color: Colors.white,
                        size: 35.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  receiverView() {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              AppColors.primaryColor,
              AppColors.customDialogSuccessColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Image.asset(
                'assets/icons/🦆 icon _Video_.png',
                width: MediaQuery.of(context).size.width * .6,
              )),
              Text(
                'Call Alert',
                style: TextStyle(
                    fontSize: 20.sp,
                    fontFamily: AppFont.primaryFontFamily,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                // '${LanguageConstant.youAreReceivingCallFrom.tr}'
                '${Get.find<GeneralController>().storageBox.read('userRole').toString().toUpperCase() == 'MENTEE' ? 'CONSULTANT' : 'USER'}',
                style: TextStyle(
                    fontSize: 15.sp,
                    fontFamily: AppFont.primaryFontFamily,
                    color: Colors.white),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 35.r,
                              child: const Icon(
                                Icons.clear,
                                color: Colors.white,
                                size: 35.0,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              _joinChannel();
                            },
                            child: CircleAvatar(
                              backgroundColor: AppColors.green,
                              radius: 35.r,
                              child: const Icon(
                                Icons.call,
                                color: Colors.white,
                                size: 35.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
