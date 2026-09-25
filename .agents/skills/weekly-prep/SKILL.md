---
name: weekly-prep
description: >-
  Use this skill whenever the user asks to "summarize week X", "prepare week X", "study week X",
  or requests a lecture briefing, study guide, or topic walkthrough for a specific week or topic
  in IS 501 (Introduction to Information Systems) or IS 507 (Introduction to Software Engineering).
  Finds the relevant syllabus requirements and textbook source material (Laudon & Laudon for IS 501,
  Pressman for IS 507), generates an in-depth, graduate-level briefing enriched with real-world case studies,
  visual mental models, and quiz/exam preparation, and automatically saves permanent study notes into
  the course's notes/ directory.
---

# Weekly Lecture Preparation & Briefing Skill (`weekly-prep`)

This skill standardizes the preparation and delivery of master-class-level weekly summaries and study guides for **IS 501** and **IS 507** at METU Informatics Institute.

---

## 🚀 Execution Workflow

### Step 1: Resolve Course and Week Number
1. **Identify the Course:**
   - If the user specifies `IS 501` or `IS 507`, select that course.
   - If the course is ambiguous (e.g. user just said "prepare week 1"), check recent conversation context. If still ambiguous, ask the user to clarify:
     - **IS 501:** Introduction to Information Systems (Prof. Dr. Pekin Erhan Eren)
     - **IS 507:** Introduction to Software Engineering
2. **Identify the Week Number:**
   - Parse the target week (e.g. `1`, `2`, ..., `14`).

---

### Step 2: Retrieve Course & Textbook Source Context
1. **Consult the Course Week Mapping:**
   Read [course_week_map.md](./references/course_week_map.md) to look up:
   - Topic name & syllabus module.
   - Assigned textbook chapter(s).
   - In-class quiz alerts or assignment deadlines for that week.
2. **Extract Key Passages from the Textbook:**
   Run the helper script from the workspace root:
   ```bash
   .agents/skills/weekly-prep/scripts/get_week_info.sh <IS501|IS507> <week_number>
   ```
   Or use the repository search utility for specific terms:
   ```bash
   ./scripts/search_textbook.sh <IS501|IS507> "<specific keyword>" 3
   ```

---

### Step 3: Generate the Master-Class Weekly Briefing
Follow the quality guidelines in [explanation_framework.md](./references/explanation_framework.md). The response must be comprehensive, graduate-level, and formatted in clear GitHub markdown:

1. **Executive Context & "Why It Matters":**
   - Framing of the topic within enterprise IT / software engineering practice.
   - Why senior architects, engineering managers, and researchers care about these concepts.
2. **Deep Conceptual Breakdown:**
   - Detailed walkthrough of each syllabus concept for that week (no superficial one-liners).
   - Markdown comparison tables for contrasting models (e.g., Waterfall vs Agile vs Spiral; TPS vs MIS vs DSS).
   - Key definitions, lifecycle phases, and core tradeoffs.
3. **High-Impact Real-World Case Studies & Applied Examples:**
   - **Success Example:** How an industry leader (Netflix, Amazon, Spotify, Toyota) implemented this successfully.
   - **Failure / Cautionary Tale:** Real-world incident when this was done poorly (e.g., Boeing 737 MAX MCAS, Healthcare.gov launch, Target Canada ERP failure, Knight Capital).
   - The concrete engineering/management lesson derived from each case.
4. **Visual Mental Model (Mermaid):**
   - At least one `mermaid` diagram (flowchart, sequence, or architecture) illustrating the week's core mechanism.
5. **In-Class Quiz & Exam Readiness:**
   - **Deliverables & Quiz Alert:** State if there is an in-class quiz (quizzes are 25% of grade in IS 507!) or homework due.
   - **3 High-Yield Exam / Quiz Practice Questions:** Multiple-choice or short conceptual questions with model graduate-level answers and common student pitfalls ("gotchas").

---

### Step 4: Automatically Save Notes
To ensure the student has permanent revision materials for midterm and final exams:
1. Save the generated guide as a Markdown file:
   - For IS 501: `IS501/notes/week_<0N>_<topic_slug>.md`
   - For IS 507: `IS507/notes/week_<0N>_<topic_slug>.md`
2. Provide a clickable link in your chat response pointing directly to the generated note file.
