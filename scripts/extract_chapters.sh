#!/usr/bin/env bash
# Extract chapters from textbook PDFs into markdown files
# Uses macOS native PDFKit via JXA (JavaScript for Automation)
# Processes one chapter at a time to avoid memory issues

set -eo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Suppress PDFKit debug output
export CG_PDF_VERBOSE=0

# PDF paths
IS507_PDF="$REPO_DIR/IS507/Roger S. Pressman - Software Engineering_ A Practitioner's Approach, 7th Edition (2010, McGraw-Hill Higher Education) - libgen.li.pdf"
IS501_PDF="$REPO_DIR/IS501/Kenneth C. Laudon, Jane P. Laudon - Management Information Systems_ Managing the Digital Firm (2017, Pearson) - libgen.li.pdf"

# Output directories
IS507_DIR="$REPO_DIR/IS507/chapters"
IS501_DIR="$REPO_DIR/IS501/chapters"

mkdir -p "$IS507_DIR" "$IS501_DIR"

# ─── Extract a single chapter ─────────────────────────────────────────────────
# Args: pdf_path  start_page  end_page  chapter_num  chapter_title  textbook_name  output_file
extract_chapter() {
  local pdf_path="$1"
  local start_page="$2"
  local end_page="$3"
  local chapter_num="$4"
  local chapter_title="$5"
  local textbook_name="$6"
  local output_file="$7"

  echo "  📖 Extracting Chapter $chapter_num: $chapter_title (pages $start_page–$end_page)..."

  local raw_text
  raw_text=$(osascript -l JavaScript - "$pdf_path" "$start_page" "$end_page" 2>/dev/null <<'JXAEOF'
function run(argv) {
  ObjC.import("PDFKit");
  ObjC.import("Foundation");

  var pdfPath = argv[0];
  var startPage = parseInt(argv[1]);
  var endPage = parseInt(argv[2]);

  var url = $.NSURL.fileURLWithPath(pdfPath);
  var doc = $.PDFDocument.alloc.initWithURL(url);
  if (!doc) {
    return "ERROR: Could not load PDF at: " + pdfPath;
  }

  var totalPages = Number(doc.pageCount);
  var lines = [];

  // PDF pages are 0-indexed internally, but we use 1-indexed input
  for (var i = startPage; i <= endPage && i <= totalPages; i++) {
    var page = doc.pageAtIndex(i - 1);
    if (!page) continue;

    var text = "";
    try {
      text = page.string.js || "";
    } catch(e) {
      text = "[Could not extract text from this page]";
    }

    // Clean up excessive whitespace while preserving paragraph breaks
    // Replace 3+ newlines with 2 newlines (paragraph break)
    text = text.replace(/\n{3,}/g, "\n\n");
    // Trim trailing whitespace on each line
    text = text.replace(/[ \t]+$/gm, "");

    lines.push("--- Page " + i + " ---");
    lines.push("");
    lines.push(text);
    lines.push("");
  }

  return lines.join("\n");
}
JXAEOF
  )

  if [[ "$raw_text" == ERROR:* ]]; then
    echo "    ❌ $raw_text"
    return 1
  fi

  # Write the markdown file
  {
    echo "# Chapter $chapter_num: $chapter_title"
    echo ""
    echo "> **Source**: $textbook_name"
    echo "> **Pages**: $start_page–$end_page"
    echo ""
    echo "---"
    echo ""
    echo "$raw_text"
  } > "$output_file"

  local size
  size=$(wc -c < "$output_file" | tr -d ' ')
  echo "    ✅ Saved: $(basename "$output_file") ($size bytes)"
}

# ─── IS 507 (Pressman) Chapters ──────────────────────────────────────────────
echo ""
echo "═══════════════════════════════════════════════════════════════════════"
echo "  IS 507 — Pressman: Software Engineering (7th Ed.)"
echo "═══════════════════════════════════════════════════════════════════════"
echo ""

if [ ! -f "$IS507_PDF" ]; then
  echo "❌ IS507 PDF not found at: $IS507_PDF"
