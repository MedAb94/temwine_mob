import 'package:flutter/foundation.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:temwin_front_app/Core/extensions/string.extension.dart';

class ProcessTextImage {
  static final textRecognizer =
      TextRecognizer(script: TextRecognitionScript.latin);
  Future<bool> firstDetectingProcess(
    RecognizedText recognizedText,
  ) async {
    try {
      Iterable<Match> firstMatches =
          recognizedText.text.replaceAll(" ", "").matches(firstLineregex);
      return firstMatches.length == 1;
    } catch (error) {
      debugPrint("Isolate process:  has error $error");
      return false;
    }
  }

  bool mRzDetectingProcess2(String line, RegExp lineregex) {
    try {
      Iterable<Match> matches = line.replaceAll(" ", "").matches(lineregex);
      return matches.length == 1;
    } catch (error) {
      debugPrint("Isolate process:  has error $error");
      return false;
    }
  }

  Future<List<String>?>? photoTextProcess(
      InputImage message, bool isOffline) async {
    try {
      RecognizedText recognizedText =
          await textRecognizer.processImage(message);

      List<String?> processLines = [];

      final lines = recognizedText.blocks
          .expand<TextLine>((block) => block.lines)
          .toList();

      // for (TextBlock block in recognizedText.blocks) {
      //   // final Rect rect = block.boundingBox;
      //   // final List<Point<int>> cornerPoints = block.cornerPoints;
      //   // final String text = block.text;
      //   // final List<String> languages = block.recognizedLanguages;
      //   for (TextLine line in block.lines) {
      //     debugPrint("debugPrint line : [${line.text}]");
      //     for (TextElement element in line.elements) {
      //       debugPrint("debugPrint line :    ${element.text}");
      //     }
      //   }
      // }

      // int index = lines.indexWhere((line) => line.text.contains('ICCOL'));
      // debugPrint("lines count ${lines.length}");
      // lines.forEach((textLine) {
      //   debugPrint("\ntextLine = ${textLine.text}");
      // });
      int index = lines.indexWhere(
          (line) => line.text.replaceAll(" ", "").contains('I<MRT'));
      debugPrint("index value = $index");
      if (index >= 0) {
        // processLines = lines.sublist(index, lines.length - 1).map((e) {
        //   debugPrint("processLines count ${processLines.length}");
        //   return e.text;
        // }).toList();

        processLines = lines.sublist(0, lines.length - 1).map((e) {
          // debugPrint("processLines count ${processLines.length}");
          return e.text;
        }).toList();
      }

      if (processLines.length >= 3) {
        debugPrint("processLines count ${processLines.length}");
        return await processMrzText(processLines, isOffline);
      }

      return null;
    } catch (error) {
      debugPrint("Isolate result:  has error $error");
      return null;
    }
  }

