import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'social_posts_record.g.dart';

abstract class SocialPostsRecord
    implements Built<SocialPostsRecord, SocialPostsRecordBuilder> {
  static Serializer<SocialPostsRecord> get serializer =>
      _$socialPostsRecordSerializer;

  @nullable
  DateTime get postCreated;

  @nullable
  String get postImage;

  @nullable
  String get postVideo;

  @nullable
  String get postDescription;

  @nullable
  DocumentReference get postUser;

  @nullable
  String get postDisplayName;

  @nullable
  String get postUserImage;

  @nullable
  BuiltList<DocumentReference> get likes;

  @nullable
  @BuiltValueField(wireName: 'num_likes')
  int get numLikes;

  @nullable
  @BuiltValueField(wireName: 'num_comments')
  int get numComments;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(SocialPostsRecordBuilder builder) => builder
    ..postImage = ''
    ..postVideo = ''
    ..postDescription = ''
    ..postDisplayName = ''
    ..postUserImage = ''
    ..likes = ListBuilder()
    ..numLikes = 0
    ..numComments = 0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('socialPosts');

  static Stream<SocialPostsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<SocialPostsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static SocialPostsRecord fromAlgolia(AlgoliaObjectSnapshot snapshot) =>
      SocialPostsRecord(
        (c) => c
          ..postCreated = safeGet(() =>
              DateTime.fromMillisecondsSinceEpoch(snapshot.data['postCreated']))
          ..postImage = snapshot.data['postImage']
          ..postVideo = snapshot.data['postVideo']
          ..postDescription = snapshot.data['postDescription']
          ..postUser = safeGet(() => toRef(snapshot.data['postUser']))
          ..postDisplayName = snapshot.data['postDisplayName']
          ..postUserImage = snapshot.data['postUserImage']
          ..likes = safeGet(
              () => ListBuilder(snapshot.data['likes'].map((s) => toRef(s))))
          ..numLikes = snapshot.data['num_likes']
          ..numComments = snapshot.data['num_comments']
          ..reference = SocialPostsRecord.collection.doc(snapshot.objectID),
      );

  static Future<List<SocialPostsRecord>> search(
          {String term,
          FutureOr<LatLng> location,
          int maxResults,
          double searchRadiusMeters}) =>
      FFAlgoliaManager.instance
          .algoliaQuery(
            index: 'socialPosts',
            term: term,
            maxResults: maxResults,
            location: location,
            searchRadiusMeters: searchRadiusMeters,
          )
          .then((r) => r.map(fromAlgolia).toList());

  SocialPostsRecord._();
  factory SocialPostsRecord([void Function(SocialPostsRecordBuilder) updates]) =
      _$SocialPostsRecord;

  static SocialPostsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createSocialPostsRecordData({
  DateTime postCreated,
  String postImage,
  String postVideo,
  String postDescription,
  DocumentReference postUser,
  String postDisplayName,
  String postUserImage,
  int numLikes,
  int numComments,
}) =>
    serializers.toFirestore(
        SocialPostsRecord.serializer,
        SocialPostsRecord((s) => s
          ..postCreated = postCreated
          ..postImage = postImage
          ..postVideo = postVideo
          ..postDescription = postDescription
          ..postUser = postUser
          ..postDisplayName = postDisplayName
          ..postUserImage = postUserImage
          ..likes = null
          ..numLikes = numLikes
          ..numComments = numComments));
