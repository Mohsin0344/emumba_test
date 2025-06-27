import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';
import 'package:http/http.dart' as http;
part 'model.g.dart';
// Define Table for Events
const tableEvents = SqfEntityTable(
  tableName: 'events',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  fields: [
    SqfEntityField('name', DbType.text),
    SqfEntityField('description', DbType.text),
    SqfEntityField('type', DbType.text),
    SqfEntityField('dateTime', DbType.datetime),
    SqfEntityField('attachment', DbType.text),
  ],
);

// Define Database Model
@SqfEntityBuilder(myDbModel)
const myDbModel = SqfEntityModel(
  modelName: 'MyDbModel', // optional
  databaseName: 'events.db',
  databaseTables: [tableEvents],
);