  String? processMrzText2(
    List<String?> processLines,
  ) {
    try {
      if (processLines.length >= 3) {
        String? firstLine, secondLine, thirdLine;
        for (var line in processLines) {
          if (line != null &&
              mRzDetectingProcess(line, firstLineregex) == true) {
            firstLine = line.replaceAll(" ", "").trim();
            break;
          }

          // if (line != null &&
          //     mRzDetectingProcess(line, secondLineRegex) == true) {
          //   secondLine = line.replaceAll(" ", "").trim();
          // }

          // if (line != null &&
          //     firstLine != null &&
          //     secondLine != null &&
          //     line != firstLine &&
          //     line != secondLine &&
          //     mRzDetectingProcess(line, thirdLineRegex) == true) {
          //   thirdLine = line.replaceAll(" ", "").trim();
          // }

          // if (firstLine != null && secondLine != null && thirdLine != null) {
          //   break;
          // }

          // if (firstLine != null) {
          //   break;
          // }
        }

        // String firstLine =
        //     processLines.first?.replaceAll(' ', '').toUpperCase() ?? '';
        //debugPrint("firstLine $firstLine");
        // String secondLine =
        //     processLines[1]?.replaceAll(' ', '').toUpperCase() ?? '';
        // debugPrint("secondLine $secondLine");
        // String thirdLine =
        //     processLines[2]?.replaceAll(' ', '').toUpperCase() ?? '';
        // debugPrint("thirdLine $thirdLine");
        if (firstLine != null

            //&& secondLine != null

            //&& thirdLine != null

            ) {
          //first line
          // String typeDoc = firstLine.substring(0, 2);
          // String countryCode = firstLine.substring(2, 5);
          String nni = firstLine.substring(15, 25);

          // //second line
          // int indexGender = secondLine.indexOf(RegExp(r'[F]|[M]|[f]|[m]'));
          // String regex = "[$countryCode]";
          // int indexCol = secondLine.indexOf(RegExp(regex));
          // int indexNuip = secondLine.indexOf(RegExp(r'[<]'));

          // String expiryDate =
          //     secondLine.substring(indexGender + 1, indexCol - 1);
          // expiryDate = expiryDate.formatMrzDate(isExpired: true).toString();
          // String birthDate = secondLine.substring(0, indexGender - 1);
          // birthDate = birthDate.formatMrzDate().toString();
          // String gender = secondLine[indexGender];
          // String fiscalNumber =
          //     secondLine.substring(indexCol + 3, indexNuip).replaceAll(' ', '');

          // // third line

          // String nameUser =
          //     thirdLine.removeExtraAngleBrackets().replaceAll('<<', '');

          // String result =
          //     "expiryDate: $expiryDate \ngender:$gender  \nbirthDate: $birthDate \nfiscalNumber: $fiscalNumber \nnameUser: $nameUser \ntypeDoc: $typeDoc \ncountryCode: $countryCode";
          String result = nni;

          return result;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("Isolate process:  has error $e");
      return null;
    }
  }

  // String? processMrzTextOld(
  //   List<String?> processLines,
  // ) {
  //   try {
  //     if (processLines.length >= 3) {
  //       String firstLine =
  //           processLines.first?.replaceAll(' ', '').toUpperCase() ?? '';
  //       debugPrint("firstLine $firstLine");
  //       String secondLine =
  //           processLines[1]?.replaceAll(' ', '').toUpperCase() ?? '';
  //       debugPrint("secondLine $secondLine");
  //       String thirdLine =
  //           processLines[2]?.replaceAll(' ', '').toUpperCase() ?? '';
  //       debugPrint("thirdLine $thirdLine");

  //       //first line
  //       String typeDoc = firstLine.substring(0, 2);
  //       String countryCode = firstLine.substring(2, 5);

  //       //second line
  //       int indexGender = secondLine.indexOf(RegExp(r'[F]|[M]|[f]|[m]'));
  //       String regex = "[$countryCode]";
  //       int indexCol = secondLine.indexOf(RegExp(regex));
  //       int indexNuip = secondLine.indexOf(RegExp(r'[<]'));

  //       String expiryDate = secondLine.substring(indexGender + 1, indexCol - 1);
  //       expiryDate = expiryDate.formatMrzDate(isExpired: true).toString();
  //       String birthDate = secondLine.substring(0, indexGender - 1);
  //       birthDate = birthDate.formatMrzDate().toString();
  //       String gender = secondLine[indexGender];
  //       String fiscalNumber =
  //           secondLine.substring(indexCol + 3, indexNuip).replaceAll(' ', '');

  //       // third line

  //       String nameUser =
  //           thirdLine.removeExtraAngleBrackets().replaceAll('«', '');
  //       String result =
  //           "expiryDate: $expiryDate \ngender:$gender  \nbirthDate: $birthDate \nfiscalNumber: $fiscalNumber \nnameUser: $nameUser \ntypeDoc: $typeDoc \ncountryCode: $countryCode";
  //       return result;
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     debugPrint("Isolate process:  has error $e");
  //     return null;
  //   }
  // }

  void dispose() {
    textRecognizer.close();
  }

  /// Extracts MRZ data and returns the ID number, birth date, and full name.
  List<String>? processMrzText(List<String?> processLines, bool isOffline) {
    try {
      if (processLines.length < 3) {
        return null; // Insufficient lines
      }
      debugPrint("processMrzText: first step good");
      String? firstLine, secondLine, thirdLine;

      for (var line in processLines) {
        debugPrint("processMrzText: line = $line");
        if (line == null) continue;

        String cleanedLine = line.replaceAll(" ", "").trim();

        if (firstLine == null &&
            mRzDetectingProcess(cleanedLine, firstLineregex)) {
          firstLine = cleanedLine;
          debugPrint("processMrzText: firstLine = $firstLine");
          break;
        }
      }
      if (isOffline) {
        // for (var line in processLines) {
        //   debugPrint("processMrzText: line = $line");
        //   if (line == null) continue;

        //   String cleanedLine = line.replaceAll(" ", "").trim();

        //   if (secondLine == null &&
        //       mRzDetectingProcess(cleanedLine, secondLineRegex)) {
        //     secondLine = cleanedLine;
        //     debugPrint("processMrzText: secondLine = $secondLine");
        //     break;
        //   }
        // }

        for (var line in processLines) {
          debugPrint("processMrzText: line = $line");
          if (line == null) continue;

          String cleanedLine = line.replaceAll(" ", "").trim();

          if (firstLine == cleanedLine) continue;

          if (thirdLine == null &&
              firstLine != null &&
              // secondLine != null
              !mRzDetectingProcess(cleanedLine, secondLineRegex) &&
              mRzDetectingProcess(cleanedLine, thirdLineRegex)) {
            // if (firstLine == cleanedLine) {
            //   continue;
            // } else {
            thirdLine = cleanedLine;
            // }
            debugPrint("processMrzText: thirdLine = $thirdLine");
            break;
          }
        }

        if (firstLine != null &&
            // secondLine != null &&

            thirdLine != null) {
          String nni = extractNni(firstLine);
          //String birthDate = extractBirthDate(secondLine);
          String nameUser = extractName(thirdLine);
          debugPrint("processMrzText: nni: $nni,   nameUser: $nameUser");
          // return "nni: $nni, birthDate: $birthDate, nameUser: $nameUser";

          return [nni, nameUser];
        } else {
          return null; // Missing required lines
        }
      } else {
        if (firstLine != null) {
          String nni = extractNni(firstLine);

          debugPrint("processMrzText: nni: $nni,");
          // return "nni: $nni, birthDate: $birthDate, nameUser: $nameUser";

          return [nni];
        } else {
          return null; // Missing required lines
        }
      }
    } catch (e) {
      debugPrint("Error processing MRZ: $e");
      return null;
    }
  }

  /// Matches a line using the provided regex.
  bool mRzDetectingProcess(String line, RegExp lineregex) {
    try {
      return lineregex.hasMatch(line);
    } catch (e) {
      debugPrint("Error in regex detection: $e");
      return false;
    }
  }

  /// Extracts the NNI (ID number) from the first line.
  String extractNni(String firstLine) {
    return firstLine.substring(15, 25);
  }

  /// Extracts the birth date from the second line.
  String extractBirthDate(String secondLine) {
    int indexGender = secondLine.indexOf(RegExp(r'[F]|[M]|[f]|[m]'));
    return secondLine.substring(0, indexGender - 1);
  }

  /// Extracts the full name from the third line by removing angle brackets.
  String extractName(String thirdLine) {
    return thirdLine.replaceAll('<<', ' ').replaceAll('<', ' ').trim();
  }
}
