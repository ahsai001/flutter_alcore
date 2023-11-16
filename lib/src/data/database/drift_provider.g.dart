// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_provider.dart';

// ignore_for_file: type=lint
class $DataUnitsTable extends DataUnits
    with TableInfo<$DataUnitsTable, DataUnit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DataUnitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _unitCodeMeta =
      const VerificationMeta('unitCode');
  @override
  late final GeneratedColumn<String> unitCode = GeneratedColumn<String>(
      'unit_code', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _unitNameMeta =
      const VerificationMeta('unitName');
  @override
  late final GeneratedColumn<String> unitName = GeneratedColumn<String>(
      'unit_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
      'model_no', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _projectMeta =
      const VerificationMeta('project');
  @override
  late final GeneratedColumn<String> project = GeneratedColumn<String>(
      'region_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _costCenterMeta =
      const VerificationMeta('costCenter');
  @override
  late final GeneratedColumn<String> costCenter = GeneratedColumn<String>(
      'dept_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, unitCode, unitName, model, project, costCenter];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'data_units';
  @override
  VerificationContext validateIntegrity(Insertable<DataUnit> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('unit_code')) {
      context.handle(_unitCodeMeta,
          unitCode.isAcceptableOrUnknown(data['unit_code']!, _unitCodeMeta));
    } else if (isInserting) {
      context.missing(_unitCodeMeta);
    }
    if (data.containsKey('unit_name')) {
      context.handle(_unitNameMeta,
          unitName.isAcceptableOrUnknown(data['unit_name']!, _unitNameMeta));
    } else if (isInserting) {
      context.missing(_unitNameMeta);
    }
    if (data.containsKey('model_no')) {
      context.handle(_modelMeta,
          model.isAcceptableOrUnknown(data['model_no']!, _modelMeta));
    } else if (isInserting) {
      context.missing(_modelMeta);
    }
    if (data.containsKey('region_code')) {
      context.handle(_projectMeta,
          project.isAcceptableOrUnknown(data['region_code']!, _projectMeta));
    } else if (isInserting) {
      context.missing(_projectMeta);
    }
    if (data.containsKey('dept_code')) {
      context.handle(
          _costCenterMeta,
          costCenter.isAcceptableOrUnknown(
              data['dept_code']!, _costCenterMeta));
    } else if (isInserting) {
      context.missing(_costCenterMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DataUnit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DataUnit(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      unitCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit_code'])!,
      unitName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit_name'])!,
      model: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}model_no'])!,
      project: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}region_code'])!,
      costCenter: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dept_code'])!,
    );
  }

  @override
  $DataUnitsTable createAlias(String alias) {
    return $DataUnitsTable(attachedDatabase, alias);
  }
}

class DataUnit extends DataClass implements Insertable<DataUnit> {
  final int id;
  final String unitCode;
  final String unitName;
  final String model;
  final String project;
  final String costCenter;
  const DataUnit(
      {required this.id,
      required this.unitCode,
      required this.unitName,
      required this.model,
      required this.project,
      required this.costCenter});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['unit_code'] = Variable<String>(unitCode);
    map['unit_name'] = Variable<String>(unitName);
    map['model_no'] = Variable<String>(model);
    map['region_code'] = Variable<String>(project);
    map['dept_code'] = Variable<String>(costCenter);
    return map;
  }

  DataUnitsCompanion toCompanion(bool nullToAbsent) {
    return DataUnitsCompanion(
      id: Value(id),
      unitCode: Value(unitCode),
      unitName: Value(unitName),
      model: Value(model),
      project: Value(project),
      costCenter: Value(costCenter),
    );
  }

  factory DataUnit.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DataUnit(
      id: serializer.fromJson<int>(json['id']),
      unitCode: serializer.fromJson<String>(json['unit_code']),
      unitName: serializer.fromJson<String>(json['unit_name']),
      model: serializer.fromJson<String>(json['model_no']),
      project: serializer.fromJson<String>(json['region_code']),
      costCenter: serializer.fromJson<String>(json['dept_code']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'unit_code': serializer.toJson<String>(unitCode),
      'unit_name': serializer.toJson<String>(unitName),
      'model_no': serializer.toJson<String>(model),
      'region_code': serializer.toJson<String>(project),
      'dept_code': serializer.toJson<String>(costCenter),
    };
  }

  DataUnit copyWith(
          {int? id,
          String? unitCode,
          String? unitName,
          String? model,
          String? project,
          String? costCenter}) =>
      DataUnit(
        id: id ?? this.id,
        unitCode: unitCode ?? this.unitCode,
        unitName: unitName ?? this.unitName,
        model: model ?? this.model,
        project: project ?? this.project,
        costCenter: costCenter ?? this.costCenter,
      );
  @override
  String toString() {
    return (StringBuffer('DataUnit(')
          ..write('id: $id, ')
          ..write('unitCode: $unitCode, ')
          ..write('unitName: $unitName, ')
          ..write('model: $model, ')
          ..write('project: $project, ')
          ..write('costCenter: $costCenter')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, unitCode, unitName, model, project, costCenter);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DataUnit &&
          other.id == this.id &&
          other.unitCode == this.unitCode &&
          other.unitName == this.unitName &&
          other.model == this.model &&
          other.project == this.project &&
          other.costCenter == this.costCenter);
}

class DataUnitsCompanion extends UpdateCompanion<DataUnit> {
  final Value<int> id;
  final Value<String> unitCode;
  final Value<String> unitName;
  final Value<String> model;
  final Value<String> project;
  final Value<String> costCenter;
  const DataUnitsCompanion({
    this.id = const Value.absent(),
    this.unitCode = const Value.absent(),
    this.unitName = const Value.absent(),
    this.model = const Value.absent(),
    this.project = const Value.absent(),
    this.costCenter = const Value.absent(),
  });
  DataUnitsCompanion.insert({
    this.id = const Value.absent(),
    required String unitCode,
    required String unitName,
    required String model,
    required String project,
    required String costCenter,
  })  : unitCode = Value(unitCode),
        unitName = Value(unitName),
        model = Value(model),
        project = Value(project),
        costCenter = Value(costCenter);
  static Insertable<DataUnit> custom({
    Expression<int>? id,
    Expression<String>? unitCode,
    Expression<String>? unitName,
    Expression<String>? model,
    Expression<String>? project,
    Expression<String>? costCenter,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (unitCode != null) 'unit_code': unitCode,
      if (unitName != null) 'unit_name': unitName,
      if (model != null) 'model_no': model,
      if (project != null) 'region_code': project,
      if (costCenter != null) 'dept_code': costCenter,
    });
  }

  DataUnitsCompanion copyWith(
      {Value<int>? id,
      Value<String>? unitCode,
      Value<String>? unitName,
      Value<String>? model,
      Value<String>? project,
      Value<String>? costCenter}) {
    return DataUnitsCompanion(
      id: id ?? this.id,
      unitCode: unitCode ?? this.unitCode,
      unitName: unitName ?? this.unitName,
      model: model ?? this.model,
      project: project ?? this.project,
      costCenter: costCenter ?? this.costCenter,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (unitCode.present) {
      map['unit_code'] = Variable<String>(unitCode.value);
    }
    if (unitName.present) {
      map['unit_name'] = Variable<String>(unitName.value);
    }
    if (model.present) {
      map['model_no'] = Variable<String>(model.value);
    }
    if (project.present) {
      map['region_code'] = Variable<String>(project.value);
    }
    if (costCenter.present) {
      map['dept_code'] = Variable<String>(costCenter.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DataUnitsCompanion(')
          ..write('id: $id, ')
          ..write('unitCode: $unitCode, ')
          ..write('unitName: $unitName, ')
          ..write('model: $model, ')
          ..write('project: $project, ')
          ..write('costCenter: $costCenter')
          ..write(')'))
        .toString();
  }
}

class NotificationEntry extends DataClass
    implements Insertable<NotificationEntry> {
  final int id;
  final String unitCode;
  final String modelNo;
  final String reqDate;
  final String status;
  final String notifType;
  final String jobsite;
  final String bdDate;
  final String bdTime;
  final String problem;
  final String reading;
  final String reportBy;
  final String serialNumber;
  final String database;
  final String user;
  const NotificationEntry(
      {required this.id,
      required this.unitCode,
      required this.modelNo,
      required this.reqDate,
      required this.status,
      required this.notifType,
      required this.jobsite,
      required this.bdDate,
      required this.bdTime,
      required this.problem,
      required this.reading,
      required this.reportBy,
      required this.serialNumber,
      required this.database,
      required this.user});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['unit_code'] = Variable<String>(unitCode);
    map['model_no'] = Variable<String>(modelNo);
    map['req_date'] = Variable<String>(reqDate);
    map['status_trx'] = Variable<String>(status);
    map['notif_type'] = Variable<String>(notifType);
    map['jobsite'] = Variable<String>(jobsite);
    map['trans_date'] = Variable<String>(bdDate);
    map['status_time'] = Variable<String>(bdTime);
    map['problem'] = Variable<String>(problem);
    map['reading'] = Variable<String>(reading);
    map['report_by'] = Variable<String>(reportBy);
    map['SerialNumber'] = Variable<String>(serialNumber);
    map['dbswitch'] = Variable<String>(database);
    map['KdUser'] = Variable<String>(user);
    return map;
  }

  NotificationEntriesCompanion toCompanion(bool nullToAbsent) {
    return NotificationEntriesCompanion(
      id: Value(id),
      unitCode: Value(unitCode),
      modelNo: Value(modelNo),
      reqDate: Value(reqDate),
      status: Value(status),
      notifType: Value(notifType),
      jobsite: Value(jobsite),
      bdDate: Value(bdDate),
      bdTime: Value(bdTime),
      problem: Value(problem),
      reading: Value(reading),
      reportBy: Value(reportBy),
      serialNumber: Value(serialNumber),
      database: Value(database),
      user: Value(user),
    );
  }

  factory NotificationEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationEntry(
      id: serializer.fromJson<int>(json['id']),
      unitCode: serializer.fromJson<String>(json['unit_code']),
      modelNo: serializer.fromJson<String>(json['model_no']),
      reqDate: serializer.fromJson<String>(json['req_date']),
      status: serializer.fromJson<String>(json['status_trx']),
      notifType: serializer.fromJson<String>(json['notif_type']),
      jobsite: serializer.fromJson<String>(json['jobsite']),
      bdDate: serializer.fromJson<String>(json['trans_date']),
      bdTime: serializer.fromJson<String>(json['status_time']),
      problem: serializer.fromJson<String>(json['problem']),
      reading: serializer.fromJson<String>(json['reading']),
      reportBy: serializer.fromJson<String>(json['report_by']),
      serialNumber: serializer.fromJson<String>(json['SerialNumber']),
      database: serializer.fromJson<String>(json['dbswitch']),
      user: serializer.fromJson<String>(json['KdUser']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'unit_code': serializer.toJson<String>(unitCode),
      'model_no': serializer.toJson<String>(modelNo),
      'req_date': serializer.toJson<String>(reqDate),
      'status_trx': serializer.toJson<String>(status),
      'notif_type': serializer.toJson<String>(notifType),
      'jobsite': serializer.toJson<String>(jobsite),
      'trans_date': serializer.toJson<String>(bdDate),
      'status_time': serializer.toJson<String>(bdTime),
      'problem': serializer.toJson<String>(problem),
      'reading': serializer.toJson<String>(reading),
      'report_by': serializer.toJson<String>(reportBy),
      'SerialNumber': serializer.toJson<String>(serialNumber),
      'dbswitch': serializer.toJson<String>(database),
      'KdUser': serializer.toJson<String>(user),
    };
  }

  NotificationEntry copyWith(
          {int? id,
          String? unitCode,
          String? modelNo,
          String? reqDate,
          String? status,
          String? notifType,
          String? jobsite,
          String? bdDate,
          String? bdTime,
          String? problem,
          String? reading,
          String? reportBy,
          String? serialNumber,
          String? database,
          String? user}) =>
      NotificationEntry(
        id: id ?? this.id,
        unitCode: unitCode ?? this.unitCode,
        modelNo: modelNo ?? this.modelNo,
        reqDate: reqDate ?? this.reqDate,
        status: status ?? this.status,
        notifType: notifType ?? this.notifType,
        jobsite: jobsite ?? this.jobsite,
        bdDate: bdDate ?? this.bdDate,
        bdTime: bdTime ?? this.bdTime,
        problem: problem ?? this.problem,
        reading: reading ?? this.reading,
        reportBy: reportBy ?? this.reportBy,
        serialNumber: serialNumber ?? this.serialNumber,
        database: database ?? this.database,
        user: user ?? this.user,
      );
  @override
  String toString() {
    return (StringBuffer('NotificationEntry(')
          ..write('id: $id, ')
          ..write('unitCode: $unitCode, ')
          ..write('modelNo: $modelNo, ')
          ..write('reqDate: $reqDate, ')
          ..write('status: $status, ')
          ..write('notifType: $notifType, ')
          ..write('jobsite: $jobsite, ')
          ..write('bdDate: $bdDate, ')
          ..write('bdTime: $bdTime, ')
          ..write('problem: $problem, ')
          ..write('reading: $reading, ')
          ..write('reportBy: $reportBy, ')
          ..write('serialNumber: $serialNumber, ')
          ..write('database: $database, ')
          ..write('user: $user')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      unitCode,
      modelNo,
      reqDate,
      status,
      notifType,
      jobsite,
      bdDate,
      bdTime,
      problem,
      reading,
      reportBy,
      serialNumber,
      database,
      user);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationEntry &&
          other.id == this.id &&
          other.unitCode == this.unitCode &&
          other.modelNo == this.modelNo &&
          other.reqDate == this.reqDate &&
          other.status == this.status &&
          other.notifType == this.notifType &&
          other.jobsite == this.jobsite &&
          other.bdDate == this.bdDate &&
          other.bdTime == this.bdTime &&
          other.problem == this.problem &&
          other.reading == this.reading &&
          other.reportBy == this.reportBy &&
          other.serialNumber == this.serialNumber &&
          other.database == this.database &&
          other.user == this.user);
}

class NotificationEntriesCompanion extends UpdateCompanion<NotificationEntry> {
  final Value<int> id;
  final Value<String> unitCode;
  final Value<String> modelNo;
  final Value<String> reqDate;
  final Value<String> status;
  final Value<String> notifType;
  final Value<String> jobsite;
  final Value<String> bdDate;
  final Value<String> bdTime;
  final Value<String> problem;
  final Value<String> reading;
  final Value<String> reportBy;
  final Value<String> serialNumber;
  final Value<String> database;
  final Value<String> user;
  const NotificationEntriesCompanion({
    this.id = const Value.absent(),
    this.unitCode = const Value.absent(),
    this.modelNo = const Value.absent(),
    this.reqDate = const Value.absent(),
    this.status = const Value.absent(),
    this.notifType = const Value.absent(),
    this.jobsite = const Value.absent(),
    this.bdDate = const Value.absent(),
    this.bdTime = const Value.absent(),
    this.problem = const Value.absent(),
    this.reading = const Value.absent(),
    this.reportBy = const Value.absent(),
    this.serialNumber = const Value.absent(),
    this.database = const Value.absent(),
    this.user = const Value.absent(),
  });
  NotificationEntriesCompanion.insert({
    this.id = const Value.absent(),
    required String unitCode,
    required String modelNo,
    required String reqDate,
    required String status,
    required String notifType,
    required String jobsite,
    required String bdDate,
    required String bdTime,
    required String problem,
    required String reading,
    required String reportBy,
    required String serialNumber,
    required String database,
    required String user,
  })  : unitCode = Value(unitCode),
        modelNo = Value(modelNo),
        reqDate = Value(reqDate),
        status = Value(status),
        notifType = Value(notifType),
        jobsite = Value(jobsite),
        bdDate = Value(bdDate),
        bdTime = Value(bdTime),
        problem = Value(problem),
        reading = Value(reading),
        reportBy = Value(reportBy),
        serialNumber = Value(serialNumber),
        database = Value(database),
        user = Value(user);
  static Insertable<NotificationEntry> custom({
    Expression<int>? id,
    Expression<String>? unitCode,
    Expression<String>? modelNo,
    Expression<String>? reqDate,
    Expression<String>? status,
    Expression<String>? notifType,
    Expression<String>? jobsite,
    Expression<String>? bdDate,
    Expression<String>? bdTime,
    Expression<String>? problem,
    Expression<String>? reading,
    Expression<String>? reportBy,
    Expression<String>? serialNumber,
    Expression<String>? database,
    Expression<String>? user,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (unitCode != null) 'unit_code': unitCode,
      if (modelNo != null) 'model_no': modelNo,
      if (reqDate != null) 'req_date': reqDate,
      if (status != null) 'status_trx': status,
      if (notifType != null) 'notif_type': notifType,
      if (jobsite != null) 'jobsite': jobsite,
      if (bdDate != null) 'trans_date': bdDate,
      if (bdTime != null) 'status_time': bdTime,
      if (problem != null) 'problem': problem,
      if (reading != null) 'reading': reading,
      if (reportBy != null) 'report_by': reportBy,
      if (serialNumber != null) 'SerialNumber': serialNumber,
      if (database != null) 'dbswitch': database,
      if (user != null) 'KdUser': user,
    });
  }

  NotificationEntriesCompanion copyWith(
      {Value<int>? id,
      Value<String>? unitCode,
      Value<String>? modelNo,
      Value<String>? reqDate,
      Value<String>? status,
      Value<String>? notifType,
      Value<String>? jobsite,
      Value<String>? bdDate,
      Value<String>? bdTime,
      Value<String>? problem,
      Value<String>? reading,
      Value<String>? reportBy,
      Value<String>? serialNumber,
      Value<String>? database,
      Value<String>? user}) {
    return NotificationEntriesCompanion(
      id: id ?? this.id,
      unitCode: unitCode ?? this.unitCode,
      modelNo: modelNo ?? this.modelNo,
      reqDate: reqDate ?? this.reqDate,
      status: status ?? this.status,
      notifType: notifType ?? this.notifType,
      jobsite: jobsite ?? this.jobsite,
      bdDate: bdDate ?? this.bdDate,
      bdTime: bdTime ?? this.bdTime,
      problem: problem ?? this.problem,
      reading: reading ?? this.reading,
      reportBy: reportBy ?? this.reportBy,
      serialNumber: serialNumber ?? this.serialNumber,
      database: database ?? this.database,
      user: user ?? this.user,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (unitCode.present) {
      map['unit_code'] = Variable<String>(unitCode.value);
    }
    if (modelNo.present) {
      map['model_no'] = Variable<String>(modelNo.value);
    }
    if (reqDate.present) {
      map['req_date'] = Variable<String>(reqDate.value);
    }
    if (status.present) {
      map['status_trx'] = Variable<String>(status.value);
    }
    if (notifType.present) {
      map['notif_type'] = Variable<String>(notifType.value);
    }
    if (jobsite.present) {
      map['jobsite'] = Variable<String>(jobsite.value);
    }
    if (bdDate.present) {
      map['trans_date'] = Variable<String>(bdDate.value);
    }
    if (bdTime.present) {
      map['status_time'] = Variable<String>(bdTime.value);
    }
    if (problem.present) {
      map['problem'] = Variable<String>(problem.value);
    }
    if (reading.present) {
      map['reading'] = Variable<String>(reading.value);
    }
    if (reportBy.present) {
      map['report_by'] = Variable<String>(reportBy.value);
    }
    if (serialNumber.present) {
      map['SerialNumber'] = Variable<String>(serialNumber.value);
    }
    if (database.present) {
      map['dbswitch'] = Variable<String>(database.value);
    }
    if (user.present) {
      map['KdUser'] = Variable<String>(user.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationEntriesCompanion(')
          ..write('id: $id, ')
          ..write('unitCode: $unitCode, ')
          ..write('modelNo: $modelNo, ')
          ..write('reqDate: $reqDate, ')
          ..write('status: $status, ')
          ..write('notifType: $notifType, ')
          ..write('jobsite: $jobsite, ')
          ..write('bdDate: $bdDate, ')
          ..write('bdTime: $bdTime, ')
          ..write('problem: $problem, ')
          ..write('reading: $reading, ')
          ..write('reportBy: $reportBy, ')
          ..write('serialNumber: $serialNumber, ')
          ..write('database: $database, ')
          ..write('user: $user')
          ..write(')'))
        .toString();
  }
}

class NotificationImage extends DataClass
    implements Insertable<NotificationImage> {
  final int id;
  final String subject;
  final String message;
  final String image;
  final int? notificationEntry;
  const NotificationImage(
      {required this.id,
      required this.subject,
      required this.message,
      required this.image,
      this.notificationEntry});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['subject'] = Variable<String>(subject);
    map['message'] = Variable<String>(message);
    map['img'] = Variable<String>(image);
    if (!nullToAbsent || notificationEntry != null) {
      map['notification_entry'] = Variable<int>(notificationEntry);
    }
    return map;
  }

  NotificationImagesCompanion toCompanion(bool nullToAbsent) {
    return NotificationImagesCompanion(
      id: Value(id),
      subject: Value(subject),
      message: Value(message),
      image: Value(image),
      notificationEntry: notificationEntry == null && nullToAbsent
          ? const Value.absent()
          : Value(notificationEntry),
    );
  }

  factory NotificationImage.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationImage(
      id: serializer.fromJson<int>(json['id']),
      subject: serializer.fromJson<String>(json['subject']),
      message: serializer.fromJson<String>(json['message']),
      image: serializer.fromJson<String>(json['img']),
      notificationEntry: serializer.fromJson<int?>(json['notificationEntry']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'subject': serializer.toJson<String>(subject),
      'message': serializer.toJson<String>(message),
      'img': serializer.toJson<String>(image),
      'notificationEntry': serializer.toJson<int?>(notificationEntry),
    };
  }

  NotificationImage copyWith(
          {int? id,
          String? subject,
          String? message,
          String? image,
          Value<int?> notificationEntry = const Value.absent()}) =>
      NotificationImage(
        id: id ?? this.id,
        subject: subject ?? this.subject,
        message: message ?? this.message,
        image: image ?? this.image,
        notificationEntry: notificationEntry.present
            ? notificationEntry.value
            : this.notificationEntry,
      );
  @override
  String toString() {
    return (StringBuffer('NotificationImage(')
          ..write('id: $id, ')
          ..write('subject: $subject, ')
          ..write('message: $message, ')
          ..write('image: $image, ')
          ..write('notificationEntry: $notificationEntry')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, subject, message, image, notificationEntry);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationImage &&
          other.id == this.id &&
          other.subject == this.subject &&
          other.message == this.message &&
          other.image == this.image &&
          other.notificationEntry == this.notificationEntry);
}

class NotificationImagesCompanion extends UpdateCompanion<NotificationImage> {
  final Value<int> id;
  final Value<String> subject;
  final Value<String> message;
  final Value<String> image;
  final Value<int?> notificationEntry;
  const NotificationImagesCompanion({
    this.id = const Value.absent(),
    this.subject = const Value.absent(),
    this.message = const Value.absent(),
    this.image = const Value.absent(),
    this.notificationEntry = const Value.absent(),
  });
  NotificationImagesCompanion.insert({
    this.id = const Value.absent(),
    required String subject,
    required String message,
    required String image,
    this.notificationEntry = const Value.absent(),
  })  : subject = Value(subject),
        message = Value(message),
        image = Value(image);
  static Insertable<NotificationImage> custom({
    Expression<int>? id,
    Expression<String>? subject,
    Expression<String>? message,
    Expression<String>? image,
    Expression<int>? notificationEntry,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (subject != null) 'subject': subject,
      if (message != null) 'message': message,
      if (image != null) 'img': image,
      if (notificationEntry != null) 'notification_entry': notificationEntry,
    });
  }

  NotificationImagesCompanion copyWith(
      {Value<int>? id,
      Value<String>? subject,
      Value<String>? message,
      Value<String>? image,
      Value<int?>? notificationEntry}) {
    return NotificationImagesCompanion(
      id: id ?? this.id,
      subject: subject ?? this.subject,
      message: message ?? this.message,
      image: image ?? this.image,
      notificationEntry: notificationEntry ?? this.notificationEntry,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (subject.present) {
      map['subject'] = Variable<String>(subject.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (image.present) {
      map['img'] = Variable<String>(image.value);
    }
    if (notificationEntry.present) {
      map['notification_entry'] = Variable<int>(notificationEntry.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationImagesCompanion(')
          ..write('id: $id, ')
          ..write('subject: $subject, ')
          ..write('message: $message, ')
          ..write('image: $image, ')
          ..write('notificationEntry: $notificationEntry')
          ..write(')'))
        .toString();
  }
}

class ProjectArea extends DataClass implements Insertable<ProjectArea> {
  final int id;
  final String code;
  final String regionCode;
  final String regionName;
  final String statusDefaultRegion;
  final int datePeriod;
  final int cek;
  const ProjectArea(
      {required this.id,
      required this.code,
      required this.regionCode,
      required this.regionName,
      required this.statusDefaultRegion,
      required this.datePeriod,
      required this.cek});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['code'] = Variable<String>(code);
    map['region_code'] = Variable<String>(regionCode);
    map['region_name'] = Variable<String>(regionName);
    map['status_default_region'] = Variable<String>(statusDefaultRegion);
    map['date_period'] = Variable<int>(datePeriod);
    map['cek'] = Variable<int>(cek);
    return map;
  }

  ProjectAreasCompanion toCompanion(bool nullToAbsent) {
    return ProjectAreasCompanion(
      id: Value(id),
      code: Value(code),
      regionCode: Value(regionCode),
      regionName: Value(regionName),
      statusDefaultRegion: Value(statusDefaultRegion),
      datePeriod: Value(datePeriod),
      cek: Value(cek),
    );
  }

  factory ProjectArea.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProjectArea(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      regionCode: serializer.fromJson<String>(json['region_code']),
      regionName: serializer.fromJson<String>(json['region_name']),
      statusDefaultRegion:
          serializer.fromJson<String>(json['status_default_region']),
      datePeriod: serializer.fromJson<int>(json['date_period']),
      cek: serializer.fromJson<int>(json['cek']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String>(code),
      'region_code': serializer.toJson<String>(regionCode),
      'region_name': serializer.toJson<String>(regionName),
      'status_default_region': serializer.toJson<String>(statusDefaultRegion),
      'date_period': serializer.toJson<int>(datePeriod),
      'cek': serializer.toJson<int>(cek),
    };
  }

  ProjectArea copyWith(
          {int? id,
          String? code,
          String? regionCode,
          String? regionName,
          String? statusDefaultRegion,
          int? datePeriod,
          int? cek}) =>
      ProjectArea(
        id: id ?? this.id,
        code: code ?? this.code,
        regionCode: regionCode ?? this.regionCode,
        regionName: regionName ?? this.regionName,
        statusDefaultRegion: statusDefaultRegion ?? this.statusDefaultRegion,
        datePeriod: datePeriod ?? this.datePeriod,
        cek: cek ?? this.cek,
      );
  @override
  String toString() {
    return (StringBuffer('ProjectArea(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('regionCode: $regionCode, ')
          ..write('regionName: $regionName, ')
          ..write('statusDefaultRegion: $statusDefaultRegion, ')
          ..write('datePeriod: $datePeriod, ')
          ..write('cek: $cek')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, code, regionCode, regionName, statusDefaultRegion, datePeriod, cek);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProjectArea &&
          other.id == this.id &&
          other.code == this.code &&
          other.regionCode == this.regionCode &&
          other.regionName == this.regionName &&
          other.statusDefaultRegion == this.statusDefaultRegion &&
          other.datePeriod == this.datePeriod &&
          other.cek == this.cek);
}

class ProjectAreasCompanion extends UpdateCompanion<ProjectArea> {
  final Value<int> id;
  final Value<String> code;
  final Value<String> regionCode;
  final Value<String> regionName;
  final Value<String> statusDefaultRegion;
  final Value<int> datePeriod;
  final Value<int> cek;
  const ProjectAreasCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.regionCode = const Value.absent(),
    this.regionName = const Value.absent(),
    this.statusDefaultRegion = const Value.absent(),
    this.datePeriod = const Value.absent(),
    this.cek = const Value.absent(),
  });
  ProjectAreasCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    required String regionCode,
    required String regionName,
    required String statusDefaultRegion,
    required int datePeriod,
    required int cek,
  })  : code = Value(code),
        regionCode = Value(regionCode),
        regionName = Value(regionName),
        statusDefaultRegion = Value(statusDefaultRegion),
        datePeriod = Value(datePeriod),
        cek = Value(cek);
  static Insertable<ProjectArea> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<String>? regionCode,
    Expression<String>? regionName,
    Expression<String>? statusDefaultRegion,
    Expression<int>? datePeriod,
    Expression<int>? cek,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (regionCode != null) 'region_code': regionCode,
      if (regionName != null) 'region_name': regionName,
      if (statusDefaultRegion != null)
        'status_default_region': statusDefaultRegion,
      if (datePeriod != null) 'date_period': datePeriod,
      if (cek != null) 'cek': cek,
    });
  }

  ProjectAreasCompanion copyWith(
      {Value<int>? id,
      Value<String>? code,
      Value<String>? regionCode,
      Value<String>? regionName,
      Value<String>? statusDefaultRegion,
      Value<int>? datePeriod,
      Value<int>? cek}) {
    return ProjectAreasCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      regionCode: regionCode ?? this.regionCode,
      regionName: regionName ?? this.regionName,
      statusDefaultRegion: statusDefaultRegion ?? this.statusDefaultRegion,
      datePeriod: datePeriod ?? this.datePeriod,
      cek: cek ?? this.cek,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (regionCode.present) {
      map['region_code'] = Variable<String>(regionCode.value);
    }
    if (regionName.present) {
      map['region_name'] = Variable<String>(regionName.value);
    }
    if (statusDefaultRegion.present) {
      map['status_default_region'] =
          Variable<String>(statusDefaultRegion.value);
    }
    if (datePeriod.present) {
      map['date_period'] = Variable<int>(datePeriod.value);
    }
    if (cek.present) {
      map['cek'] = Variable<int>(cek.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProjectAreasCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('regionCode: $regionCode, ')
          ..write('regionName: $regionName, ')
          ..write('statusDefaultRegion: $statusDefaultRegion, ')
          ..write('datePeriod: $datePeriod, ')
          ..write('cek: $cek')
          ..write(')'))
        .toString();
  }
}

abstract class _$DriftProvider extends GeneratedDatabase {
  _$DriftProvider(QueryExecutor e) : super(e);
  late final $DataUnitsTable dataUnits = $DataUnitsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [dataUnits];
}
