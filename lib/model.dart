import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';

part 'model.g.dart';


const tableUser = SqfEntityTable(
  tableName: 'user',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  useSoftDeleting: true, // ?? no idea daca sa patram asta sau nu asa ca momentan o las
  modelName: null,
  fields: [
    SqfEntityField('name', DbType.real),
    SqfEntityField('opk', DbType.text),
    // sso
    // profile picture
//    SqfEntityField('', DbType.real),
  ]
);

const tableTrip = SqfEntityTable(
  tableName: 'trip',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  useSoftDeleting: true, // ?? no idea daca sa patram asta sau nu asa ca momentan o las
  modelName: null,
  fields: [
    SqfEntityFieldRelationship(
      parentTable: tableUser,
      deleteRule: DeleteRule.CASCADE,
      defaultValue: null
    ),
    SqfEntityField('starttime', DbType.datetime), //default timezone.now()
    SqfEntityField('endtime', DbType.datetime),
  ]
);

const tableLocation = SqfEntityTable(
    tableName: 'location',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true, // ?? no idea daca sa patram asta sau nu asa ca momentan o las
    modelName: null,
    fields: [
      SqfEntityField('datetime', DbType.datetime), // nu cred ca pot da un lambda cu datetime.now() dar o sa mai incerc
      SqfEntityField('longitude', DbType.real),
      SqfEntityField('latitude', DbType.real),
      SqfEntityField('altitude', DbType.real),
      SqfEntityField('accuracy', DbType.real),
      SqfEntityField('heading', DbType.real),
      SqfEntityField('speed', DbType.real),
      SqfEntityField('timestamp', DbType.real), // timestamp given by geolocator
      SqfEntityField('speedAccuracy', DbType.real),
      SqfEntityFieldRelationship(
          parentTable: tableTrip,
          deleteRule: DeleteRule.CASCADE,
          defaultValue: '0'),
    ]
);

const seqIdentity = SqfEntitySequence(
  sequenceName: 'identity',
  maxValue: null,
);
//default is max int (9.223.372.036.854.775.807) modelName: null /* optional. SqfEntity will set it to sequenceName automatically when the modelName is null*/
//cycle:  false /* optional. default is false; */
//minValue: 0   /* optional. default is 0 */
//incrementBy: 1; /* optional. default is 1 */
//startWith : 0;   /* optional. default is 0 */


@SqfEntityBuilder(myDbModel)
const myDbModel = SqfEntityModel(
    modelName: 'MyDbModel', // optional
    databaseName: 'sampleORM.db',
    databaseTables: [
      tableUser, tableTrip, tableLocation
    ],
    sequences: [seqIdentity],
    bundledDatabasePath: null
);
