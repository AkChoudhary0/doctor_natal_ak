import 'dart:async';
import 'dart:developer';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:resize/resize.dart';

import '../../../multi_language/language_constants.dart';
import '../../api_services/post_service.dart';
import '../../api_services/urls.dart';
import '../../config/app_colors.dart';
import '../../config/app_text_styles.dart';
import '../../controllers/doctor_diseases_controller.dart';
import '../../controllers/doctor_medical_tests_controller.dart';
import '../../controllers/doctor_patient_healths_controller.dart';
import '../../controllers/general_controller.dart';
import '../../repositories/create_ehr_repo.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/multi_select_dropdown_widget.dart';
import '../../widgets/text_form_field_widget.dart';
import 'agora.config.dart' as config;
import 'repo.dart';

/// MultiChannel Example
class JoinChannelVideo extends StatefulWidget {
  const JoinChannelVideo({super.key});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<JoinChannelVideo> {
  late final RtcEngine _engine;
  final formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> patientHealths = [];
  List<int>? selectedDiseasesIds;
  List<int>? selectedMedicalTestsIds;
  final List<Map<String, dynamic>> healthData = [
    {
      'selectedHealth': null,
      'valueController': TextEditingController(),
    }
  ];

  bool isJoined = false, switchCamera = true, switchRender = true;

  // List<int> remoteUid = [];
  int? remoteUid;
  bool localUserJoined = false;

  _callEndCheckMethod() {
    if (callEnd == 2) {
      _leaveChannel();

      Get.back();
    }
  }

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    log("${Get.arguments[0]} ARGUMENT");
    log("${Get.find<GeneralController>().appointmentObject} OBJECT");
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
        // {
        //   "appointment": Get.find<GeneralController>().appointmentObject,
        //   "channel": Get.find<GeneralController>().selectedChannel,
        //   "token": Get.find<GeneralController>().tokenForCall
        // },
        true,
        makeAgoraCallRepo);

    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _callEndCheckMethod();
    });
    // if (Get.find<GeneralController>().callerType == 1) {
    _initEngine();
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
    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(
      appId: config.agoraAppId,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    ));

    await _engine.enableVideo();
    await _engine.startPreview();
    /* await _engine.enableLocalVideo(true);

    await _engine.setVideoEncoderConfiguration(
      const VideoEncoderConfiguration(),
    );*/
  }

  _addListeners() {
    _engine.registerEventHandler(RtcEngineEventHandler(
      onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
        localUserJoined = true;
        isJoined = true;
        if (mounted) {
          setState(() {});
        }
      },
      onUserJoined: (RtcConnection connection, int uid, int elapsed) {
        remoteUid = uid;
        callEnd = 1;
        var generalController = Get.put(GeneralController());
        generalController.isCallCompleted.value = true;
        generalController.isCallCompleted.refresh();
        print(
            "generalController.isCallCompleted.value :${generalController.isCallCompleted.value}");

        if (mounted) {
          setState(() {});
        }
      },
      onUserOffline:
          (RtcConnection connection, int uid, UserOfflineReasonType reason) {
        remoteUid = uid;

        if (reason == UserOfflineReasonType.userOfflineDropped) {
          // User disconnected unexpectedly (e.g., app closed, lost network)
          print('User $uid disconnected unexpectedly.');
        } else if (reason == UserOfflineReasonType.userOfflineQuit) {
          // User left the channel voluntarily
          print('User $uid left the channel.');
        }

        if (callEnd == 1) {
          callEnd = 2;
        }

        if (mounted) {
          setState(() {});
        }
      }

      /* onUserOffline:
          (RtcConnection connection, int uid, UserOfflineReasonType reason) {
        remoteUid = uid;
        if (callEnd == 1) {
          callEnd = 2;
        }
        if(mounted){
          setState(() {

          });
        }
      }*/
      ,
      onLeaveChannel: (RtcConnection connection, RtcStats xstats) {
        _leaveChannel();
        isJoined = false;
        remoteUid = null;
        if (mounted) {
          setState(() {});
        }
      },
    ));
  }

  Future<dynamic> _joinChannel() async {
    // if (defaultTargetPlatform == TargetPlatform.android) {
    //   await [Permission.microphone, Permission.camera].request();
    // }
    // await _engine.joinChannel(
    //     Get.find<GeneralController>().tokenForCall,
    //     Get.find<GeneralController>().channelForCall!,
    //     null,
    //     Get.find<GeneralController>().callerType);
    // _addListeners();
    if (defaultTargetPlatform == TargetPlatform.android) {
      await [Permission.microphone, Permission.camera].request();
    }
    _addListeners();
    await _engine.joinChannel(
      token: Get.find<GeneralController>().tokenForCall!,
      channelId: Get.find<GeneralController>().channelForCall!,
      uid: Get.find<GeneralController>().callerType,
      options: const ChannelMediaOptions(
          autoSubscribeVideo: true,
          autoSubscribeAudio: true,
          publishCameraTrack: true,
          publishMicrophoneTrack: true,
          channelProfile: ChannelProfileType.channelProfileCommunication,
          clientRoleType: ClientRoleType.clientRoleBroadcaster),
    );
    print("uid:${Get.find<GeneralController>().channelForCall!}");
    print("channelId:${Get.find<GeneralController>().channelForCall!}");

    /*   _addListeners();*/
  }

  _leaveChannel() async {
    await _engine.leaveChannel();
    await _engine.release();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Stack(
        children: [
          Center(
            child: remoteVideo(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 100,
              height: 150,
              child: Center(
                child: localUserJoined
                    ? AgoraVideoView(
                        controller: VideoViewController(
                          rtcEngine: _engine,
                          canvas: const VideoCanvas(uid: 0),
                        ),
                      )
                    : const CircularProgressIndicator(),
              ),
            ),
          ),
          toolbar()
        ],
      ),
    );
  }

  void onCallEnd(BuildContext context) {
    Navigator.pop(context);
  }

  bool muted = false;

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    _engine.switchCamera();
  }

  Widget toolbar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: _onToggleMute,
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: muted ? AppColors.primaryColor : AppColors.white,
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              muted ? Icons.mic_off : Icons.mic,
              color: muted ? Colors.white : AppColors.primaryColor,
              size: 20.0,
            ),
          ),
          RawMaterialButton(
            onPressed: () {
              addPrescription(context);
            },
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: AppColors.white,
            padding: const EdgeInsets.all(15.0),
            child: Icon(
              Icons.add,
              color: AppColors.primaryColor,
              size: 35.0,
            ),
          ),
          RawMaterialButton(
            onPressed: () {
              _leaveChannel();
              // _onCallEnd(context);

              Get.back();
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
          RawMaterialButton(
            onPressed: _onSwitchCamera,
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              Icons.switch_camera,
              color: AppColors.primaryColor,
              size: 20.0,
            ),
          )
        ],
      ),
    );
  }

  // _renderVideo() {
  //   return SafeArea(
  //     child: Stack(
  //       children: [
  // remoteUid == 0
  //     ? const SizedBox()
  //     : remoteUid == null
  //         ? const CircularProgressIndicator()
  //         : RtcRemoteView.SurfaceView(
  //             channelId: Get.find<GeneralController>().channelForCall!,
  //             uid: remoteUid!,
  //           ),
  //         const SizedBox(
  //           width: 120,
  //           height: 120,
  //           child: RtcLocalView.SurfaceView(),
  //         ),
  //         _toolbar(),
  //         // remoteUid.isEmpty
  //         // ?
  //         // const SizedBox(),
  //         // SizedBox(
  //         //     width: 120,
  //         //     height: 120,
  //         //     child: (RtcRemoteView.SurfaceView(
  //         //       channelId: Get.find<GeneralController>().channelForCall!,
  //         //       uid: remoteUid,
  //         //     ))),
  //         // Align(
  //         //   alignment: Alignment.topLeft,
  //         //   child: SizedBox(
  //         //     width: 100,
  //         //     height: 150,
  //         //     child: Center(
  //         //         child: localUserJoined
  //         //             ? AgoraVideoView(
  //         //                 controller: VideoViewController(
  //         //                   // useAndroidSurfaceView: true,
  //         //                   rtcEngine: _engine,
  //         //                   canvas: VideoCanvas(uid: remoteUid),
  //         //                 ),
  //         //               )
  //         //             : CircularProgressIndicator()),
  //         //   ),
  //         // ),
  //         // : rtc_remote_view.SurfaceView(
  //         //     channelId:
  //         //         Get.find<GeneralController>().channelForCall!,
  //         //     uid: remoteUid[0],
  //         //   ),
  //         // SizedBox(
  //         //   width: 120,
  //         //   height: 120,
  //         //   child: RtcLocalView.SurfaceView(),
  //         // ),
  //         _toolbar()
  //       ],
  //     ),
  //   );
  // }
  Widget remoteVideo() {
    if (remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: remoteUid),
          connection: RtcConnection(
              channelId: Get.find<GeneralController>().channelForCall!),
        ),
      );
    } else {
      return CircularProgressIndicator(color: AppColors.primaryColor);
    }
  }

  void _addNewRow() {
    setState(() {
      healthData.add({
        'selectedHealth': null,
        'valueController': TextEditingController(),
      });
    });
  }

  void _removeRow(int index) {
    setState(() {
      healthData.removeAt(index);
    });
  }

  void generatePatientHealthResponse() {
    patientHealths = healthData
        .where((item) =>
            item['selectedHealth'] != null &&
            item['selectedHealth'].isNotEmpty &&
            item['valueController'].text.isNotEmpty)
        .map((item) => {
              "id": item['selectedHealth'][0], // Assumes single selection
              "value": item['valueController'].text
            })
        .toList();

    // Convert it into a JSON-like format
    Map<String, dynamic> response = {"patient_healths": patientHealths};

    print(response); // Debugging purpose
  }

  addPrescription(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 0,
                  backgroundColor: AppColors.transparent,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10.w, 15.h, 10.w, 15.h),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0.w, 0.h, 0.w, 10.h),
                          child: Center(
                            child: Text(
                              LanguageConstant.addPrescription.tr,
                              style: AppTextStyles.headingTextStyle5,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        MultiSelectDropdownFormField(
                          items: Get.find<GetDoctorDiseasesController>()
                              .allDiseases!,
                          labelText: LanguageConstant.selectDiseases.tr,
                          isMultiSelect: true,
                          selectedItems: selectedDiseasesIds ?? [],
                          onChanged: (value) {
                            setState(() {
                              selectedDiseasesIds = value;
                              print("$selectedDiseasesIds SELECTEDDISEASES");
                            });
                          },
                        ),

                        ListView.builder(
                          shrinkWrap:
                              true, // To avoid scroll conflict with parent
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: healthData.length,
                          itemBuilder: (context, index) {
                            final item = healthData[index];
                            return Padding(
                              padding:
                                  EdgeInsets.fromLTRB(0.w, 10.h, 0.w, 10.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Patient Health Dropdown
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          LanguageConstant.patientHealth.tr,
                                          textAlign: TextAlign.start,
                                          style: AppTextStyles
                                              .subHeadingTextStyle7,
                                        ),
                                        SizedBox(height: 8.h),
                                        MultiSelectDropdownFormField(
                                          items: Get.find<
                                                  GetDoctorPatientHealthsController>()
                                              .allPatientHealth!,
                                          selectedItems:
                                              item['selectedHealth'] ?? [],
                                          labelText: LanguageConstant
                                              .selectPatientHealth.tr,
                                          isMultiSelect: false,
                                          onChanged: (value) {
                                            setState(() {
                                              item['selectedHealth'] = value;
                                              print(
                                                  "${item['selectedHealth']} SELECTEDPATIENTHEALTH");
                                              print(
                                                  "${Get.find<GetDoctorPatientHealthsController>().selectedPatientHealthsIds} SELECTEDPATIENTHEALTHTT");
                                            });
                                          },
                                          initialValue: item['selectedHealth'],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  // Values Input Field
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          LanguageConstant.values.tr,
                                          textAlign: TextAlign.start,
                                          style: AppTextStyles
                                              .subHeadingTextStyle7,
                                        ),
                                        SizedBox(height: 8.h),
                                        TextFormFieldWidget(
                                          hintText: LanguageConstant.values.tr,
                                          controller: item['valueController'],
                                          onChanged: (String? value) {
                                            setState(() {
                                              item['valueController'].text =
                                                  value!;

                                              print(
                                                  "${item['valueController'].text} SELECTEDPATIENTHEALTH2");

                                              generatePatientHealthResponse();
                                            });
                                          },
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return LanguageConstant
                                                  .valueFieldRequired.tr;
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  // Remove Row Button
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(0, 26.h, 0, 0.h),
                                    child: ButtonWidgetSeven(
                                      buttonIcon: Icons.delete,
                                      buttonIconColor: AppColors.carrotRed,
                                      iconSize: 22.h,
                                      onTap: () => _removeRow(index),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 8.h),
                        // Add Button
                        ButtonWidgetTwo(
                            onTap: _addNewRow,
                            buttonText: LanguageConstant.add.tr,
                            buttonIcon: Icon(
                              Icons.add,
                              color: AppColors.black,
                              size: 14.h,
                            ),
                            buttonTextStyle: AppTextStyles.buttonTextStyle7,
                            borderRadius: 10,
                            buttonColor: AppColors.primaryColor),

                        SizedBox(height: 16.h),
                        MultiSelectDropdownFormField(
                          items: Get.find<GetDoctorMedicalTestsController>()
                              .allMedicalTests!,
                          selectedItems: selectedMedicalTestsIds ?? [],
                          initialValue: selectedMedicalTestsIds ?? [],
                          labelText: LanguageConstant.selectMedicalTests.tr,
                          isMultiSelect: true,
                          onChanged: (value) {
                            setState(() {
                              selectedMedicalTestsIds = value;
                              print("$selectedMedicalTestsIds SELECTEDTESTS");
                            });
                          },
                        ),
                        SizedBox(height: 16.h),
                        TextFormFieldWidget(
                          hintText: LanguageConstant.prescription.tr,
                          maxLines: 3,
                          controller:
                              Get.find<GetDoctorPatientHealthsController>()
                                  .prescriptionController,
                          onChanged: (String? value) {
                            setState(() {
                              Get.find<GetDoctorPatientHealthsController>()
                                      .prescriptionController
                                      .text ==
                                  value;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return LanguageConstant
                                  .prescriptionFieldRequired.tr;
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 16.h),
                        ButtonWidgetOne(
                          onTap: () {
                            postMethod(
                                context,
                                addDoctorsEHRPrescriptionURL,
                                {
                                  'prescription': Get.find<
                                          GetDoctorPatientHealthsController>()
                                      .prescriptionController
                                      .text,
                                  'patient_id': Get.find<GeneralController>()
                                      .selectedAppointmentHistoryForView
                                      .patientId,
                                  'disease_ids': selectedDiseasesIds,
                                  'patient_healths': patientHealths,
                                  'booked_appointment_id':
                                      Get.find<GeneralController>()
                                          .selectedAppointmentHistoryForView
                                          .id,
                                  'test_ids': selectedMedicalTestsIds
                                },
                                true,
                                createEHRRepo);
                          },
                          buttonText: LanguageConstant.save.tr,
                          buttonTextStyle: AppTextStyles.buttonTextStyle1,
                          borderRadius: 10,
                        )
                      ],
                    ),
                  )),
            ),
          );
        });
  }
}

