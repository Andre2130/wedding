import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_calendar.dart';
import '../flutter_flow/flutter_flow_google_map.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../main.dart';
import '../main_map/main_map_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget>
    with TickerProviderStateMixin {
  DateTimeRange calendarSelectedDay;
  PageController pageViewController;
  LatLng googleMapsCenter;
  Completer<GoogleMapController> googleMapsController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final animationsMap = {
    'containerOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      duration: 600,
      fadeIn: true,
      initialState: AnimationState(
        opacity: 0,
      ),
      finalState: AnimationState(
        opacity: 1,
      ),
    ),
    'rowOnPageLoadAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      duration: 600,
      delay: 90,
      fadeIn: true,
      initialState: AnimationState(
        offset: Offset(0, 39),
        opacity: 0,
      ),
      finalState: AnimationState(
        offset: Offset(0, 0),
        opacity: 1,
      ),
    ),
    'rowOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      duration: 600,
      delay: 200,
      fadeIn: true,
      initialState: AnimationState(
        offset: Offset(0, 41),
        opacity: 0,
      ),
      finalState: AnimationState(
        offset: Offset(0, 0),
        opacity: 1,
      ),
    ),
    'rowOnPageLoadAnimation3': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      duration: 600,
      delay: 210,
      fadeIn: true,
      initialState: AnimationState(
        offset: Offset(0, 82),
        opacity: 0,
      ),
      finalState: AnimationState(
        offset: Offset(0, 0),
        opacity: 1,
      ),
    ),
    'rowOnPageLoadAnimation4': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      duration: 600,
      delay: 210,
      fadeIn: true,
      initialState: AnimationState(
        offset: Offset(0, 82),
        opacity: 0,
      ),
      finalState: AnimationState(
        offset: Offset(0, 0),
        opacity: 1,
      ),
    ),
    'rowOnPageLoadAnimation5': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      duration: 600,
      delay: 210,
      fadeIn: true,
      initialState: AnimationState(
        offset: Offset(0, 82),
        opacity: 0,
      ),
      finalState: AnimationState(
        offset: Offset(0, 0),
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

    calendarSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: FlutterFlowTheme.pageBackground,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: Image.asset(
              'assets/images/e1bb6ea17f152b4be291ff2b2761ae4a.jpeg',
            ).image,
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 44, 16, 0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: 400,
                        child: Stack(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 50),
                              child: PageView(
                                controller: pageViewController ??=
                                    PageController(initialPage: 0),
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Stack(
                                    children: [
                                      Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Image.asset(
                                          'assets/images/pien-muller-Fh-Q-xfdh_o-unsplash.jpg',
                                          width: double.infinity,
                                          height: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(-67, 0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              'Lets Link\'s First Event',
                                              style: FlutterFlowTheme.title1,
                                            ),
                                            Text(
                                              'Come join us for a night of fun!',
                                              style: FlutterFlowTheme.bodyText1
                                                  .override(
                                                fontFamily:
                                                    'Cormorant Garamond',
                                                color:
                                                    FlutterFlowTheme.darkText,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Stack(
                                    children: [
                                      Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: InkWell(
                                          onTap: () async {
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    MainMapWidget(),
                                              ),
                                            );
                                          },
                                          child: Image.asset(
                                            'assets/images/df3hg_',
                                            width: double.infinity,
                                            height: double.infinity,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: FlutterFlowCalendar(
                                          color: FlutterFlowTheme.primaryColor,
                                          iconColor: FlutterFlowTheme.darkText,
                                          weekFormat: true,
                                          weekStartsMonday: false,
                                          initialDate: getCurrentTimestamp,
                                          onChange:
                                              (DateTimeRange newSelectedDate) {
                                            setState(() => calendarSelectedDay =
                                                newSelectedDate);
                                          },
                                          titleStyle: TextStyle(),
                                          dayOfWeekStyle: TextStyle(
                                            color:
                                                FlutterFlowTheme.primaryColor,
                                          ),
                                          dateStyle: TextStyle(
                                            color: FlutterFlowTheme.darkText,
                                          ),
                                          selectedDateStyle: TextStyle(),
                                          inactiveDateStyle: TextStyle(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Stack(
                                    children: [
                                      Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Image.asset(
                                          'assets/images/caleb-de-marco-iovfeiUiMjo-unsplash.jpg',
                                          width: double.infinity,
                                          height: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Text(
                                          'Night Life',
                                          style: FlutterFlowTheme.title1,
                                        ),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: StreamBuilder<GuestsRecord>(
                                          stream: GuestsRecord.getDocument(
                                              currentUserReference),
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return Center(
                                                child: SizedBox(
                                                  width: 50,
                                                  height: 50,
                                                  child: SpinKitPumpingHeart(
                                                    color: Color(0xFFEEB111),
                                                    size: 50,
                                                  ),
                                                ),
                                              );
                                            }
                                            final googleMapGuestsRecord =
                                                snapshot.data;
                                            return FlutterFlowGoogleMap(
                                              controller: googleMapsController,
                                              onCameraIdle: (latLng) =>
                                                  googleMapsCenter = latLng,
                                              initialLocation:
                                                  googleMapsCenter ??= LatLng(
                                                      13.106061, -59.613158),
                                              markerColor:
                                                  GoogleMarkerColor.violet,
                                              mapType: MapType.normal,
                                              style: GoogleMapStyle.standard,
                                              initialZoom: 4,
                                              allowInteraction: true,
                                              allowZoom: true,
                                              showZoomControls: true,
                                              showLocation: true,
                                              showCompass: false,
                                              showMapToolbar: false,
                                              showTraffic: false,
                                              centerMapOnMarkerTap: true,
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0, 1),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                child: SmoothPageIndicator(
                                  controller: pageViewController ??=
                                      PageController(initialPage: 0),
                                  count: 3,
                                  axisDirection: Axis.horizontal,
                                  onDotClicked: (i) {
                                    pageViewController.animateToPage(
                                      i,
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.ease,
                                    );
                                  },
                                  effect: ExpandingDotsEffect(
                                    expansionFactor: 2,
                                    spacing: 8,
                                    radius: 16,
                                    dotWidth: 16,
                                    dotHeight: 16,
                                    dotColor: Color(0xFF9E9E9E),
                                    activeDotColor:
                                        FlutterFlowTheme.primaryColor,
                                    paintStyle: PaintingStyle.fill,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ).animated([animationsMap['rowOnPageLoadAnimation1']]),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Lets Link',
                      style: FlutterFlowTheme.title1.override(
                        fontFamily: 'Winlove',
                        color: FlutterFlowTheme.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        useGoogleFonts: false,
                      ),
                    ),
                  ],
                ).animated([animationsMap['rowOnPageLoadAnimation2']]),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Top Catigories',
                        style: FlutterFlowTheme.subtitle2,
                      ),
                    ],
                  ).animated([animationsMap['rowOnPageLoadAnimation3']]),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Text(
                              'Hello World',
                              style: FlutterFlowTheme.bodyText1,
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: InkWell(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        NavBarPage(initialPage: 'eventsPage'),
                                  ),
                                );
                              },
                              child: Image.asset(
                                'assets/images/caleb-de-marco-iovfeiUiMjo-unsplash.jpg',
                                width: 160,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(-0.7, 0),
                            child: Text(
                              'Night Life',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.title3,
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Image.network(
                              'https://picsum.photos/seed/570/600',
                              width: 160,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Text(
                              'Sports',
                              style: FlutterFlowTheme.title3,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ).animated([animationsMap['rowOnPageLoadAnimation4']]),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Image.network(
                              'https://picsum.photos/seed/407/600',
                              width: 160,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Text(
                              'Education',
                              style: FlutterFlowTheme.title3,
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Image.network(
                              'https://picsum.photos/seed/907/600',
                              width: 160,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Text(
                              'Date Night',
                              style: FlutterFlowTheme.title3,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ).animated([animationsMap['rowOnPageLoadAnimation5']]),
                ),
              ],
            ),
          ),
        ),
      ).animated([animationsMap['containerOnPageLoadAnimation']]),
    );
  }
}
