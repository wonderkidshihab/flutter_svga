import 'dart:developer';
import 'dart:ui' as ui;

import 'package:archive/archive.dart' as archive;
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart' show decodeImageFromList;
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' show get;

import 'proto/svga.pbserver.dart';

const _filterKey = 'SVGAParser';

/// You use SVGAParser to load and decode animation files.
class SVGAParser {
  const SVGAParser();
  static const shared = SVGAParser();

  /// Downloads an SVGA animation file from a specified URL and decodes it into a MovieEntity.
  ///
  /// If the download is successful and the response status is 200, the file is
  /// decoded from the response body bytes and returned as a MovieEntity.
  /// If the download fails, an exception is thrown with the status code.
  /// Any errors during the process are reported using FlutterError.
  ///
  /// Throws an [Exception] if the file cannot be loaded from the URL.
  ///
  /// [url] is the location of the SVGA file to be downloaded and decoded.
  ///
  /// Returns a [Future<MovieEntity>] that completes with the decoded MovieEntity.

  Future<MovieEntity> decodeFromURL(String url) async {
    try {
      final response = await get(Uri.parse(url));
      if (response.statusCode == 200) {
        return decodeFromBuffer(response.bodyBytes);
      } else {
        throw Exception(
            "Failed to load SVGA from $url (Status: ${response.statusCode})");
      }
    } catch (e, stack) {
      FlutterError.reportError(FlutterErrorDetails(
        exception: e,
        stack: stack,
        library: 'SVGAParser',
        context: ErrorDescription('during decodeFromURL'),
      ));
      rethrow;
    }
  }

  /// Load an animation file from the Flutter assets and decode it.
  ///
  /// Loads a file from the Flutter assets and decodes it into a MovieEntity.
  ///
  /// If the file is successfully loaded and decoded, the decoded MovieEntity is
  /// returned.
  /// If the file cannot be loaded or decoded, an exception is thrown with the
  /// error message.
  /// Any errors during the process are reported using FlutterError.
  ///
  /// Throws an [Exception] if the file cannot be loaded or decoded.
  ///
  /// [path] is the path to the animation file in the Flutter assets.
  ///
  /// Returns a [Future<MovieEntity>] that completes with the decoded MovieEntity.
  Future<MovieEntity> decodeFromAssets(String path) async {
    try {
      final ByteData data = await rootBundle.load(path);
      return decodeFromBuffer(data.buffer.asUint8List());
    } catch (e, stack) {
      FlutterError.reportError(FlutterErrorDetails(
        exception: e,
        stack: stack,
        library: 'SVGAParser',
        context: ErrorDescription('Error loading SVGA file from assets: $path'),
      ));
      rethrow;
    }
  }

  /// Decodes a MovieEntity from a list of bytes.
  ///
  /// This function decompresses the bytes and then decodes the MovieEntity
  /// from the decompressed bytes. The function returns a Future that completes
  /// with the decoded MovieEntity after the MovieEntity has been prepared.
  ///
  /// In release mode, the function does not record any timeline events.
  ///
  /// In debug mode, the function records timeline events for the following:
  /// - Decoding the MovieEntity from the decompressed bytes
  /// - Preparing the MovieEntity
  /// The timeline events are recorded with the filter key 'SVGAParser'.
  Future<MovieEntity> decodeFromBuffer(List<int> bytes) {
    TimelineTask? timeline;
    if (!kReleaseMode) {
      timeline = TimelineTask(filterKey: _filterKey)
        ..start('DecodeFromBuffer', arguments: {'length': bytes.length});
    }
    final inflatedBytes = const archive.ZLibDecoder().decodeBytes(bytes);
    if (timeline != null) {
      timeline.instant('MovieEntity.fromBuffer()',
          arguments: {'inflatedLength': inflatedBytes.length});
    }
    final movie = MovieEntity.fromBuffer(inflatedBytes);
    if (timeline != null) {
      timeline.instant('prepareResources()',
          arguments: {'images': movie.images.keys.join(',')});
    }
    return _prepareResources(
      _processShapeItems(movie),
      timeline: timeline,
    ).whenComplete(() {
      if (timeline != null) timeline.finish();
    });
  }

  MovieEntity _processShapeItems(MovieEntity movieItem) {
    for (var sprite in movieItem.sprites) {
      List<ShapeEntity>? lastShape;
      for (var frame in sprite.frames) {
        if (frame.shapes.isNotEmpty && frame.shapes.isNotEmpty) {
          if (frame.shapes[0].type == ShapeEntity_ShapeType.keep &&
              lastShape != null) {
            frame.shapes = lastShape;
          } else if (frame.shapes.isNotEmpty == true) {
            lastShape = frame.shapes;
          }
        }
      }
    }
    return movieItem;
  }

  Future<MovieEntity> _prepareResources(MovieEntity movieItem,
      {TimelineTask? timeline}) {
    final images = movieItem.images;
    if (images.isEmpty) return Future.value(movieItem);
    return Future.wait(images.entries.map((item) async {
      // result null means a decoding error occurred
      final decodeImage = await _decodeImageItem(
          item.key, Uint8List.fromList(item.value),
          timeline: timeline);
      if (decodeImage != null) {
        movieItem.bitmapCache[item.key] = decodeImage;
      }
    })).then((_) => movieItem);
  }

  Future<ui.Image?> _decodeImageItem(String key, Uint8List bytes,
      {TimelineTask? timeline}) async {
    TimelineTask? task;
    if (!kReleaseMode) {
      task = TimelineTask(filterKey: _filterKey, parent: timeline)
        ..start('DecodeImage', arguments: {'key': key, 'length': bytes.length});
    }
    try {
      final image = await decodeImageFromList(bytes);
      if (task != null) {
        task.finish(
          arguments: {'imageSize': '${image.width}x${image.height}'},
        );
      }
      return image;
    } catch (e, stack) {
      if (task != null) {
        task.finish(arguments: {'error': '$e', 'stack': '$stack'});
      }
      assert(() {
        FlutterError.reportError(FlutterErrorDetails(
          exception: e,
          stack: stack,
          library: 'svgaplayer',
          context: ErrorDescription('during prepare resource'),
          informationCollector: () sync* {
            yield ErrorSummary('Decoding image failed.');
          },
        ));
        return true;
      }());
      return null;
    }
  }
}