// import 'dart:async';
// import 'dart:developer';

// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:permission_handler/permission_handler.dart';
// import '../../api_services/post_service.dart';
// import '../../api_services/urls.dart';
// import '../../controllers/general_controller.dart';
// import 'agora.config.dart' as config;
// import 'repo.dart';

// var appId = config.agoraAppId;
// var token = Get.find<GeneralController>().tokenForCall;
// var channel = Get.find<GeneralController>().channelForCall;

// class JoinChannelVideo extends StatefulWidget {
//   const JoinChannelVideo({Key? key}) : super(key: key);

//   @override
//   State<JoinChannelVideo> createState() => _JoinChannelVideoState();
// }

// class _JoinChannelVideoState extends State<JoinChannelVideo> {
//   int? _remoteUid;
//   bool _localUserJoined = false;
//   late RtcEngine _engine;
//   Timer? _timer;

//   @override
//   void initState() {
//     super.initState();
//     log("${Get.arguments[0]} ARGUMENT");
//     log("${Get.find<GeneralController>().appointmentObject} OBJECT");
//     postMethod(
//         context,
//         makeAgoraCall,
//         {
//           "appointment": {
//             "patient_id": Get.find<GeneralController>()
//                 .selectedAppointmentHistoryForView
//                 .patientId,
//             "id": Get.find<GeneralController>()
//                 .selectedAppointmentHistoryForView
//                 .id
//           },
//           "channel": Get.find<GeneralController>().channelForCall,
//           "token": Get.find<GeneralController>().tokenForCall
//         },
//         // {
//         //   "appointment": Get.find<GeneralController>().appointmentObject,
//         //   "channel": Get.find<GeneralController>().selectedChannel,
//         //   "token": Get.find<GeneralController>().tokenForCall
//         // },
//         true,
//         makeAgoraCallRepo);

