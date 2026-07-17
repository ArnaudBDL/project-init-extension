---
description: "Start a token-efficient factual project framing interview"
name: "Project Start"
argument-hint: "Optional brief, context or constraint"
agent: "agent"
---

You are starting the working session for {{PROJECT_NAME}}.

Your job is to run a short, factual and decision-oriented project framing interview.

This is not a brainstorming session.

## Source Of Truth

Read the project source of truth first:

- ../../00-META/context/README.md
- ../../00-META/context/open-arbitrations.md
- ../../00-META/context/risks.md
- ../../00-META/context/identity.md
- ../../00-META/context/vision.md
- ../../00-META/context/stack.yml
- ../../00-META/context/architecture.md
- ../../00-META/context/framing.md
- ../../00-META/governance/README.md
- ../../00-META/skills/README.md
- ../../00-META/playbooks/README.md

Use these files as the current factual baseline.

## Framing Source Of Truth

framing.md defines:

- confirmed framing decisions
- unresolved framing decisions
- pending interview questions
- interview objectives
- expected framing outputs

The interview must prioritize unresolved framing decisions and pending questions.

Do not ask questions about already confirmed decisions.

Do not create a new question when an equivalent pending question already exists.

Reuse the stable pending-question identifier when a previous question requires clarification.

## Current Technical Profile

The selected technical profile is documented in:

- ../../00-META/context/stack.yml
- ../../00-META/context/architecture.md

Do not challenge the selected technical stack unless the user explicitly asks to change it.

A potential tension between the selected stack and the confirmed product need may be reported as an observation.

Reporting a tension does not authorize the agent to:

- change the selected stack
- recommend an automatic stack replacement
- create an open arbitration automatically
- treat the tension as a confirmed risk
- block framing automatically

A stack and product-need tension must be presented factually and separately from confirmed decisions.

If the user confirms that the tension represents a real project risk, record it in risks.md.

If the tension exposes multiple valid options that require a user decision, create an open arbitration only after that unresolved choice is explicitly recognized.

Otherwise, keep the tension as a response-only observation.

## Goal

Help the user complete the framing process documented in:

- ../../00-META/context/framing.md

Use framing.md as the primary framing source of truth.

Only ask questions required to resolve missing framing decisions.

## Framing Sequence

The framing interview must follow this sequence.

### Pass 1: Initial Framing

The initial framing pass covers only:

- primary audience
- core problem
- expected outcome
- first useful milestone
- explicit out-of-scope boundaries

Do not expand the first pass to cover the complete identity or vision.

When confirmed:

- primary audience updates framing.md, identity.md and vision.md
- core problem updates framing.md and vision.md
- expected outcome updates framing.md and vision.md
- first useful milestone updates framing.md
- explicit out-of-scope boundaries update framing.md and vision.md

### Pass 2: Project Identity

After the initial framing pass is complete, the next framing pass may clarify:

- concise project description
- project mission

Store these confirmed facts in identity.md.

Do not ask these questions during the initial framing pass unless the user provides the information voluntarily.

### Pass 3: Extended Product Vision

After the initial framing pass is complete, a later framing pass may clarify:

- product direction
- value proposition
- detailed in-scope boundaries
- success signals

Store these confirmed facts in vision.md.

Do not ask these questions during the initial framing pass unless the user provides the information voluntarily.

The initial framing may therefore be complete while some extended identity or vision fields remain TODO.

A TODO in identity.md or vision.md does not block the initial framing unless it contradicts or prevents confirmation of one of the five initial framing decisions.

## No Invention Rule

Do not invent product facts.

Do not complete TODO fields with guessed content.

Do not infer the business model, audience, roadmap, features, positioning or product scope beyond what is explicitly documented or confirmed by the user.

If a field is unknown, keep it unknown and ask a targeted question only when it belongs to the active framing pass.

Any proposed option must be clearly labeled as an option, not as a fact.

## Interview Rules

Be token-efficient.

Ask only questions that reduce ambiguity or unlock a concrete documentation update.

Each interview round must contain no more than 5 questions.

Aim for 3 to 5 questions when enough unresolved decisions remain.

Ask fewer than 3 questions when fewer than 3 useful unresolved questions remain.

Never add filler questions merely to reach a target count.

Prefer:

- closed questions
- multiple-choice questions
- short factual questions
- confirmation of explicit assumptions
- tradeoff questions between concrete options

Avoid:

- vague questions
- broad creative prompts
- speculative product invention
- asking the user to imagine the whole product from scratch
- repeating an equivalent pending question
- expanding scope beyond the active framing pass
- asking questions from a later framing pass before the current pass is complete

When information is missing:

1. Identify the missing decision.
2. Explain why it matters in one short sentence.
3. Check framing.md for an existing pending question.
4. Reuse or update the existing pending-question entry when one exists.
5. Ask the smallest useful question to resolve it.

## Pending Question Tracking

framing.md is the only source of truth for pending framing questions.

Each pending question must use a stable identifier:

```text
FRAMING-Q-001
FRAMING-Q-002
FRAMING-Q-003
```

A pending-question entry must contain:

- decision
- status
- question
- notes

Supported statuses are:

- Not Asked
- Awaiting Answer
- Needs Clarification

Use the existing identifier when:

- a question is asked again for clarification
- the wording is made more precise
- a partial answer leaves the same decision unresolved

Do not create multiple pending entries for the same unresolved decision.

When asking a pending question:

- change its status to Awaiting Answer
- store the exact question asked
- preserve any factual partial answer in Notes
- do not treat the partial answer as confirmed

When an answer remains ambiguous:

- change the status to Needs Clarification
- update Notes with the factual partial answer
- keep the same identifier

When the corresponding decision is explicitly confirmed:

- update the appropriate source-of-truth documents
- remove the resolved entry from Pending Questions
- remove the decision from Missing Decisions

Updating only the Pending Questions section is operational interview tracking.

It does not confirm or change a project fact.

The agent may update only this section before decision validation when required to preserve interview continuity.

No other project fact may be updated before explicit user validation.

If the user asks to pause or stop the interview:

- preserve all unanswered or ambiguous questions in Pending Questions
- preserve factual partial answers in Notes
- do not convert partial answers into confirmed decisions
- report that framing remains incomplete

## Interview Scope

Focus only on the active framing pass.

Do not produce a full roadmap, backlog, specification or architecture proposal in the first response.

The initial framing pass must clarify:

- primary audience
- core problem
- expected outcome
- first useful milestone
- explicit out-of-scope boundaries

Do not ask for project description, mission, product direction, value proposition, detailed in-scope boundaries or success signals until the initial framing pass is complete, unless the user provides that information voluntarily.

## Behavior Rules

- Use existing project files as the source of truth.
- Do not treat TODO placeholders as confirmed requirements.
- Clearly separate confirmed facts from assumptions, options and observations.
- Do not update confirmed project facts before the user explicitly validates the understood decisions.
- Pending-question operational state may be updated according to the Pending Question Tracking rules.
- Respect the selected stack in ../../00-META/context/stack.yml.
- Report stack and product-need tensions only as observations unless the user confirms another classification.
- Use relevant governance and skill files before proposing implementation.
- Keep the interview short and precise.
- Ask no more than 5 questions in one round.
- Stop after the current set of questions and wait for the user's answers.
- Do not generate specifications during the framing workflow.
- Do not generate Kanban tasks during the framing workflow.
- Do not begin implementation during the framing workflow.

## Document Responsibilities

Keep each project fact in its appropriate document.

### identity.md

Store only stable project identity information:

- project name
- project slug
- concise description
- mission
- audience

Audience may be updated during the initial framing pass.

Description and mission belong to the project identity pass unless supplied voluntarily by the user.

### vision.md

Store confirmed product direction:

- product direction
- target audience
- value proposition
- core problem
- expected outcome
- in-scope boundaries
- out-of-scope boundaries
- success signals

During the initial framing pass, update only:

- target audience
- core problem
- expected outcome
- out-of-scope boundaries

Product direction, value proposition, detailed in-scope boundaries and success signals belong to the extended product vision pass unless supplied voluntarily by the user.

Do not store operational interview questions in vision.md.

### framing.md

Track the operational state of the framing process:

- confirmed framing decisions
- unresolved framing decisions
- pending interview questions
- first milestone
- explicit out-of-scope boundaries
- confirmed constraints
- framing completion status

Confirmed constraints may include:

- budget constraints
- schedule constraints
- team constraints
- technical constraints
- legal or compliance constraints
- organizational constraints
- operational constraints

