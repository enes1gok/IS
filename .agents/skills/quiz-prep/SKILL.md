---
name: quiz-prep
description: >-
  Use this skill whenever the user asks to "prepare the quiz", "quiz prep", "study for quiz X",
  "practice quiz", or requests an in-class quiz preparation or simulation session for IS 507
  (where in-class quizzes make up 25% of the total grade) or IS 501. Identifies the quiz scope,
  cross-references the syllabus and textbook (Pressman or Laudon & Laudon), produces a high-yield
  concept & formula cheatsheet, generates a realistic 5-7 question practice quiz with in-depth
  rationales and pitfalls, and saves the quiz guide into the quizzes/ directory.
---

# In-Class Quiz Preparation Skill (`quiz-prep`)

This skill prepares students for in-class quizzes in **IS 507** (Introduction to Software Engineering, where quizzes count for **25%** of the grade) and **IS 501** (Introduction to Information Systems) at METU Informatics Institute.

---

## 🚀 Execution Workflow

### Step 1: Identify Quiz Target & Scope
1. **Identify the Course:**
   - Detect whether the quiz is for **IS 507** or **IS 501**.
   - If ambiguous, default to **IS 507** (where quizzes are explicitly scheduled and heavily weighted at 25%), or clarify with the user.
2. **Identify Quiz Number or Topic:**
   - Consult [quiz_schedule.md](./references/quiz_schedule.md) to determine the targeted quiz:
     - **IS 507 Quiz 1 (Week 4):** Agile Development, XP & Scrum
     - **IS 507 Quiz 2 (Week 6):** Requirements Elicitation & Analysis (FAST, QFD, Use Cases)
     - **IS 507 Quiz 3 (Week 7):** Analysis & Design Modelling (DFD, UML Class/Object)
     - **IS 507 Quiz 4 (Week 8):** Advanced UML Modelling, Multiplicity, CRC Cards
     - **IS 507 Quiz 5 (Week 10):** Software Metrics, LOC, Function Points, COCOMO II, Scheduling
     - **IS 507 Quiz 6 (Week 13):** Generative AI and AI Agents in Software Engineering
     - **IS 501 Modules:** Module 1 (Ch 1-4), Module 2 (Ch 9-12), Module 3 (Ch 8, 13-15)

---

### Step 2: Extract Textbook Source Material
Run the repository textbook search utility to pull exact textbook definitions, diagrams, and terminology:
```bash
./scripts/search_textbook.sh <IS507|IS501> "<quiz_topic_keyword>" 3
```

---

### Step 3: Deliver the 4-Phase Quiz Prep Session
Follow the standards in [quiz_framework.md](./references/quiz_framework.md):

1. **Phase 1: High-Yield Cheatsheet ("10-Minute Cram"):**
   - Core definitions, acronyms, and notations.
   - Side-by-side comparison tables of easily confused terms (e.g. Aggregation vs Composition; FAST vs QFD).
   - Relevant calculation formulas (e.g., Function Points, COCOMO, CPM float).
   - "Gotchas" and tricky exam pitfalls.

2. **Phase 2: Practice Quiz Simulation (5–7 Questions):**
   - 3 Conceptual Multiple-Choice questions with challenging, realistic distractors.
   - 2 Scenario/Case-based short answer questions requiring trade-off evaluation.
   - 1 Diagram interpretation or calculation problem.

3. **Phase 3: Solutions & Graduate-Level Rationales:**
   - Correct answers clearly explained.
   - Explanations for why each wrong option was eliminated.
   - Grading rubric for scenario answers.

4. **Phase 4: Automatic Persistence:**
   - Save the complete preparation document to:
     - `IS507/quizzes/quiz_<0N>_<topic_slug>_prep.md`
     - or `IS501/quizzes/...`
   - Include a clickable markdown link in the response.
