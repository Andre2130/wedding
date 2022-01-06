import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../post_create/post_create_widget.dart';
import '../post_details/post_details_widget.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class SocialFeedWidget extends StatefulWidget {
  const SocialFeedWidget({Key key}) : super(key: key);

  @override
  _SocialFeedWidgetState createState() => _SocialFeedWidgetState();
}

class _SocialFeedWidgetState extends State<SocialFeedWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Text(
          'Our Memories',
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
              child: PostCreateWidget(),
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
        child: StreamBuilder<List<SocialPostsRecord>>(
          stream: querySocialPostsRecord(
            queryBuilder: (socialPostsRecord) =>
                socialPostsRecord.orderBy('postCreated', descending: true),
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
            List<SocialPostsRecord> listViewSocialPostsRecordList =
                snapshot.data;
            if (listViewSocialPostsRecordList.isEmpty) {
              return Center(
                child: Image.asset(
                  'assets/images/empty_noMemories@2x.png',
                  width: MediaQuery.of(context).size.width * 0.8,
                ),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: listViewSocialPostsRecordList.length,
              itemBuilder: (context, listViewIndex) {
                final listViewSocialPostsRecord =
                    listViewSocialPostsRecordList[listViewIndex];
                return Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 8),
                  child: InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostDetailsWidget(
                            postDetails: listViewSocialPostsRecord,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                        color: Color(0xFF262D34),
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
                                  listViewSocialPostsRecord.postImage,
                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/wedding-app-anuwld/assets/k4kvz37vey3d/helena-hertz-K0FidtcDQik-unsplash.jpg',
                                ),
                                width: double.infinity,
                                height: 290,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 12, 8, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          valueOrDefault<String>(
                                            listViewSocialPostsRecord
                                                .postUserImage,
                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/wedding-app-anuwld/assets/udoiek8lgxbr/userUpload@2x.png',
                                          ),
                                          width: 40,
                                          height: 40,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12, 0, 0, 0),
                                        child: Text(
                                          listViewSocialPostsRecord
                                              .postDisplayName,
                                          style: FlutterFlowTheme.subtitle1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    dateTimeFormat('relative',
                                        listViewSocialPostsRecord.postCreated),
                                    style: FlutterFlowTheme.bodyText1,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 0, 8, 0),
                                      child: Text(
                                        listViewSocialPostsRecord
                                            .postDescription,
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Cormorant Garamond',
                                          color: FlutterFlowTheme.darkText,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  FlutterFlowIconButton(
                                    borderColor: Colors.transparent,
                                    borderRadius: 30,
                                    borderWidth: 1,
                                    buttonSize: 44,
                                    icon: Icon(
                                      Icons.forum_outlined,
                                      color: FlutterFlowTheme.grayIcon,
                                      size: 24,
                                    ),
                                    onPressed: () {
                                      print('IconButton pressed ...');
                                    },
                                  ),
                                  Text(
                                    functions.numCommentsStr(
                                        listViewSocialPostsRecord),
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Dancing Script',
                                      fontSize: 16,
                                    ),
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
  }
}
