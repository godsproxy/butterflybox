import '/auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/chat/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'all_chats_page_model.dart';
export 'all_chats_page_model.dart';

class AllChatsPageWidget extends StatefulWidget {
  const AllChatsPageWidget({Key? key}) : super(key: key);

  @override
  _AllChatsPageWidgetState createState() => _AllChatsPageWidgetState();
}

class _AllChatsPageWidgetState extends State<AllChatsPageWidget> {
  late AllChatsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AllChatsPageModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'allChatsPage'});
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Title(
        title: 'allChatsPage',
        color: FlutterFlowTheme.of(context).primaryColor,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              logFirebaseEvent('ALL_CHATS_FloatingActionButton_ha82ooiy_');
              logFirebaseEvent('FloatingActionButton_navigate_to');

              context.pushNamed('createGroupChat');
            },
            backgroundColor: FlutterFlowTheme.of(context).primaryColor,
            elevation: 8.0,
            child: Icon(
              Icons.add_rounded,
              color: Colors.white,
              size: 36.0,
            ),
          ),
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            automaticallyImplyLeading: false,
            title: Text(
              'Messages',
              style: FlutterFlowTheme.of(context).title2,
            ),
            actions: [],
            centerTitle: false,
            elevation: 0.0,
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 0.0),
              child: StreamBuilder<List<ChatsRecord>>(
                stream: queryChatsRecord(
                  queryBuilder: (chatsRecord) => chatsRecord
                      .where('users', arrayContains: currentUserReference)
                      .orderBy('last_message_time', descending: true),
                ),
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: CircularProgressIndicator(
                          color: FlutterFlowTheme.of(context).primaryColor,
                        ),
                      ),
                    );
                  }
                  List<ChatsRecord> listViewChatsRecordList = snapshot.data!;
                  if (listViewChatsRecordList.isEmpty) {
                    return Center(
                      child: Image.asset(
                        'assets/images/messagesMainEmpty@2x.png',
                        width: MediaQuery.of(context).size.width * 0.76,
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: listViewChatsRecordList.length,
                    itemBuilder: (context, listViewIndex) {
                      final listViewChatsRecord =
                          listViewChatsRecordList[listViewIndex];
                      return StreamBuilder<FFChatInfo>(
                        stream: FFChatManager.instance
                            .getChatInfo(chatRecord: listViewChatsRecord),
                        builder: (context, snapshot) {
                          final chatInfo =
                              snapshot.data ?? FFChatInfo(listViewChatsRecord);
                          return FFChatPreview(
                            onTap: () => context.pushNamed(
                              'chatPage',
                              queryParams: {
                                'chatUser': serializeParam(
                                  chatInfo.otherUsers.length == 1
                                      ? chatInfo.otherUsersList.first
                                      : null,
                                  ParamType.Document,
                                ),
                                'chatRef': serializeParam(
                                  chatInfo.chatRecord.reference,
                                  ParamType.DocumentReference,
                                ),
                              }.withoutNulls,
                              extra: <String, dynamic>{
                                'chatUser': chatInfo.otherUsers.length == 1
                                    ? chatInfo.otherUsersList.first
                                    : null,
                              },
                            ),
                            lastChatText: chatInfo.chatPreviewMessage(),
                            lastChatTime: listViewChatsRecord.lastMessageTime,
                            seen: listViewChatsRecord.lastMessageSeenBy!
                                .contains(currentUserReference),
                            title: chatInfo.chatPreviewTitle(),
                            userProfilePic: chatInfo.chatPreviewPic(),
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            unreadColor:
                                FlutterFlowTheme.of(context).primaryColor,
                            titleTextStyle: GoogleFonts.getFont(
                              'Outfit',
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              fontStyle: FontStyle.normal,
                            ),
                            dateTextStyle: GoogleFonts.getFont(
                              'Urbanist',
                              color: Color(0xFF95A1AC),
                              fontWeight: FontWeight.normal,
                              fontSize: 14.0,
                            ),
                            previewTextStyle: GoogleFonts.getFont(
                              'Urbanist',
                              color: Color(0xFF95A1AC),
                              fontWeight: FontWeight.normal,
                              fontSize: 14.0,
                            ),
                            contentPadding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 3.0, 3.0, 3.0),
                            borderRadius: BorderRadius.circular(0.0),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ));
  }
}
