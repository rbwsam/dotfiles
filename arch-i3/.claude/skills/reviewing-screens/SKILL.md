---
name: reviewing-screens
description: Use before showing anyone a screen design for review or approval — a mockup, a canvas board, a page of boards, a redesigned view in code — and before proposing a feature, filter, column or control for a screen. Reviews the design against established usability heuristics, the standard UI states, and the real data behind the screen, so the reviewer is not the one who finds missing paging, empty states, controls that fail at scale, or danger that looks like history. Use it even for a "small" change to a list, table, filter, pager, empty state or column.
---

# Reviewing screens

A screen is reviewed by playing it out — against what its user is trying to do,
the data at its limits, and the established heuristics — not by looking at it.
Run every pass before the design is shown. The review request says what each
pass found.

## 0. Ground it

Three inputs. The rest of the review is only as good as these.

1. **The job.** One line: who opens this screen, why, and what they do next.
2. **The data, from the code.** For every list and value the screen shows:
   - how many there can be — the least (zero) and the most, from the code's
     real limits (plan caps, uniqueness rules, retention), not a guess
   - how far back it exists, and what a link to something older finds
   - which fields do not apply to some kinds of item, and which values only
     one kind produces
   - which values derive from others (an end time from a start and a duration)
   - the longest value each text field accepts
3. **The house patterns.** The product's components, its approved screens and
   its decision log. A new screen reuses them for the same job, and copies the
   newest approved version, not an older one that predates a rule.

## 1. States

Every region that shows data has these states (Scott Hurff's "UI stack"). Draw
each one, per section, not per page:

- **Blank** — none ever; none right now; none after a filter.
- **Loading** — first load and each later fetch.
- **Partial** — one item; a few.
- **Ideal** — a typical page.
- **Too many** — more than one page; the maximum from step 0.
- **Error** — each request failing; each input the user can get wrong.
- **Changed underneath** — items gone or added while the user is on a later
  page.

A list shown without its paging and blank states is not ready for review.

## 2. Controls

For every control that fetches, filters, sorts or pages, write down before
drawing it:

1. the request it makes
2. how many rows can come back, at the maximum from step 0
3. the order
4. how it knows it reached the end
5. what it shows on failure
6. what Back and reload restore — state kept in the URL, or lost

Then play the click out at the extreme: the screen after the click, and the
next click. A "Show all" at the maximum, a dropdown with hundreds of options,
an "append more" list that Back throws away — each fails here.

## 3. Heuristics

Jakob Nielsen's ten usability heuristics (nngroup.com, "10 Usability
Heuristics for User Interface Design"), each as the question to ask of a
screen:

1. **Visibility of system status.** Can the user tell at a glance what needs
   action now? Something broken must not look like history; state is shown by
   more than color alone (WCAG 1.4.1).
2. **Match with the real world.** Do labels use the user's words, and does
   every value say what it is? "Doesn't apply" is drawn and differs from "no
   data"; an empty cell says neither.
3. **User control and freedom.** Do Back, reload and shared links return the
   user where they were? Can every action be cancelled before it commits?
4. **Consistency and standards.** Does the same job use the same control,
   label and wording everywhere — two pagers on one page say the same kind of
   thing? Do columns line up across stacked tables?
5. **Error prevention.** Does the design make the error impossible rather than
   reporting it? An input range the backend refuses is better removed than
   validated.
6. **Recognition rather than recall.** Is the context on screen — which item,
   which time zone, which filter is active?
7. **Flexibility and efficiency.** Does each control still work at the
   maximum? Is there an existing path that already does the job (a link that
   filters) before adding a control that duplicates it?
8. **Aesthetic and minimalist design.** Does each value appear once? Is
   anything derivable from what is already shown? Does emphasis go only to
   what needs action?
9. **Help users recognize and recover from errors.** Does each error say what
   happened and what to do, next to where it happened?
10. **Help and documentation.** Is anything unclear without a manual? Fix the
    screen rather than adding an explanation.

Then go element by element: list every column, value and control on the
screen, and ask each one — can it be derived from the others? does it carry
its unit or time zone? does it apply to every kind of item? does it hold at
the maximum? The heuristics above are easy to answer for the page as a whole
and miss the one column that fails them.

## 4. Proposals

When suggesting a feature or control:

- Derive it from step 0. Drop anything that repeats another field, control or
  path, or computes a number that means nothing (a total summed across
  unrelated items).
- Name what it costs the backend. For every write it adds, find what else
  already writes that record (an automatic process that would undo a manual
  change).
- Cite how established products solve the problem — after the data check, not
  instead of it.
- Lead with anything the change removes. Give one recommendation and its
  tradeoff.

## 5. Look

Render each changed design and read the image, at full size and zoomed in.
Check for rows of uneven height, columns that wrap, text sitting under the
wrong header, clipped content, and contrast below 4.5:1.

## The review request

A numbered list of what to look at, then one line per pass above saying what
was checked and anything not drawn yet.