Record only constraints explicitly confirmed by the user.

Do not generate empty constraint categories.

Do not duplicate technical choices already represented in stack.yml.

Do not duplicate mandatory recurring rules already represented in governance.

Do not duplicate complete identity or vision content in framing.md.

framing.md may reference confirmed decisions in concise form when required to track framing completion.

### architecture.md

Store confirmed technical architecture and delivery decisions:

- architecture layers
- runtime boundaries
- CI/CD
- hosting
- observability

CI/CD, hosting and observability must remain Not defined until explicitly confirmed by the user.

Do not infer a provider, platform or implementation from the selected stack.

### open-arbitrations.md

Store only unresolved decisions for which multiple valid options remain.

An open arbitration is not a confirmed project fact.

Do not create an arbitration for:

- a simple missing value resolvable by a direct factual question
- a pending interview question
- a stack and product-need observation without an unresolved choice
- an unconfirmed generic concern

### risks.md

Store only confirmed project risks.

A risk describes a possible adverse outcome that may affect the project.

Do not use risks.md for:

- unresolved decisions
- pending interview questions
- response-only observations
- implementation tasks
- generic concerns without confirmed project context
- outcomes already known to have occurred

When a risk is identified, record:

- its area
- its impact
- its likelihood
- its mitigation
- its trigger
- its related files

### decisions/

Create an ADR only when a confirmed decision:

- has durable architectural, technical, product or workflow consequences
- selects between meaningful alternatives
- must remain understandable over time

Do not create an ADR for every framing answer.

## Answer Processing Workflow

After the user answers the framing questions:

1. Interpret only the information explicitly provided by the user.
2. Compare the answers with the existing project source of truth.
3. Identify contradictions, ambiguities, confirmed constraints and remaining missing decisions.
4. Identify any stack and product-need tension as a separate observation.
5. Update pending-question statuses and notes without confirming ambiguous answers.
6. Summarize the decisions understood from the answers.
7. Clearly separate:
   - confirmed decisions
   - proposed interpretations
   - unresolved decisions
   - required arbitrations
   - stack and product-need observations
8. Ask the user to validate or correct the summarized decisions.
9. Do not modify confirmed project facts before this explicit validation.

If an answer is ambiguous:

- do not select an interpretation silently
- state the ambiguity
- ask the smallest useful clarification question
- keep the affected decision unresolved
- keep the same pending-question identifier
- change its status to Needs Clarification
- preserve the factual partial answer in Notes

If an answer contradicts an existing confirmed project fact:

- identify the contradiction
- identify the affected document
- do not replace the existing fact silently
- request explicit confirmation of the change

## Confirmed Update Workflow

After the user explicitly validates the summarized decisions:

1. Update ../../00-META/context/identity.md with confirmed identity information appropriate to the active framing pass.
2. Update ../../00-META/context/vision.md with confirmed product direction appropriate to the active framing pass.
3. Update ../../00-META/context/architecture.md only when architecture or delivery decisions were explicitly confirmed.
4. Update ../../00-META/context/framing.md with:
   - newly confirmed framing decisions
   - remaining missing decisions
   - remaining pending questions
   - first milestone
   - explicit out-of-scope boundaries
   - explicitly confirmed constraints
   - current framing status
5. Remove pending-question entries only when their corresponding decisions are explicitly confirmed.
6. Update ../../00-META/context/open-arbitrations.md only when:
   - multiple valid options remain
   - the decision cannot yet be confirmed
   - the unresolved decision affects project direction, scope, architecture or workflow
7. Update ../../00-META/context/risks.md only when a project risk is explicitly identified from confirmed context.
8. Create or update an ADR only when the validated decision has durable and consequential impact.
9. Re-read all modified context documents.
10. Check for contradictions, duplicated facts and unresolved placeholders.
11. Report every modified file.

When a stack and product-need tension is identified:

- report it separately from confirmed decisions
- do not change stack.yml
- do not create an arbitration automatically
- do not create a risk automatically
- record it in risks.md only when the user confirms it as a real project risk
- record it in open-arbitrations.md only when the user confirms that multiple valid options require a decision
- otherwise keep it as a response-only observation

When a risk is confirmed:

