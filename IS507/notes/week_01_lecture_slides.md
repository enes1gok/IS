# Introduction to Software Engineering

> **Course:** IS 507 — Introduction to Software Engineering (METU Informatics Institute)  
> **Lecturer:** Assoc. Prof. Dr. Özden Özcan Top  
> **Source:** Week 1 In-Class Lecture Slides (Chapter 1: Introduction)  
> **Companion Study Guide:** [`week_01_introduction_to_software_engineering.md`](file:///Users/enesgok/Github/IS/IS507/notes/week_01_introduction_to_software_engineering.md)

---

## Table of Contents
1. [FAQs about Software Engineering](#faqs-about-software-engineering)
2. [What is a Software Product?](#what-is-a-software-product)
   - [Definition of a Computer Program](#definition-of-a-computer-program)
   - [Software is Everywhere](#software-is-everywhere)
3. [Characteristics of Software](#characteristics-of-software)
   - [Software is Intangible](#1-software-is-intangible)
   - [Software is Complex](#2-software-is-complex)
   - [Software must Conform to Standards](#3-software-must-conform-to-standards)
   - [Software is Changeable](#4-software-is-changeable)
   - [Software Deteriorates (Hardware vs. Software Failure Curves)](#5-software-deteriorates)
4. [Software: Then vs. Now](#software-then-vs-now)
5. [Types of Software](#types-of-software)
6. [Engineering and Software Engineering](#engineering-and-software-engineering)
   - [What is Engineering?](#what-is-engineering)
   - [Principles of Any Engineering Activity](#principles-of-any-engineering-activity)
   - [Definition of Software Engineering](#definition-of-software-engineering)
   - [Software Engineering vs. Computer Science](#software-engineering-vs-computer-science)
   - [Software Engineering vs. System Engineering](#software-engineering-vs-system-engineering)
7. [Issues in the Development of Software](#issues-in-the-development-of-software)
8. [End-to-End Walkthrough: Fitness Tracking Application](#end-to-end-walkthrough-fitness-tracking-application)
   - [Requirements Phase: Inputs](#1-requirements-phase-inputs)
   - [Requirements Phase: Outputs](#2-requirements-phase-outputs)
   - [Software Design and Architecture](#3-software-design-and-architecture)
   - [Implementation and Testing](#4-implementation-and-testing)
   - [Maintenance Phase](#5-maintenance-phase)
9. [Historical Context and Failures](#historical-context-and-failures)
   - [Origins of Software Engineering](#origins-of-software-engineering)
   - [Why Software Projects Still Fail](#why-software-projects-still-fail)
   - [Historical Disasters Caused by Bugs](#historical-disasters-caused-by-bugs)
   - [More Recent Failures](#more-recent-failures)
10. [Software Engineering Ethics](#software-engineering-ethics)
    - [Professional Responsibilities](#professional-responsibilities)
    - [ACM/IEEE Code of Ethics: The 8 Principles](#acmieee-code-of-ethics-the-8-principles)

---

## FAQs about Software Engineering

Key questions addressed in this introduction:
* **What is a software product?**
* **What is software engineering?**
* **What is the difference between software engineering and computer science?**
* **What is the difference between software engineering and system engineering?**

---

## What is a Software Product?

A **Software Product** is not just executable code; it encompasses the complete ecosystem necessary for its operation and lifecycle:

```
                      ┌── Computer programs
                      │
                      ├── Configuration files used to set up these programs
SOFTWARE PRODUCT ─────┤
                      ├── User documentation explaining how to use the software
                      │
                      └── System documentation describing the structure of the software
```

### Definition of a Computer Program
> **Computer Program:** A list of instructions, written in a specific programming language (Java, C, Fortran, etc.), which a computer follows in processing data, performing an operation, or solving a logical problem.  
> *(Source: `faculty.valencia.cc.fl.us/jdelisle/lis2004/glossary.htm`)*

### Software is Everywhere
Software permeates modern society and infrastructure:
* **In computer systems:**
  * Operating systems (e.g., Windows, Linux)
  * End-user programs (e.g., Photoshop, Dreamweaver)
  * Compilers (e.g., `javac`, Pascal, `gcc`)
* **Aircraft & Space Shuttles:** (e.g., F-16 flight controls, Discovery Space Shuttle)
* **Mobile Phones**
* **Education:** (e.g., Distance Learning platforms)
* **Manufacturing:** Embedded in almost all industrial manufacturing processes
* **Health Systems:** Biomedical instrumentation, electronic patient records, patient monitoring
* **Nuclear Reactors:** Critical protection and control systems

---

## Characteristics of Software

### 1. Software is Intangible
* **Nature:** The computer program component cannot be physically touched or seen, but its existence is known and its functionality can be experienced.
  * *Example:* You cannot physically touch an operating system running on your computer, but you interact with it constantly.
* **Challenge:** It is difficult to fully grasp and communicate its scale, progress, and requirements.

### 2. Software is Complex
* **Nature:** Software can be extremely complex due to the sheer number of interacting components and dependencies.
  * *Example:* A modern web browser simultaneously coordinates rendering engines, networking protocols, tab state management, process sandboxing, extensions, and security sandboxes.
* **Challenges:**
  * Makes debugging and long-term maintenance difficult.
  * Difficult to understand subtle interrelationships between subsystems.

### 3. Software must Conform to Standards
* **Nature:** Software must strictly comply with customer/user requirements, industry standards, and legal/governmental regulations.
  * *Example:* Banking software, financial gateways, and medical software must conform to rigorous statutory regulations (e.g., HIPAA, PCI-DSS, Basel accords).
* **Challenges:**
  * Ensuring and verifying that development processes conform to all standards is difficult.
  * Conformance activities are resource-intensive and time-consuming.

### 4. Software is Changeable
* **Nature:** Software is continually subject to changes both during and after development due to:
  * Evolving customer and business requirements
  * Bug fixes
  * Performance optimizations and platform updates
* **Challenges:**
  * Frequent modifications can introduce regressions and new bugs.
  * Managing continuous change across teams is difficult.
  * Maintaining adherence to predefined project schedules and budgets becomes challenging.

### 5. Software Deteriorates

> **Key Rule:** Software does not wear out physically, but it **deteriorates** due to continuous modifications. Most software models a slice of reality; as the real-world domain evolves, if the software does not adapt cleanly, its architecture degrades and defects multiply.

#### Hardware Failure Rate vs. Software Failure Rate

* **Hardware ("Bathtub Curve"):**
  * **Early stage:** High failure rate due to *design or manufacturing defects* (burn-in period).
  * **Mid stage:** Low, stable failure rate during useful life.
  * **Late stage (Wear-out):** Failure rate sharply increases due to physical wear and tear (*cumulative effects of dust, vibration, environmental maladies*).

```
Hardware Failure Curve (Bathtub Curve)
Failure Rate
    ^
    | \                                      /
    |  \                                    /
    |   \  (Design/Manufacturing           /  (Dust, vibration,
    |    \  defects)                      /    wear-out)
    |     \______________________________/
    +----------------------------------------> Time
```

* **Software ("Deterioration Curve"):**
  * **Idealized curve:** High defect rate initially, which steadily declines asymptotically toward zero as bugs are found and fixed, remaining low indefinitely (software has no physical wear-out).
  * **Actual curve:** Every time a **change** is introduced, a sudden spike in failure rate occurs. Although fixes follow, the base failure rate continuously shifts upward over time due to structural erosion, side effects, and compounding complexity.

```
Software Failure Curves
Failure Rate
    ^
    | \                                                /|
    |  \                                              / |
    |   \                                   |        /  |
    |    \                        |        /|       /   |         Actual Curve
    |     \                      /|       / |      /    \       (Failure rate increases
    |      \                 |  / |      /  \  /\ /      \       gradually with changes)
    |       \               /| /  \  /\ /    \/  •        \
    |        \          |  / |/    \/  •                   \
    |         \        /| /   •                             \
    |          \      / |/                           _..---'' <--- Rising Baseline
    |           \    /   •                     _..---''            (Software Deterioration)
    |            \  /                    _..---''
    |             \_____________________/-----------------------> Idealized Curve
    +-----------------------------------------------------------> Time
                         ^         ^         ^
                       Change    Change    Change
```

---

## Software: Then vs. Now

| Dimension | Early Years (1960s – 1970s) | Modern Era (Today) |
| :--- | :--- | :--- |
| **System Scale** | Small, localized programs | Very large, distributed, interconnected systems |
| **Team Size** | 1 individual or a small, co-located group | Large engineering teams collaborating across years |
| **Work Environment** | Centralized, physical access to machine | Distributed, multi-time-zone, and hybrid environments |
| **Roles & Expertise** | Author, user, and domain expert were often the same person | High employee turnover; separation of product managers, domain experts, and engineers |
| **Domain & Technology** | Limited complexity, stable toolsets | Extreme domain complexity; fast-changing frameworks, tools, and platforms |
| **Constraints** | Primarily hardware/computational limits | Tight project budgets, strict delivery schedules, regulatory and legal compliances |
| **AI Integration** | Deterministic algorithms | Specialized machine learning models, Large Language Models (LLMs) |

---

## Types of Software

### 1. Generic Products (Commercial Off-The-Shelf - COTS)
* Stand-alone systems developed by an organization and sold openly on the commercial market.
* **Specification control:** The software specification and feature roadmap are defined and controlled by the **developer/vendor**.
* **Examples:** Microsoft Office, Adobe Photoshop, commercial operating systems.

### 2. Bespoke (or Customized) Products
* Systems commissioned specifically for an individual client and developed under contract.
* **Specification control:** The organization purchasing the software defines, owns, and controls the software **specifications and requirements**.
* **Examples:** Military Command & Control systems, bespoke internal core-banking systems, custom industrial automation tools.

---

## Engineering and Software Engineering

### What is Engineering?
* *"The creative application of scientific principles to design or develop structures, machines, apparatus, ..."*  
  — **Engineers' Council for Professional Development (ECPD – US)**
* *"An activity of building useful things to serve recognizable purposes"*  
  — **Michael A. Jackson** (*Software Requirements & Specifications*)
* Engineers make things "work" by systematically applying **theories + methods + tools** where appropriate.
* Engineers strive to discover and implement viable solutions within real-world **constraints**.
  * *What are these constraints?* Cost, schedule, resource limits, regulatory bounds, environmental factors, and technological boundaries.

### Principles of Any Engineering Activity
Any sound engineering project must balance four core dimensions:
* **Cost:** Delivered within the anticipated **budget**.
* **Time:** Delivered within the anticipated **schedule**.
* **Scope:** Delivered covering the anticipated **functional/non-functional requirements**.
* **Quality:** Delivered with strict **conformance** to customer requirements, robustness, and reliability.

> **Primary Focus of Software Engineering:** The cost-effective design, construction, and delivery of high-quality, dependable software systems.

### Definition of Software Engineering
> **Software Engineering** is an engineering discipline that is concerned with all aspects of software production from the early stages of system specification through to maintaining the system after it has gone into use.

* **Engineering Discipline:** Applying sound scientific/mathematical theories and systematic methods to solve practical problems while operating within organizational, schedule, and financial constraints.
* **All Aspects of Software Production:** Goes beyond just code writing (technical implementation). Encompasses project management, quality assurance, tooling, development methodologies, and ongoing system evolution.

---

### Software Engineering vs. Computer Science

* **Computer Science (CS):** Focuses on underlying **theories and fundamentals**.
* **Software Engineering (SE):** Focuses on the **practicalities of developing and delivering useful, reliable software**.

| Field | Core Focus Areas | Representative Examples |
| :--- | :--- | :--- |
| **Computer Science (CS)** | Data Structures & Algorithms | Search trees, graph traversal algorithms, computational complexity |
| | Operating Systems Concepts | Process management, virtual memory, concurrency primitives, scheduling algorithms |
| | Computer Architecture | Digital logic design, CPU pipelining, cache memory hierarchy |
| | Programming Language Theory | Type theory, formal semantics, compiler theory |
| **Software Engineering (SE)** | Design Patterns | Repeatable, proven architectural & design patterns (e.g., Singleton, Observer, Factory) |
| | Software Processes & Practices | Agile/Scrum, Waterfall, DevOps, continuous integration, code reviews, automated testing |

---

### Software Engineering vs. System Engineering

* **System Engineering:** Concerned with **all aspects** of the design, integration, and life cycle of total computer-based systems. It encompasses:
  * Hardware engineering
  * Software engineering
  * Process, human factors, and organizational engineering
* **Software Engineering:** A specialized, vital component of system engineering that focuses on building the **software infrastructure, control logic, application software, and databases** embedded in the broader system.

---

## Issues in the Development of Software

Large-scale software development faces distinct organizational and technical challenges:

1. **Teamwork & Scale:** A single developer cannot deliver complex systems within practical timelines; software is fundamentally a team sport.
2. **Communication Overhead:** Team members must continuously communicate, synchronize interfaces, and coordinate requirements.
3. **Specification Ambiguity:** Specifying enterprise software is drastically more complex than simple instructions like *"write a program that sorts a set of integers."*
4. **Architectural Need:** Developers cannot simply jump into writing code; rigorous architectural and modular design must precede coding to prevent collapse.
5. **Integration Complexity:** Multiple programmers develop distinct components in parallel; integrating these subsystems so that they cooperate seamlessly requires continuous verification.
6. **Verification & Validation:** How do we prove mathematically and empirically that the built software fulfills all explicit and implicit expectations?
7. **Extensibility & Evolution:** How does the architecture accommodate new feature requests without introducing regressions or breaking legacy functionality?

---

## End-to-End Walkthrough: Fitness Tracking Application

To illustrate how software engineering processes operate across the life cycle, consider the project:  
**"Develop a fitness tracking application"**

### 1. Requirements Phase: Inputs
Before writing code, input expectations must be defined unambiguously:
* **Collected Data:** What does the application gather? (Steps, heart rate, GPS coordinates, completed workouts, sleep metrics).
* **Data Sources:** Where does each data stream originate? (Smartphone accelerometer, external smartwatch, GPS chip, manual user input).
* **Sampling Frequency & Fault Handling:** How often are sensors sampled? What should happen when a sensor drops offline or power-saving throttles it?
* **Direct User Inputs:** Age, biological sex, current weight, target weight, fitness goals.
* **Edge Cases & Data Validation:** How does the system handle corrupted, delayed, or anatomically impossible readings (e.g., heart rate spiked at $300\text{ bpm}$)?
* **Storage Limits:** Are historical sensor logs retained indefinitely, downsampled over time, or purged after a specific retention window?

### 2. Requirements Phase: Outputs
The system must define how data is processed, synthesized, and surfaced:
* **Visualizations:** Daily summaries, activity breakdowns, trend lines, goal-progress rings.
* **Localization & Units:** Metric vs. imperial conversion ($1\text{ yard} = 0.9144\text{ m}$; kilometers vs. miles; kilocalories vs. kilojoules); can the user switch units dynamically?
* **Temporal Delivery:** Real-time metrics streaming during active workouts vs. post-workout batch summaries.
* **Interaction:** Push notifications, streak reminders, social sharing features, structured data exports (CSV/JSON/HealthKit).

> All of these specifications must be documented and agreed upon in the **Software Requirements Specification (SRS)** before implementation.

### 3. Software Design and Architecture
Once requirements are solidified, high-level decisions that are costly to change later must be resolved:
* **Target Platforms:** Native iOS (Swift), native Android (Kotlin), or cross-platform/web (Flutter/React Native)?
* **Data Persistence & Topology:** Does data reside strictly locally on-device (privacy-first), in the cloud, or locally with an asynchronous bidirectional synchronization engine?
* **Decomposition & Component Architecture:** How are components separated?
  * Sensor ingestion module
  * Local database / caching layer
  * Analytics and calorie burn engine
  * Presentation / UI layer
  * Notification dispatch engine

### 4. Implementation and Testing
Once architecture and component interfaces are fixed, programming begins, followed immediately by rigorous verification:
* **Correctness Checks:** Are distance, step count, and burned calorie formulas calculated accurately?
* **Edge-Case & Boundary Testing:**
  * Complete loss of GPS signal mid-run (tunnel/underground).
  * Prolonged endurance runs spanning multiple battery charges.
  * Crossing time zones and handling Daylight Saving Time changes.
* **Test Isolation:** Can submodules (e.g., the calorie calculation library) be isolated and tested independently via automated Unit Tests?
* **Definition of Done:** When is testing complete? What code coverage and defect-severity thresholds must be met to clear release?

### 5. Maintenance Phase
Delivering version 1.0 does not terminate the project.
* **Client & Market Evolution:** Client requests: *"It would be better if it also synced with the new smartwatch and added a sleep score."*
* **Continuous Adaptation:** The software is continually refactored and updated to accommodate:
  * Hardware iterations (new smartwatches, updated sensors)
  * Mobile operating system updates (iOS / Android API changes, permission model updates)
  * Changing regulatory landscapes (data privacy, GDPR, health data handling)

---

## Historical Context and Failures

### Origins of Software Engineering
* The term **"Software Engineering"** was coined at the **1968 NATO Science Committee Conference** in Garmisch, Germany.
* It was convened to address the **"Software Crisis"**: the pervasive inability of the computing industry to build large software systems reliably, predictably, within budget, and on schedule.
* Decades later, despite dramatic advancements in hardware and toolchains, software engineering challenges remain fundamentally relevant.

### Why Software Projects Still Fail
Modern software projects still encounter systemic failures because they frequently:
1. Do not provide the actual functionality desired by stakeholders.
2. Take substantially longer to build than planned.
3. Cost substantially more than initial financial estimates.
4. Require excessive computational resources (CPU cycles, memory footprint, bandwidth).
5. Are architected inflexibly, making evolution to meet changing needs prohibitively difficult.

---

### Historical Disasters Caused by Bugs

#### 1. NASA Mars Climate Orbiter (1999)
* **Outcome:** The \$125 million spacecraft was completely destroyed upon entering the Martian atmosphere.
* **Root Cause:** Failed unit conversion between imperial (English) and metric units between collaborating engineering teams:
  * Ground software generated thruster data in pound-force seconds ($\text{lbf}\cdot\text{s}$).
  * Trajectory calculation software expected metric newton-seconds ($\text{N}\cdot\text{s}$).
  * Conversion reference:
    $$1\text{ yard} = 0.9144\text{ m}$$
    $$1\text{ mile} = 1.609\text{ km}$$
* **Lesson:** Systematic verification, interface definition, and configuration alignment are critical.

#### 2. Therac-25 Radiation Therapy Machine (1985–1987)
* **Outcome:** Massive radiation overdoses directly caused the deaths of multiple patients.
* **Root Cause:** Software race condition bugs allowed the electron beam to trigger at high power without the required safety plate in place.
* **Lesson:** Caused by incomplete and incorrect requirement specifications, poor user manual design, lack of independent hardware interlocks, and over-reliance on unverified legacy code.

---

### More Recent Failures

| Incident | Domain | Failure Mechanism | Root Cause / Engineering Lesson |
| :--- | :--- | :--- | :--- |
| **Boeing 737 MAX**<br>*(2018–2019)* | Commercial Aviation | The Maneuvering Characteristics Augmentation System (MCAS) repeatedly forced the aircraft's nose down based on data from a single faulty Angle of Attack (AoA) sensor. Two crashes resulted; the fleet was grounded worldwide. | **Flawed Safety & Requirements Analysis:** Critical flight control software lacked redundant sensor cross-validation and fault-tolerant fallback modes. |
| **Knight Capital**<br>*(2012)* | Financial Trading | An automated high-frequency trading deployment left unlinked, repurposed legacy "dead code" active on a production server. The system generated erroneous buy/sell orders, losing \$440 million in 45 minutes. | **Inadequate Deployment & Configuration Management:** Flawed continuous delivery practices, lack of configuration tracking, and dead code retention. |
| **CrowdStrike Falcon**<br>*(2024)* | Enterprise Cybersecurity | A malformed configuration/channel update pushed to security sensor software triggered kernel-level exceptions (Blue Screen of Death) across $\sim 8.5\text{ million}$ Windows machines, halting international airlines, hospitals, and banking infrastructure. | **Inadequate Testing & Staged Release Management:** Ineffective automated test pipelines, failure of internal parser sanitization, and absence of gradual/canary rollouts. |

---

## Software Engineering Ethics

Software engineering is not purely an exercise in technical mastery; engineers hold profound leverage over societal safety, financial stability, and human well-being.

### Professional Responsibilities
Engineers must adhere to core professional standards:
* **Confidentiality:** Respecting and maintaining the privacy of employers, clients, and user data.
* **Competence:** Operating only within areas of actual expertise; acknowledging technical limits.
* **Intellectual Property (IP) Rights:** Respecting copyrights, patents, open-source licenses, and trade secrets.
* **Computer Misuse:** Refusing to leverage technical expertise to compromise, exploit, or disrupt computing infrastructure.

> **Ethical Principle:** Ethical behaviour is more than simply upholding the law; it requires proactively adhering to an uncompromising set of moral principles.

---

### ACM/IEEE Code of Ethics: The 8 Principles
Jointly developed by the **ACM (Association for Computing Machinery)** and the **IEEE Computer Society (IEEE-CS)**:

1. **PUBLIC:** Software engineers shall act consistently with the public interest.
2. **CLIENT AND EMPLOYER:** Software engineers shall act in a manner that is in the best interests of their client and employer, consistent with the public interest.
3. **PRODUCT:** Software engineers shall ensure that their products and related modifications meet the highest professional standards possible.
4. **JUDGMENT:** Software engineers shall maintain integrity and independence in their professional judgment.
5. **MANAGEMENT:** Software engineering managers and leaders shall subscribe to and promote an ethical approach to the management of software development and maintenance.
6. **PROFESSION:** Software engineers shall advance the integrity and reputation of the profession consistent with the public interest.
7. **COLLEAGUES:** Software engineers shall be fair to and supportive of their colleagues.
8. **SELF:** Software engineers shall participate in lifelong learning regarding the practice of their profession and shall promote an ethical approach to the practice of the profession.