//     // _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
//     //   _callEndCheckMethod();
//     // });
//     // if (Get.find<GeneralController>().callerType == 1) {
//     // Future.delayed(
//     //   const Duration(seconds: 2),
//     // ).whenComplete(() => joinChannel());
//     // }

//     initAgora();
//   }

//   Future<void> initAgora() async {
//     // retrieve permissions
//     await [Permission.microphone, Permission.camera].request();

//     //create the engine
//     _engine = createAgoraRtcEngine();
//     await _engine.initialize(RtcEngineContext(
//       appId: appId,
//       channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
//     ));

//     _engine.registerEventHandler(
//       RtcEngineEventHandler(
//         onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
//           debugPrint("local user ${connection.localUid} joined");
//           setState(() {
//             _localUserJoined = true;
//           });
//         },
//         onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
//           debugPrint("remote user $remoteUid joined");
//           setState(() {
//             _remoteUid = remoteUid;
//           });
//         },
//         onUserOffline: (RtcConnection connection, int remoteUid,
//             UserOfflineReasonType reason) {
//           debugPrint("remote user $remoteUid left channel");
//           setState(() {
//             _remoteUid = null;
//           });
//         },
//         onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
//           debugPrint(
//               '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
//         },
//       ),
//     );

//     await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
//     await _engine.enableVideo();
//     await _engine.startPreview();

