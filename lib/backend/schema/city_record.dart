import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'city_record.g.dart';

abstract class CityRecord implements Built<CityRecord, CityRecordBuilder> {
  static Serializer<CityRecord> get serializer => _$cityRecordSerializer;

  @nullable
  LatLng get location;

  @nullable
  String get cityName;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(CityRecordBuilder builder) =>
      builder..cityName = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('city');

  static Stream<CityRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<CityRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static CityRecord fromAlgolia(AlgoliaObjectSnapshot snapshot) => CityRecord(
        (c) => c
          ..location = safeGet(() => LatLng(
                snapshot.data['_geoloc']['lat'],
                snapshot.data['_geoloc']['lng'],
              ))
          ..cityName = snapshot.data['cityName']
          ..reference = CityRecord.collection.doc(snapshot.objectID),
      );

  static Future<List<CityRecord>> search(
          {String term,
          FutureOr<LatLng> location,
          int maxResults,
          double searchRadiusMeters}) =>
      FFAlgoliaManager.instance
          .algoliaQuery(
            index: 'city',
            term: term,
            maxResults: maxResults,
            location: location,
            searchRadiusMeters: searchRadiusMeters,
          )
          .then((r) => r.map(fromAlgolia).toList());

  CityRecord._();
  factory CityRecord([void Function(CityRecordBuilder) updates]) = _$CityRecord;

  static CityRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createCityRecordData({
  LatLng location,
  String cityName,
}) =>
    serializers.toFirestore(
        CityRecord.serializer,
        CityRecord((c) => c
          ..location = location
          ..cityName = cityName));
