#!/usr/bin/env bash
# Fast textbook search utility using macOS native PDFKit
# Usage:
#   ./scripts/search_textbook.sh <IS501|IS507|all> <query> [limit]
#   ./scripts/search_textbook.sh <IS501|IS507> --pages <page|start-end>

COURSE="${1:-all}"

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

export CG_PDF_VERBOSE=0

# --pages mode: extract full page text
if [ "$2" = "--pages" ]; then
  PAGE_SPEC="$3"
  if [ -z "$PAGE_SPEC" ]; then
    echo "Usage: $0 <IS501|IS507> --pages <page|start-end>"
    echo "Example: $0 IS507 --pages 65-94"
    echo "Example: $0 IS501 --pages 42"
    exit 1
  fi

  osascript -l JavaScript - "$REPO_DIR" "$COURSE" "$PAGE_SPEC" 2>/dev/null << 'PAGES_EOF'
function run(argv) {
  ObjC.import("PDFKit");
  ObjC.import("Foundation");

  var repoDir = argv[0];
  var course = argv[1];
  var pageSpec = argv[2];
  var MAX_PAGES = 30;

  // Determine book path
  var bookPath, bookTitle;
  if (course.toUpperCase() === "IS501") {
    bookTitle = "Laudon & Laudon - Management Information Systems (15th Ed.)";
    bookPath = repoDir + "/IS501/Kenneth C. Laudon, Jane P. Laudon - Management Information Systems_ Managing the Digital Firm (2017, Pearson) - libgen.li.pdf";
  } else if (course.toUpperCase() === "IS507") {
    bookTitle = "Roger S. Pressman - Software Engineering: A Practitioner's Approach (7th Ed.)";
    bookPath = repoDir + "/IS507/Roger S. Pressman - Software Engineering_ A Practitioner's Approach, 7th Edition (2010, McGraw-Hill Higher Education) - libgen.li.pdf";
  } else {
    return "❌ --pages mode requires a specific course (IS501 or IS507), not 'all'.";
  }

  // Parse page spec
  var startPage, endPage;
  if (pageSpec.indexOf("-") !== -1) {
    var parts = pageSpec.split("-");
    startPage = parseInt(parts[0]);
    endPage = parseInt(parts[1]);
  } else {
    startPage = parseInt(pageSpec);
    endPage = startPage;
  }

  if (isNaN(startPage) || isNaN(endPage) || startPage < 1 || endPage < startPage) {
    return "❌ Invalid page specification: " + pageSpec;
  }

  var pageCount = endPage - startPage + 1;
  if (pageCount > MAX_PAGES) {
    return "❌ Requested " + pageCount + " pages, but maximum is " + MAX_PAGES + " per invocation. Narrow your range.";
  }

  var url = $.NSURL.fileURLWithPath(bookPath);
  var doc = $.PDFDocument.alloc.initWithURL(url);
  if (!doc) {
    return "❌ Could not load textbook PDF at: " + bookPath;
  }

  var totalPages = Number(doc.pageCount);
  var lines = [];
  lines.push("================================================================================");
  lines.push("📖 Extracting pages " + startPage + "-" + endPage + " from [" + course.toUpperCase() + "]: " + bookTitle);
  lines.push("   Total PDF pages: " + totalPages);
  lines.push("================================================================================");

  for (var p = startPage; p <= endPage; p++) {
    var pdfIndex = p - 1; // PDF pages are 0-indexed
    if (pdfIndex < 0 || pdfIndex >= totalPages) {
      lines.push("\n⚠️  Page " + p + " is out of range (PDF has " + totalPages + " pages). Skipping.");
      continue;
    }
    var page = doc.pageAtIndex(pdfIndex);
    var text = page.string.js || "";
    text = text.replace(/[\r\n\t]+/g, "\n").trim();

    lines.push("\n────────────────────────────────────────────────────────────────────────────────");
    lines.push("📄 PDF Page " + p);
    lines.push("────────────────────────────────────────────────────────────────────────────────");
    lines.push(text);
  }

  return lines.join("\n");
}
PAGES_EOF
  exit $?
fi

# Keyword search mode
QUERY="$2"
LIMIT="${3:-5}"

if [ -z "$QUERY" ]; then
  echo "Usage: $0 <IS501|IS507|all> \"<search query>\" [limit (default: 5)]"
  echo "  or:  $0 <IS501|IS507> --pages <page|start-end>"
  echo "Example: $0 IS507 \"COCOMO\""
  echo "Example: $0 IS501 \"Enterprise Applications\" 3"
  echo "Example: $0 IS507 --pages 65-94"
  exit 1
fi

osascript -l JavaScript - "$REPO_DIR" "$COURSE" "$QUERY" "$LIMIT" 2>/dev/null << 'EOF'
function run(argv) {
  ObjC.import("PDFKit");
  ObjC.import("Foundation");

  var repoDir = argv[0];
  var course = argv[1];
  var query = argv[2];
  var limit = parseInt(argv[3]) || 5;

  var books = [];
  if (course.toUpperCase() === "IS501" || course.toLowerCase() === "all") {
    books.push({
      course: "IS 501",
      title: "Laudon & Laudon - Management Information Systems (15th Ed.)",
      path: repoDir + "/IS501/Kenneth C. Laudon, Jane P. Laudon - Management Information Systems_ Managing the Digital Firm (2017, Pearson) - libgen.li.pdf"
    });
  }
  if (course.toUpperCase() === "IS507" || course.toLowerCase() === "all") {
    books.push({
      course: "IS 507",
      title: "Roger S. Pressman - Software Engineering: A Practitioner's Approach (7th Ed.)",
      path: repoDir + "/IS507/Roger S. Pressman - Software Engineering_ A Practitioner's Approach, 7th Edition (2010, McGraw-Hill Higher Education) - libgen.li.pdf"
    });
  }

  var lines = [];

  books.forEach(function(book) {
    lines.push("================================================================================");
    lines.push("🔍 Searching [" + book.course + "]: " + book.title);
    lines.push("   Query: \"" + query + "\"");
    lines.push("================================================================================");

    var url = $.NSURL.fileURLWithPath(book.path);
    var doc = $.PDFDocument.alloc.initWithURL(url);
    if (!doc) {
      lines.push("❌ Could not load textbook PDF at: " + book.path);
      return;
    }

    var selections = doc.findStringWithOptions(query, 1); // 1 = NSCaseInsensitiveSearch
    var total = Number(selections.count);
    lines.push("📊 Total occurrences found: " + total);

    var shown = Math.min(total, limit);
    for (var i = 0; i < shown; i++) {
      var sel = selections.objectAtIndex(i);
      var page = sel.pages.objectAtIndex(0);
      var pageNum = Number(doc.indexForPage(page)) + 1;
      var pageText = page.string.js || "";

      // Extract a relevant context excerpt around the match
      var idx = pageText.toLowerCase().indexOf(query.toLowerCase());
      var start = Math.max(0, idx - 500);
      var end = Math.min(pageText.length, idx + query.length + 500);
      var excerpt = pageText.substring(start, end).replace(/[\r\n\t]+/g, " ").trim();

      lines.push("\n▶ [Match #" + (i + 1) + " | PDF Page " + pageNum + "]:");
      lines.push("  \"..." + excerpt + "...\"");
    }

    if (total > limit) {
      lines.push("\n... and " + (total - limit) + " more matches. Increase the limit argument to see more.");
    }
    lines.push("");
  });

  return lines.join("\n");
}
EOF