//     await _engine.joinChannel(
//       token: token!,
//       channelId: channel!,
//       uid: 0,
//       options: const ChannelMediaOptions(),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();

//     _dispose();
//   }

//   Future<void> _dispose() async {
//     await _engine.leaveChannel();
//     await _engine.release();
//   }

//   // Create UI with local view and remote view
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Agora Video Call'),
//       ),
//       body: Stack(
//         children: [
//           Center(
//             child: _remoteVideo(),
//           ),
//           Align(
//             alignment: Alignment.topLeft,
//             child: SizedBox(
//               width: 100,
//               height: 150,
//               child: Center(
//                 child: _localUserJoined
//                     ? AgoraVideoView(
//                         controller: VideoViewController(
//                           rtcEngine: _engine,
//                           canvas: const VideoCanvas(uid: 0),
//                         ),
//                       )
//                     : const CircularProgressIndicator(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Display remote user's video
//   Widget _remoteVideo() {
//     if (_remoteUid != null) {
//       return AgoraVideoView(
//         controller: VideoViewController.remote(
//           rtcEngine: _engine,
//           canvas: VideoCanvas(uid: _remoteUid),
//           connection: RtcConnection(channelId: channel),
//         ),
//       );
//     } else {
//       return const Text(
//         'Please wait for remote user to join',
//         textAlign: TextAlign.center,
//       );
//     }
//   }
// }