else
  extract_chapter "$IS507_PDF"  1   28  "1"  "Software Engineering"    "Pressman – Software Engineering (7th Ed.)" "$IS507_DIR/ch01_software_engineering.md"
  extract_chapter "$IS507_PDF"  30  64  "2"  "Process Models"          "Pressman – Software Engineering (7th Ed.)" "$IS507_DIR/ch02_process_models.md"
  extract_chapter "$IS507_PDF"  65  94  "3"  "Agile Development"       "Pressman – Software Engineering (7th Ed.)" "$IS507_DIR/ch03_agile_development.md"
  extract_chapter "$IS507_PDF"  119 147 "5"  "Requirements Fundamentals" "Pressman – Software Engineering (7th Ed.)" "$IS507_DIR/ch05_requirements_fundamentals.md"
  extract_chapter "$IS507_PDF"  148 184 "6"  "Requirements Analysis"   "Pressman – Software Engineering (7th Ed.)" "$IS507_DIR/ch06_requirements_analysis.md"
  extract_chapter "$IS507_PDF"  186 214 "7"  "Design Modelling"        "Pressman – Software Engineering (7th Ed.)" "$IS507_DIR/ch07_design_modelling.md"
  extract_chapter "$IS507_PDF"  215 240 "8"  "Design Principles"       "Pressman – Software Engineering (7th Ed.)" "$IS507_DIR/ch08_design_principles.md"
  extract_chapter "$IS507_PDF"  241 272 "9"  "Design Architectures"    "Pressman – Software Engineering (7th Ed.)" "$IS507_DIR/ch09_design_architectures.md"
  extract_chapter "$IS507_PDF"  705 740 "26" "Project Management"      "Pressman – Software Engineering (7th Ed.)" "$IS507_DIR/ch26_project_management.md"
  extract_chapter "$IS507_PDF"  741 762 "27" "Estimation"              "Pressman – Software Engineering (7th Ed.)" "$IS507_DIR/ch27_estimation.md"
  extract_chapter "$IS507_PDF"  763 788 "28" "Risk Management"         "Pressman – Software Engineering (7th Ed.)" "$IS507_DIR/ch28_risk_management.md"
fi

# ─── IS 501 (Laudon & Laudon) Chapters ───────────────────────────────────────
echo ""
echo "═══════════════════════════════════════════════════════════════════════"
echo "  IS 501 — Laudon & Laudon: Management Information Systems (15th Ed.)"
echo "═══════════════════════════════════════════════════════════════════════"
echo ""

if [ ! -f "$IS501_PDF" ]; then
  echo "❌ IS501 PDF not found at: $IS501_PDF"
else
  extract_chapter "$IS501_PDF"  30  68  "1"  "Information Systems in Global Business"  "Laudon & Laudon – Management Information Systems (15th Ed.)" "$IS501_DIR/ch01_is_global_business.md"
  extract_chapter "$IS501_PDF"  70  108 "2"  "E-Business"                              "Laudon & Laudon – Management Information Systems (15th Ed.)" "$IS501_DIR/ch02_e_business.md"
  extract_chapter "$IS501_PDF"  110 148 "3"  "Organizations and Strategy"               "Laudon & Laudon – Management Information Systems (15th Ed.)" "$IS501_DIR/ch03_organizations_strategy.md"
  extract_chapter "$IS501_PDF"  150 186 "4"  "Ethical and Social Issues"                "Laudon & Laudon – Management Information Systems (15th Ed.)" "$IS501_DIR/ch04_ethical_social_issues.md"
  extract_chapter "$IS501_PDF"  316 362 "8"  "Security"                                 "Laudon & Laudon – Management Information Systems (15th Ed.)" "$IS501_DIR/ch08_security.md"
  extract_chapter "$IS501_PDF"  364 398 "9"  "Enterprise Applications"                  "Laudon & Laudon – Management Information Systems (15th Ed.)" "$IS501_DIR/ch09_enterprise_applications.md"
  extract_chapter "$IS501_PDF"  400 440 "10" "E-Commerce"                               "Laudon & Laudon – Management Information Systems (15th Ed.)" "$IS501_DIR/ch10_e_commerce.md"
  extract_chapter "$IS501_PDF"  442 482 "11" "Knowledge Management"                     "Laudon & Laudon – Management Information Systems (15th Ed.)" "$IS501_DIR/ch11_knowledge_management.md"
  extract_chapter "$IS501_PDF"  484 522 "12" "Decision Making"                          "Laudon & Laudon – Management Information Systems (15th Ed.)" "$IS501_DIR/ch12_decision_making.md"
  extract_chapter "$IS501_PDF"  524 560 "13" "Building Systems"                         "Laudon & Laudon – Management Information Systems (15th Ed.)" "$IS501_DIR/ch13_building_systems.md"
  extract_chapter "$IS501_PDF"  562 600 "14" "Project Management"                       "Laudon & Laudon – Management Information Systems (15th Ed.)" "$IS501_DIR/ch14_project_management.md"
  extract_chapter "$IS501_PDF"  602 632 "15" "Global Systems"                           "Laudon & Laudon – Management Information Systems (15th Ed.)" "$IS501_DIR/ch15_global_systems.md"
fi

echo ""
echo "═══════════════════════════════════════════════════════════════════════"
echo "  ✅ Extraction complete!"
echo "═══════════════════════════════════════════════════════════════════════"
echo ""
echo "IS 507 chapters:"
ls -la "$IS507_DIR"/ 2>/dev/null || echo "  (none)"
echo ""
echo "IS 501 chapters:"
ls -la "$IS501_DIR"/ 2>/dev/null || echo "  (none)"
