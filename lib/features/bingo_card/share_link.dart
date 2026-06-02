import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:custom_bingo/features/bingo_card/bingo_item.dart';
import 'package:uuid/uuid.dart';

const String shareLinkWebScheme = 'https';
const String shareLinkWebHost = 'bingogrid.web.app';
const String shareLinkScheme = 'custombingo';
const String shareLinkHost = 'import';
const String _payloadParam = 'd';
const int _currentVersion = 1;

/// Encodes a bingo card into a shareable URI.
///
/// New links use the hosted `https://bingogrid.web.app/import?d=...` format so
/// chat apps treat them as clickable web URLs. Older `custombingo://import`
/// links remain supported by [decodeShareLink].
///
/// The payload is gzipped + base64url JSON. UUIDs and timestamps are stripped;
/// the receiver always gets fresh IDs. Marks (`fullfilledAt`) are included only
/// when [includeMarks] is true.
Uri encodeShareLink(BingoCardState state, {bool includeMarks = false}) {
  final cells = state.gridItems.expand((row) => row).toList(growable: false);
  final size = state.gridItems.length;

  final payload = <String, Object?>{
    'v': _currentVersion,
    'name': state.name,
    'size': size,
    'cells': cells.map((c) => c.text).toList(growable: false),
  };
  if (includeMarks) {
    payload['marks'] = cells.map((c) => c.isDone).toList(growable: false);
  }

  final json = jsonEncode(payload);
  final compressed = GZipEncoder().encode(utf8.encode(json));
  final encoded = base64Url.encode(compressed);
  return Uri(
    scheme: shareLinkWebScheme,
    host: shareLinkWebHost,
    path: '/$shareLinkHost',
    queryParameters: {_payloadParam: encoded},
  );
}

/// Outcome of attempting to decode a share URI.
sealed class DecodedShareLink {
  const DecodedShareLink();
}

class DecodedShareLinkOk extends DecodedShareLink {
  const DecodedShareLinkOk(this.state);
  final BingoCardState state;
}

class DecodedShareLinkUnsupported extends DecodedShareLink {
  /// The link is well-formed but uses a newer schema this app doesn't know.
  const DecodedShareLinkUnsupported();
}

class DecodedShareLinkInvalid extends DecodedShareLink {
  const DecodedShareLinkInvalid([this.reason]);

  final String? reason;
}

/// Decodes a share URI into a [BingoCardState] ready to save.
///
/// Returns [DecodedShareLinkOk] on success, [DecodedShareLinkUnsupported] if
/// the payload version is newer than this app understands, or
/// [DecodedShareLinkInvalid] for any other failure (malformed, wrong scheme,
/// truncated, etc.).
DecodedShareLink decodeShareLink(Uri uri) {
  if (!_isSupportedShareUri(uri)) {
    return const DecodedShareLinkInvalid('unsupported-uri');
  }
  final blob = uri.queryParameters[_payloadParam];
  if (blob == null || blob.isEmpty) {
    return const DecodedShareLinkInvalid('missing-payload');
  }
  try {
    final compressed = base64Url.decode(_padBase64(blob));
    final json = utf8.decode(GZipDecoder().decodeBytes(compressed));
    final map = jsonDecode(json) as Map<String, dynamic>;

    final version = map['v'];
    if (version is! int) {
      return const DecodedShareLinkInvalid('missing-version');
    }
    if (version > _currentVersion) {
      return const DecodedShareLinkUnsupported();
    }

    final name = map['name'];
    final size = map['size'];
    final cells = map['cells'];
    if (name is! String ||
        size is! int ||
        size <= 0 ||
        cells is! List ||
        cells.length != size * size) {
      return const DecodedShareLinkInvalid('invalid-card-shape');
    }

    final marks = map['marks'];
    final hasMarks = marks is List && marks.length == size * size;

    final uuid = const Uuid();
    final now = DateTime.now();
    final gridItems = <List<BingoItem>>[];
    var idx = 0;
    for (var row = 0; row < size; row++) {
      final rowItems = <BingoItem>[];
      for (var col = 0; col < size; col++) {
        final text = cells[idx];
        if (text is! String) {
          return const DecodedShareLinkInvalid('invalid-cell-text');
        }
        final isMarked = hasMarks && marks[idx] == true;
        rowItems.add(
          BingoItem(
            id: uuid.v4(),
            text: text,
            fullfilledAt: isMarked ? now : null,
          ),
        );
        idx++;
      }
      gridItems.add(rowItems);
    }

    return DecodedShareLinkOk(
      BingoCardState(
        name: name,
        gridItems: gridItems,
        lastChangeDateTime: now,
        isEditing: false,
      ),
    );
  } catch (error) {
    return DecodedShareLinkInvalid('decode-error:${error.runtimeType}');
  }
}

String describeShareUriForLog(Uri uri) {
  final queryKeys = uri.queryParameters.keys.toList()..sort();
  final payloadLength = uri.queryParameters[_payloadParam]?.length ?? 0;
  return [
    'scheme=${uri.scheme.isEmpty ? '<relative>' : uri.scheme}',
    'host=${uri.host.isEmpty ? '<none>' : uri.host}',
    'path=${uri.path.isEmpty ? '<empty>' : uri.path}',
    'queryKeys=${queryKeys.isEmpty ? '<none>' : queryKeys.join(',')}',
    'payloadChars=$payloadLength',
  ].join(' ');
}

String describeShareLinkOutcomeForLog(DecodedShareLink result) {
  return switch (result) {
    DecodedShareLinkOk() => 'ok',
    DecodedShareLinkUnsupported() => 'unsupported',
    DecodedShareLinkInvalid(:final reason) =>
      reason == null ? 'invalid' : 'invalid:$reason',
  };
}

bool _isSupportedShareUri(Uri uri) {
  final isCustomScheme =
      uri.scheme == shareLinkScheme && uri.host == shareLinkHost;
  if (isCustomScheme) return true;

  final isAppRouteShare =
      !uri.hasScheme &&
      !uri.hasAuthority &&
      uri.pathSegments.isNotEmpty &&
      uri.pathSegments.last == shareLinkHost;
  if (isAppRouteShare) return true;

  final isWebShare =
      (uri.scheme == 'http' || uri.scheme == 'https') &&
      uri.pathSegments.isNotEmpty &&
      uri.pathSegments.last == shareLinkHost;
  return isWebShare;
}

/// Some senders strip base64url padding when embedding in URLs. Restore it
/// before decoding.
String _padBase64(String s) {
  final pad = (4 - s.length % 4) % 4;
  return pad == 0 ? s : s + ('=' * pad);
}
