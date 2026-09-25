#!/usr/bin/env bash
# Fast textbook search utility using macOS native PDFKit
# Usage:
#   ./scripts/search_textbook.sh <IS501|IS507|all> <query> [limit]

COURSE="${1:-all}"
QUERY="$2"
LIMIT="${3:-5}"

if [ -z "$QUERY" ]; then
  echo "Usage: $0 <IS501|IS507|all> \"<search query>\" [limit (default: 5)]"
  echo "Example: $0 IS507 \"COCOMO\""
  echo "Example: $0 IS501 \"Enterprise Applications\" 3"
  exit 1
fi

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

export CG_PDF_VERBOSE=0

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
      var start = Math.max(0, idx - 100);
      var end = Math.min(pageText.length, idx + query.length + 150);
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
