import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:file_picker/file_picker.dart' as web_picker;
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';
//import 'dart:io' show Directory, Platform;
import 'package:gc_wizard/widgets/utils/platform_file.dart';

import 'package:permission_handler/permission_handler.dart';

/// Open FileSystemPicker dialog
///
/// Returns null if nothing was selected.
///
/// * [rootDirectory] specifies the root of the filesystem view.
/// * [rootName] specifies the name of the filesystem view root in breadcrumbs, by default "Storage".
/// * [title] specifies the text of the dialog title.
/// * [allowedExtensions] specifies a list of file extensions that will be displayed for selection, if empty - files with any extension are displayed. Example: `['.jpg', '.jpeg']`
Future<PlatformFile> openFileExplorer(BuildContext context, {
  Directory rootDirectory,
  String rootName,
  List<String> allowedExtensions,
  String title,}) async {

  try {
    if (!kIsWeb)
      return _openMobileFileExplorer(context, rootDirectory, rootName, allowedExtensions, title);
    else
      /// web version
      return _openWebFileExplorer(allowedExtensions);

  } catch (ex) {
    print(ex);
  }
  return null;
}

Future<PlatformFile> _openMobileFileExplorer(BuildContext context,
  Directory rootDirectory,
  String rootName,
  List<String> allowedExtensions,
  String title) async {

  if (rootDirectory == null) {
    var mainPath = await MainPath();
    if (mainPath != null)
      rootDirectory = Directory(mainPath);
    else
      return null;
  }

  if (title == null)
    title = i18n(context, 'common_exportfile_openfile');

  String path = await FilesystemPicker.open(
    title: title,
    context: context,
    rootDirectory: rootDirectory,
    rootName: rootName,
    fsType: FilesystemType.file,
    //folderIconColor: Colors.teal,
    allowedExtensions: allowedExtensions,
    fileTileSelectMode: FileTileSelectMode.wholeTile,
    requestPermission: !kIsWeb
        ? () async => await Permission.storage.request().isGranted
        : null,
  );
  if (path != null)
    return new PlatformFile(path: path, name: (path.split(Platform.pathSeparator).last), bytes: await readByteDataFromFile(path));
  else
    return null;
}

Future<PlatformFile> _openWebFileExplorer(List<String> allowedExtensions) async {

  try {
    if (allowedExtensions != null)
      for (var i=0; i<allowedExtensions.length; i++)
        allowedExtensions[i] = allowedExtensions[i].replaceFirst('.', '');

    var files = (await web_picker.FilePicker.platform.pickFiles(
      type: web_picker.FileType.custom,
      allowMultiple: false,
      allowedExtensions: allowedExtensions,
    ))?.files;

    files = _filterFiles(files, allowedExtensions);

    return files == null ? null : new PlatformFile(path: files.first.path, name: files.first.name, bytes: files.first.bytes);
  } on PlatformException catch (e) {
    print("Unsupported operation " + e.toString());
  }
  return null;
}

List<web_picker.PlatformFile> _filterFiles(List<web_picker.PlatformFile> files, List<String> allowedExtensions) {
  if (files == null || allowedExtensions == null)
    return null;

  return files.where((element) => allowedExtensions.contains(element.extension)).toList();
}


Future<String> selectFolder(BuildContext context, {
    Directory rootDirectory,
    String rootName,
    List<String> allowedExtensions,
    String title,}) async {

  if (!kIsWeb) {
    if (rootDirectory == null) {
      var mainPath = await MainPath();
      if (mainPath != null)
        rootDirectory = Directory(mainPath);
      else
        return null;
    }

    return FilesystemPicker.open(
      title: 'Save to folder',
      context: context,
      rootDirectory: rootDirectory,
      rootName: rootName,
      fsType: FilesystemType.folder,
      pickText: 'Save file to this folder',
      folderIconColor: Colors.teal,
      requestPermission: !kIsWeb
          ? () async =>
      await Permission.storage
          .request()
          .isGranted
          : null,
    );
  } else
    return web_picker.FilePicker.platform.getDirectoryPath();
}

