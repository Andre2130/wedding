import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'events_record.g.dart';

abstract class EventsRecord
    implements Built<EventsRecord, EventsRecordBuilder> {
  static Serializer<EventsRecord> get serializer => _$eventsRecordSerializer;

  @nullable
  String get name;

  @nullable
  DateTime get time;

  @nullable
  BuiltList<String> get categories;

  @nullable
  DateTime get date;

  @nullable
  String get description;

  @nullable
  BuiltList<String> get photos;

  @nullable
  String get mainImage;

  @nullable
  String get address;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(EventsRecordBuilder builder) => builder
    ..name = ''
    ..categories = ListBuilder()
    ..description = ''
    ..photos = ListBuilder()
    ..mainImage = ''
    ..address = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('events');

  static Stream<EventsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<EventsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static EventsRecord fromAlgolia(AlgoliaObjectSnapshot snapshot) =>
      EventsRecord(
        (c) => c
          ..name = snapshot.data['name']
          ..time = safeGet(
              () => DateTime.fromMillisecondsSinceEpoch(snapshot.data['time']))
          ..categories = safeGet(() => ListBuilder(snapshot.data['categories']))
          ..date = safeGet(
              () => DateTime.fromMillisecondsSinceEpoch(snapshot.data['date']))
          ..description = snapshot.data['description']
          ..photos = safeGet(() => ListBuilder(snapshot.data['photos']))
          ..mainImage = snapshot.data['mainImage']
          ..address = snapshot.data['address']
          ..reference = EventsRecord.collection.doc(snapshot.objectID),
      );

  static Future<List<EventsRecord>> search(
          {String term,
          FutureOr<LatLng> location,
          int maxResults,
          double searchRadiusMeters}) =>
      FFAlgoliaManager.instance
          .algoliaQuery(
            index: 'events',
            term: term,
            maxResults: maxResults,
            location: location,
            searchRadiusMeters: searchRadiusMeters,
          )
          .then((r) => r.map(fromAlgolia).toList());

  EventsRecord._();
  factory EventsRecord([void Function(EventsRecordBuilder) updates]) =
      _$EventsRecord;

  static EventsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createEventsRecordData({
  String name,
  DateTime time,
  DateTime date,
  String description,
  String mainImage,
  String address,
}) =>
    serializers.toFirestore(
        EventsRecord.serializer,
        EventsRecord((e) => e
          ..name = name
          ..time = time
          ..categories = null
          ..date = date
          ..description = description
          ..photos = null
          ..mainImage = mainImage
          ..address = address));