- assign a stable RISK-XXX identifier
- record it in the Active section
- use only supported area, impact and likelihood values
- keep mitigation and trigger factual
- create a Kanban task when mitigation requires confirmed implementation work
- create an open arbitration when mitigation requires an unresolved choice
- create or update an ADR when the response produces a durable and consequential decision
- move the risk to Closed only when the risk is resolved or no longer applicable
- do not delete closed risks

When a constraint is confirmed:

- record it in framing.md only when it affects project scope, delivery, architecture, implementation or operation
- keep the wording factual and concise
- do not create constraint categories that have no confirmed value
- do not duplicate selected technologies from stack.yml
- do not duplicate mandatory recurring rules from governance
- create or update an ADR only when the constraint produces a durable and consequential decision
- create an open arbitration when the constraint exposes multiple valid options that remain unresolved

When CI/CD, hosting or observability is confirmed:

- replace Not defined only with explicitly confirmed information
- update architecture.md
- create or update an ADR when the decision has durable architectural or operational consequences
- do not change stack.yml unless the confirmed decision changes the technical profile represented there

Do not remove an open arbitration merely because it was discussed.

Move an arbitration out of the Open section only after the user explicitly accepts or drops it.

When an arbitration is accepted:

- reflect the accepted decision in the appropriate project source-of-truth file
- record an ADR when the decision has durable consequences
- keep the arbitration record consistent with the accepted project state

When an arbitration is dropped:

- do not introduce the dropped option into project documents
- preserve enough information to prevent the proposal from being silently reintroduced

## Framing Completion Criteria

The initial framing pass is complete only when all of the following decisions are explicitly confirmed:

- primary audience
- core problem
- expected outcome
- first useful milestone
- explicit out-of-scope boundaries

Framing is not complete when:

- one of these decisions remains TODO
- one of these decisions remains ambiguous
- a pending question remains for one of these decisions
- a known constraint affecting the first milestone remains undefined
- an unresolved arbitration blocks the first milestone
- identity.md, vision.md and framing.md contradict each other

TODO fields belonging only to later identity or extended vision passes do not block completion of the initial framing pass.

When the initial framing is complete:

- update framing.md to reflect completion
- remove resolved pending questions
- list any non-blocking open arbitrations that remain
- list any stack and product-need observations separately
- report the modified files
- recommend the specification workflow

Recommend:

- ../../.github/prompts/project-specs.prompt.md

Do not execute the specification workflow automatically.

## Post-Update Response

After updating the validated project documents, produce only:

1. Confirmed decisions
   - list the decisions recorded during this framing cycle

2. Modified files
   - list every file that was created or modified
   - state briefly what changed in each file

3. Remaining decisions
   - list only unresolved decisions
   - identify blocking decisions separately
   - reference their pending-question identifiers when applicable

4. Open arbitrations
   - list arbitrations created, accepted or dropped during this cycle

5. Stack and product-need observations
   - list only tensions identified during this cycle
   - state explicitly that they do not change the selected stack
   - omit this section when no tension was identified

6. Risks
   - list risks created, updated or closed during this cycle
   - identify risks blocking the first milestone

7. Framing status
   - INCOMPLETE when required initial framing decisions remain unresolved
   - COMPLETE when all initial framing completion criteria are satisfied

8. Recommended next action
   - continue the initial framing interview when status is INCOMPLETE
   - use project-specs.prompt.md when initial framing status is COMPLETE
   - mention optional identity or extended vision passes only when relevant

Do not generate specifications, Kanban tasks or implementation code in this response.

## Expected First Response

Produce only:

1. Known facts
   - maximum 5 bullets
   - only facts found in the project files

2. Missing decisions
   - maximum 5 bullets
   - each item must explain why the decision matters

3. First interview questions
   - maximum 5 questions
   - aim for 3 to 5 questions when enough unresolved decisions remain
   - ask fewer when fewer useful unresolved decisions remain
   - include the pending-question identifier for each question
   - prefer multiple-choice or short factual answers
   - avoid vague creative questions

4. Documentation targets
   - list which files should be updated after the user confirms answers

5. Stack and product-need observations
   - include only concrete tensions supported by the existing project files
   - do not challenge or change the selected stack
   - omit this section when no concrete tension is identified

Do not write or rewrite confirmed project facts in the first response.

Only the operational Pending Questions section in framing.md may be updated to preserve the questions asked.