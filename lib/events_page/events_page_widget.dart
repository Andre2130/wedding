import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../create_event/create_event_widget.dart';
import '../event_details/event_details_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class EventsPageWidget extends StatefulWidget {
  const EventsPageWidget({Key key}) : super(key: key);

  @override
  _EventsPageWidgetState createState() => _EventsPageWidgetState();
}

class _EventsPageWidgetState extends State<EventsPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GuestsRecord>(
      stream: GuestsRecord.getDocument(currentUserReference),
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
        final eventsPageGuestsRecord = snapshot.data;
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.black,
            automaticallyImplyLeading: false,
            title: Text(
              'Events',
              style: FlutterFlowTheme.title2,
            ),
            actions: [],
            centerTitle: false,
            elevation: 0,
          ),
          backgroundColor: Colors.black,
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.bottomToTop,
                  duration: Duration(milliseconds: 250),
                  reverseDuration: Duration(milliseconds: 250),
                  child: CreateEventWidget(),
                ),
              );
            },
            backgroundColor: FlutterFlowTheme.primaryColor,
            elevation: 8,
            child: Icon(
              Icons.add_rounded,
              color: FlutterFlowTheme.lightText,
              size: 32,
            ),
          ),
          body: SafeArea(
            child: StreamBuilder<List<EventsRecord>>(
              stream: queryEventsRecord(
                queryBuilder: (eventsRecord) =>
                    eventsRecord.orderBy('name', descending: true),
              ),
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
                List<EventsRecord> listViewEventsRecordList = snapshot.data;
                if (listViewEventsRecordList.isEmpty) {
                  return Center(
                    child: Image.asset(
                      'assets/images/Empty_noEvents@2x.png',
                      width: MediaQuery.of(context).size.width * 0.8,
                      fit: BoxFit.cover,
                    ),
                  );
                }
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: listViewEventsRecordList.length,
                  itemBuilder: (context, listViewIndex) {
                    final listViewEventsRecord =
                        listViewEventsRecordList[listViewIndex];
                    return Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 8),
                      child: InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EventDetailsWidget(
                                eventDetails: listViewEventsRecord,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.darkLines,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5,
                                color: Color(0x36000000),
                                offset: Offset(0, 2),
                              )
                            ],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: CachedNetworkImage(
                                    imageUrl: valueOrDefault<String>(
                                      listViewEventsRecord.mainImage,
                                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/wedding-app-anuwld/assets/k4kvz37vey3d/helena-hertz-K0FidtcDQik-unsplash.jpg',
                                    ),
                                    width: double.infinity,
                                    height: 140,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      8, 12, 8, 4),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              listViewEventsRecord.name,
                                              style: FlutterFlowTheme.title2,
                                            ),
                                            Text(
                                              listViewEventsRecord.description,
                                              style: FlutterFlowTheme.subtitle2,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 4),
                                            child: Text(
                                              dateTimeFormat('yMd',
                                                  listViewEventsRecord.date),
                                              style: FlutterFlowTheme.subtitle2,
                                            ),
                                          ),
                                          Text(
                                            dateTimeFormat('jms',
                                                listViewEventsRecord.time),
                                            textAlign: TextAlign.end,
                                            style: FlutterFlowTheme.title3,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
