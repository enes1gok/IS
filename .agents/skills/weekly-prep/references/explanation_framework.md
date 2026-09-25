# Quality Standards for Weekly Briefings & Concept Explanations

When delivering a weekly briefing or summary (triggered by "prepare week X" or "summarize week X"), adhere strictly to the following 6-part pedagogical structure:

---

## 1. 🎯 Executive Context & The "Why It Matters" Angle
* State the module name, week number, and corresponding textbook chapter.
* Frame the central problem the week's concepts solve.
* Explain why this topic is foundational for graduate students and industry practitioners (e.g., CTOs, system architects, lead engineers).

---

## 2. 🧠 Deep Conceptual Breakdown (No Surface-Level Bullet Lists)
* Detail each theoretical concept, mechanism, and process flow.
* Contrast alternative approaches using clear markdown comparison tables (e.g., Waterfall vs Agile vs Spiral; TPS vs MIS vs DSS).
* Define essential vocabulary and technical terms with precision.

---

## 3. 🏢 High-Impact Real-World Case Studies & Applied Examples
* Provide **at least 2 concrete, realistic, or historical case studies**:
  * **Success Case:** How a leading organization (e.g. Netflix, Amazon, Toyota, Spotify) leveraged these principles effectively.
  * **Failure / Cautionary Case:** What happens when these principles are ignored (e.g., Boeing 737 MAX MCAS software validation failure, Target supply-chain ERP collapse, Healthcare.gov launch failure, Knight Capital trading glitch).
* Clearly highlight the **engineering / architectural lesson** from each case study.

---

## 4. 📊 Visual Mental Models & Flowcharts (Mermaid)
* Include at least one informative `mermaid` diagram:
  * For process flows (e.g., Sprint cycle, Spiral quadrants, SDLC phases).
  * For data or architectural structures (e.g., 3-tier client/server, ERP integration, UML relationships).

---

## 5. ⚡ In-Class Quiz & Exam Readiness ("The High-Yield Survival Pack")
* **Quiz Alert:** Note whether an in-class quiz or assignment is scheduled this week according to the syllabus.
* **Key Formulas / Metrics:** (e.g. Function Points formula, COCOMO effort equations, reliability metrics if applicable).
* **3 High-Yield Exam / Quiz Practice Questions:**
  * Multiple choice or short conceptual prompt.
  * Model graduate-level answer explaining the reasoning and common misconceptions ("gotchas").

---

## 6. 📝 Automatic Note Persistence
* Automatically write the structured weekly summary to `<course>/notes/week_<0N>_<topic_slug>.md`.
* Provide a clickable file link to the saved notes in the conversation response.
