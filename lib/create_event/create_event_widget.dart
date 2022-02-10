import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../backend/firebase_storage/storage.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_media_display.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_video_player.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/upload_media.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateEventWidget extends StatefulWidget {
  const CreateEventWidget({Key key}) : super(key: key);

  @override
  _CreateEventWidgetState createState() => _CreateEventWidgetState();
}

class _CreateEventWidgetState extends State<CreateEventWidget>
    with TickerProviderStateMixin {
  DateTime datePicked1;
  TextEditingController textController3;
  String uploadedFileUrl = '';
  TextEditingController textController1;
  TextEditingController locationNameController;
  DateTime datePicked2;
  EventsRecord createdPost;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final animationsMap = {
    'buttonOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      duration: 600,
      delay: 350,
      fadeIn: true,
      initialState: AnimationState(
        offset: Offset(0, 50),
        scale: 0.6,
        opacity: 0,
      ),
      finalState: AnimationState(
        offset: Offset(0, 0),
        scale: 1,
        opacity: 1,
      ),
    ),
  };

  @override
  void initState() {
    super.initState();
    startPageLoadAnimations(
      animationsMap.values
          .where((anim) => anim.trigger == AnimationTrigger.onPageLoad),
      this,
    );

    locationNameController = TextEditingController();
    textController1 = TextEditingController();
    textController3 = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 4),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Create Event',
                      style: FlutterFlowTheme.title2.override(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                      ),
                    ),
                    FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 30,
                      borderWidth: 1,
                      buttonSize: 44,
                      icon: Icon(
                        Icons.close_rounded,
                        color: FlutterFlowTheme.grayIcon,
                        size: 24,
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: InkWell(
                  onTap: () async {
                    final selectedMedia =
                        await selectMediaWithSourceBottomSheet(
                      context: context,
                      allowPhoto: true,
                      allowVideo: true,
                      backgroundColor: FlutterFlowTheme.lightText,
                      textColor: FlutterFlowTheme.darkText,
                      pickerFontFamily: 'Cormorant Garamond',
                    );
                    if (selectedMedia != null &&
                        validateFileFormat(
                            selectedMedia.storagePath, context)) {
                      showUploadMessage(
                        context,
                        'Uploading file...',
                        showLoading: true,
                      );
                      final downloadUrl = await uploadData(
                          selectedMedia.storagePath, selectedMedia.bytes);
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      if (downloadUrl != null) {
                        setState(() => uploadedFileUrl = downloadUrl);
                        showUploadMessage(
                          context,
                          'Success!',
                        );
                      } else {
                        showUploadMessage(
                          context,
                          'Failed to upload media',
                        );
                        return;
                      }
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 230,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.lightText,
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: Image.asset(
                          'assets/images/Screen_Shot_2021-06-04_at_9.38.16_AM.png',
                        ).image,
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          color: Color(0x3E000000),
                          offset: Offset(0, 3),
                        )
                      ],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 1, 0, 0),
                      child: FlutterFlowMediaDisplay(
                        path: valueOrDefault<String>(
                          uploadedFileUrl,
                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/wedding-app-anuwld/assets/rfox38ig45wl/emptyPhoto@2x.png',
                        ),
                        imageBuilder: (path) => ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: CachedNetworkImage(
                            imageUrl: path,
                            width: 300,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                        ),
                        videoPlayerBuilder: (path) => FlutterFlowVideoPlayer(
                          path: path,
                          width: 300,
                          autoPlay: false,
                          looping: true,
                          showControls: false,
                          allowFullScreen: true,
                          allowPlaybackSpeedMenu: false,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: textController1,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Event Name',
                          labelStyle: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Cormorant Garamond',
                            color: FlutterFlowTheme.grayIcon,
                            fontSize: 20,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.lightLines,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.lightLines,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: FlutterFlowTheme.lightText,
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                        ),
                        style: FlutterFlowTheme.title3.override(
                          fontFamily: 'Cormorant Garamond',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: locationNameController,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Address',
                          labelStyle: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Cormorant Garamond',
                            color: FlutterFlowTheme.grayIcon,
                          ),
                          hintStyle: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Cormorant Garamond',
                            color: FlutterFlowTheme.grayIcon,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.lightLines,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.lightLines,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: FlutterFlowTheme.lightText,
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                        ),
                        style: FlutterFlowTheme.bodyText1,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: InkWell(
                  onTap: () async {
                    await DatePicker.showDateTimePicker(
                      context,
                      showTitleActions: true,
                      onConfirm: (date) {
                        setState(() => datePicked1 = date);
                      },
                      currentTime: getCurrentTimestamp,
                      minTime: getCurrentTimestamp,
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.lightText,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: FlutterFlowTheme.lightLines,
                        width: 1,
                      ),
                    ),
                    child: TextFormField(
                      controller: textController3,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding:
                            EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                      ),
                      style: FlutterFlowTheme.title3.override(
                        fontFamily: 'Cormorant Garamond',
                        color: FlutterFlowTheme.grayIcon,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: InkWell(
                  onTap: () async {
                    await DatePicker.showDateTimePicker(
                      context,
                      showTitleActions: true,
                      onConfirm: (date) {
                        setState(() => datePicked2 = date);
                      },
                      currentTime: getCurrentTimestamp,
                      minTime: getCurrentTimestamp,
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.lightText,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: FlutterFlowTheme.lightLines,
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            valueOrDefault<String>(
                              dateTimeFormat('MMMEd', datePicked2),
                              'Choose Date',
                            ),
                            style: FlutterFlowTheme.bodyText1,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                            child: Text(
                              dateTimeFormat('jm', datePicked2),
                              style: FlutterFlowTheme.bodyText1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 44),
                child: FFButtonWidget(
                  onPressed: () async {
                    final eventsCreateData = createEventsRecordData(
                      name: '',
                      time: datePicked2,
                      date: datePicked1,
                      description: textController3.text,
                      mainImage: uploadedFileUrl,
                      address: locationNameController.text,
                    );
                    final eventsRecordReference = EventsRecord.collection.doc();
                    await eventsRecordReference.set(eventsCreateData);
                    createdPost = EventsRecord.getDocumentFromData(
                        eventsCreateData, eventsRecordReference);
                    Navigator.pop(context);

                    setState(() {});
                  },
                  text: 'Create Event',
                  options: FFButtonOptions(
                    width: 290,
                    height: 50,
                    color: FlutterFlowTheme.primaryColor,
                    textStyle: FlutterFlowTheme.title3.override(
                      fontFamily: 'Open Sans',
                      color: FlutterFlowTheme.lightText,
                    ),
                    elevation: 3,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: 8,
                  ),
                ).animated([animationsMap['buttonOnPageLoadAnimation']]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
