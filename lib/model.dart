import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';

part 'model.g.dart';

const tableCategory = SqfEntityTable(
    tableName: 'location',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true, // ?? no idea daca sa patram asta sau nu asa ca momentan o las
    modelName: null,
    fields: [
      SqfEntityField('data', DbType.text),
      SqfEntityField('datetime', DbType.datetime), // nu cred ca pot da un lambda cu datetime.now() dar o sa mai incerc
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
    databaseTables: [tableCategory,
    ],
    sequences: [seqIdentity],
    bundledDatabasePath: null
);
