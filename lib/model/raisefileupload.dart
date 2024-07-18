class Fileupload {
  final String filename;
  final String base64;
  final String filetype;

  Fileupload({
    required this.filename,
    required this.base64,
    required this.filetype,
  });

  Map<String, dynamic> toJson() {
    return {
      "FileName": filename,
      "FileType": filetype,
      "Document": base64,
      "idTicket": 0,
      "idComplaintsTracker": 0,
      "SlNo": 1,
      "idTypeImageStaorage": 1,
      "FileLocation": "",
    };
  }
}
