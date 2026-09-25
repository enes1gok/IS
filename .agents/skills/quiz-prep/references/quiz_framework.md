# Quiz Preparation Framework & Simulation Standards

When executing the `quiz-prep` skill (triggered by "prepare the quiz", "quiz prep", "study for quiz X"), structure the output into 4 distinct phases:

---

## Phase 1: ⚡ High-Yield Formula & Concept Cheatsheet ("The 10-Minute Cram")
* **Key Terms & Definitions:** Ultra-clear, unambiguous definitions of 5–8 concepts most likely to be tested.
* **Direct Comparison Tables:** Side-by-side matrices contrasting easily conflated items (e.g. Aggregation vs Composition; Sprint Review vs Sprint Retrospective; Push vs Pull SCM; Functional vs Non-functional requirements).
* **Formulas & Calculation Rules:** If applicable (e.g., Function Point formula, COCOMO effort equation, slack time calculation), state the formula clearly with variable definitions and units.
* **Professor "Gotchas" & Common Traps:** 2–3 classic pitfalls and misleading concepts that catch students off guard on multiple-choice or short-answer questions.

---

## Phase 2: 📝 Realistic Practice Quiz Simulation (5–7 Questions)
Generate realistic questions formatted precisely like university graduate quizzes:
1. **Questions 1–3: Conceptual Multiple Choice**
   - 4 plausible choices (A, B, C, D) with realistic distractors (avoid obvious joke answers).
2. **Questions 4–5: Scenario-Based Application**
   - Realistic short case/scenario (e.g. "Company X has vague requirements and a tight deadline; evaluate whether they should adopt Waterfall or Spiral and defend your choice.").
3. **Question 6: Diagram / Notation / Calculation Drill**
   - E.g. finding the error in a UML class diagram, interpreting a DFD level, or computing Function Points / Effort given project parameters.

---

## Phase 3: 💡 Detailed Solution Key with Graduate-Level Rationale
* Provide the correct answer for every question.
* **Detailed Explanation:** Explain *why* the correct answer is right and *why each distractor is wrong*.
* **Scoring Rubric:** Provide the key points a grader expects to see in the short-answer/scenario questions.

---

## Phase 4: 💾 Save Practice Quiz to Course Workspace
* Save the full cheatsheet, practice quiz, and answer key to:
  - `IS507/quizzes/quiz_<0N>_<topic_slug>_prep.md` (or `IS501/quizzes/...`)
* Provide a clickable markdown link in the response.
