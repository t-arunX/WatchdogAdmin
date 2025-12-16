import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:google_fonts/google_fonts.dart';

class CodeElementBuilder extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    // Check if it's block code or inline
    final bool isMultiline = element.textContent.contains('\n');
    final String? className = element.attributes['class'];
    final bool hasLanguageClass = className != null && className.startsWith('language-');

    // Inline fallback: let markdown widget handle it usually, or return customized container
    // If it's just a short inline `code`, usually we return null to let the styleSheet handle it.
    if (!isMultiline && !hasLanguageClass) {
      return null;
    }

    var language = 'plaintext';
    if (hasLanguageClass) {
      language = className!.substring(9);
    }

    final codeContent = element.textContent.trimRight();

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFF282C34), // Atom One Dark bg
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           // Optional Header for language
           if (language != 'plaintext')
             Container(
               width: double.infinity,
               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
               decoration: const BoxDecoration(
                 color: Color(0xFF343541), // Slightly lighter header
                 borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
               ),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text(language, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                   const Row(
                     children: [
                       Icon(Icons.copy, size: 14, color: Colors.white70),
                       SizedBox(width: 4),
                       Text("Copy", style: TextStyle(color: Colors.white70, fontSize: 12))
                     ],
                   )
                 ],
               ),
             ),

           // The Code Highlight View
           SingleChildScrollView(
             scrollDirection: Axis.horizontal,
             child: HighlightView(
              codeContent,
              language: language,
              theme: atomOneDarkTheme,
              padding: const EdgeInsets.all(16),
              textStyle: GoogleFonts.firaCode(fontSize: 14),
            ),
           ),
        ],
      ),
    );
  }
}
