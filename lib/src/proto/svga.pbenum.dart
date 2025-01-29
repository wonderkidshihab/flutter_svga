//  Generated code. Do not modify.
//  source: svga.proto
//
// @dart = '3.6.1'
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ShapeEntity_ShapeType extends $pb.ProtobufEnum {
  static const ShapeEntity_ShapeType shape = ShapeEntity_ShapeType._(
      0,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'SHAPE');
  static const ShapeEntity_ShapeType rect = ShapeEntity_ShapeType._(
      1,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'RECT');
  static const ShapeEntity_ShapeType ellipse = ShapeEntity_ShapeType._(
      2,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'ELLIPSE');
  static const ShapeEntity_ShapeType keep = ShapeEntity_ShapeType._(
      3,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'KEEP');

  static const $core.List<ShapeEntity_ShapeType> values =
      <ShapeEntity_ShapeType>[
    shape,
    rect,
    ellipse,
    keep,
  ];

  static final $core.Map<$core.int, ShapeEntity_ShapeType> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static ShapeEntity_ShapeType? valueOf($core.int value) => _byValue[value];

  const ShapeEntity_ShapeType._(super.v, super.n);
}

class ShapeEntity_ShapeStyle_LineCap extends $pb.ProtobufEnum {
  static const ShapeEntity_ShapeStyle_LineCap lineCapButt =
      ShapeEntity_ShapeStyle_LineCap._(
          0,
          const $core.bool.fromEnvironment('protobuf.omit_enum_names')
              ? ''
              : 'LineCap_BUTT');
  static const ShapeEntity_ShapeStyle_LineCap lineCapROUND =
      ShapeEntity_ShapeStyle_LineCap._(
          1,
          const $core.bool.fromEnvironment('protobuf.omit_enum_names')
              ? ''
              : 'LineCap_ROUND');
  static const ShapeEntity_ShapeStyle_LineCap lineCapSQUARE =
      ShapeEntity_ShapeStyle_LineCap._(
          2,
          const $core.bool.fromEnvironment('protobuf.omit_enum_names')
              ? ''
              : 'LineCap_SQUARE');

  static const $core.List<ShapeEntity_ShapeStyle_LineCap> values =
      <ShapeEntity_ShapeStyle_LineCap>[
    lineCapButt,
    lineCapROUND,
    lineCapSQUARE,
  ];

  static final $core.Map<$core.int, ShapeEntity_ShapeStyle_LineCap> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static ShapeEntity_ShapeStyle_LineCap? valueOf($core.int value) =>
      _byValue[value];

  const ShapeEntity_ShapeStyle_LineCap._(super.v, super.n);
}

class ShapeEntity_ShapeStyle_LineJoin extends $pb.ProtobufEnum {
  static const ShapeEntity_ShapeStyle_LineJoin lineJoinMITER =
      ShapeEntity_ShapeStyle_LineJoin._(
          0,
          const $core.bool.fromEnvironment('protobuf.omit_enum_names')
              ? ''
              : 'LineJoin_MITER');
  static const ShapeEntity_ShapeStyle_LineJoin lineJoinROUND =
      ShapeEntity_ShapeStyle_LineJoin._(
          1,
          const $core.bool.fromEnvironment('protobuf.omit_enum_names')
              ? ''
              : 'LineJoin_ROUND');
  static const ShapeEntity_ShapeStyle_LineJoin lineJoinBEVEL =
      ShapeEntity_ShapeStyle_LineJoin._(
          2,
          const $core.bool.fromEnvironment('protobuf.omit_enum_names')
              ? ''
              : 'LineJoin_BEVEL');

  static const $core.List<ShapeEntity_ShapeStyle_LineJoin> values =
      <ShapeEntity_ShapeStyle_LineJoin>[
    lineJoinMITER,
    lineJoinROUND,
    lineJoinBEVEL,
  ];

  static final $core.Map<$core.int, ShapeEntity_ShapeStyle_LineJoin> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static ShapeEntity_ShapeStyle_LineJoin? valueOf($core.int value) =>
      _byValue[value];

  const ShapeEntity_ShapeStyle_LineJoin._(super.v, super.n);
}
