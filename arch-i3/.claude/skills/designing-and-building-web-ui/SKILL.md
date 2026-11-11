---
name: designing-and-building-web-ui
description: Project-agnostic UX rules and screen review for web apps and HTML email. Use when designing, building, changing or reviewing a web app's screen, page, component or HTML email, in a design canvas, a mockup or code (SvelteKit, Next.js, React, Svelte, Tailwind, HTML/CSS), including a "small" change to a screen's button, link, form, table, list, filter, pager, chart, timestamp, dialog, navigation, or an empty, loading or error state, and before proposing a UI feature, column or control.
---

# Designing and building web UI

A project's own UI rules live in `docs/ui-rules.md` in the repo the session
started in. Read it before Ground it when it exists; its rules add to these
and win where they differ. A rule that only fits the project goes there.

The project's design owns the look: rules name colour roles (destructive,
neutral, status, selected), never values, fonts or radii. Rules marked (code)
apply only when building.

1. **Ground it** before designing a screen or proposing anything for one.
2. Run the **Review** before a design is shown or a screen is called done.

## Ground it

1. **The job.** One line: who opens this screen, why, and what they do next.
2. **The data, from the code.** For every list and value the screen shows:
   - how many there can be: the least (zero) and the most, from the code's
     real limits (plan caps, uniqueness rules, retention), not a guess
   - how far back it exists, and what a link to something older finds
   - which fields do not apply to some kinds of item, and which values only
     one kind produces
   - which values derive from others (an end time from a start and a duration)
   - the longest value each text field accepts
3. **The house patterns.** The product's components, its approved screens and
   its decision log. A new screen reuses them for the same job, and copies the
   newest approved version, not an older one that predates a rule.
4. **The controls.** For every control that fetches, filters, sorts or pages:
   the request it makes; how many rows can come back, at the maximum; their
   order; how it knows it reached the end; what it shows on failure; what Back
   and reload restore.

## Rules

### Components

- A choice more than one screen faces gets one app-wide rule and one shared
  component that every screen uses. A screen never has its own colour, button
  or spacing.
- An enabled control is never filled with a neutral grey: grey reads as
  disabled.

### Sizes

Small is under 768 CSS px.

- Every screen works at every width from 320 CSS px with no horizontal scroll
  (WCAG 2.2 SC 1.4.10), tables and charts included.
- On small, every control's tap area is at least 44 × 44 px, padded where the
  drawn control is smaller; a link inside running text is exempt (Apple HIG;
  WCAG 2.2 SC 2.5.5).
- Hover may highlight and preview. It never holds information or an action
  that click or tap can't reach: every size can be touch.

### Layout

- Group by spacing; a divider line only where spacing cannot separate.
- A total sits under what it sums.
- Emphasis is one status pill or banner over plain label/value rows, so it
  goes only to what needs action. Tried and dropped: tint, large type,
  coloured values.

### Values

- Every value has a label. A bare `42` explains nothing; "Open orders" does.
  No prose summary restates data on screen.
- A value appears once per screen unless it is a different fact. A column
  derivable from two others is left out (End beside Start and Duration).
- Codes, methods, URLs and ranges (`2xx`) are monospace; a code's description
  follows in the same colour: `404` Not Found.
- A value that does not apply, where nothing in its row says why, is `N/A` in
  the tag style, read as "Not applicable". Where the row says why, the cell
  stays blank. An empty cell reads as missing data.
- A past expiry shows an Expired pill in place of its date: the date answers
  nothing anyone acts on.

### Text

- Long values (URLs, tokens, records, bodies) wrap after `/`, `.`, `-`, `?`,
  `&`, `=` or `,`, and inside a part only when that part alone is wider than
  the line: a value split mid-token reads as two values.
- A number keeps its unit, and a count ("1–15 of 4,320") stays whole; the
  text beside it wraps instead.
- Headings balance their lines; other text avoids ending on one word
  (`text-wrap: balance` and `pretty`).

### Time

- A date outside the current year carries the year.

### Buttons and links

Primer, Atlassian, Polaris, Carbon, GOV.UK, Fluent and NN/g, read 2026-11-09.

- One primary per screen, its main forward action: the page's create, a
  form's submit, a dialog's confirm. Every other button is secondary.
- Regular size in a page header, a form and a dialog; compact in a card
  header, a toolbar, a pager and beside a value.
- Placed by what it acts on: the page's object in the page header, three at
  most, more under a More menu; a card's list in that card's header; Cancel
  then the primary, last, in a form or dialog footer.
- On small, page-header actions fold into a ⋯ menu, all but the primary;
  footer buttons stack full width, primary first.
- A destructive action is a secondary with text in the destructive colour. A
  solid destructive fill only on the confirm dialog's named button, with
  Cancel focused.
- Deleting or leaving the page's own object sits in a Danger zone at the
  page's foot, a card outlined in the destructive colour with a row per
  action, never beside everyday actions (NN/g top ten application design
  mistakes; GitHub and Vercel settings).
- A link goes somewhere; a button changes something. Links share one style.
- A button starts with a verb and names its object unless where it sits
  already does; pager, step and menu buttons (Previous, Next, More) are
  named for their direction. A create form's opening button and
  its submit read alike: "Create project". A link to one record is "View X",
  to a list "All X".
- A text button carries no icon but three: + before an action that adds to a
  list, ‹ or › on one that moves back or forward, ▾ after one that opens a
  menu. Icon-only buttons are close (×) and the ⋯ menu on small, each with
  an accessible name. Links carry none but the back link's ‹ (Atlassian;
  Primer).

### Navigation

- A page under another opens with a back link ("‹ Projects") at every size.
  Tried and dropped: breadcrumbs, which do not fit at 320 px.
- A list row is one link, to its item: in a table, the first cell's link
  stretched over the row (code).
- A list's filters and page live in the URL, so Back, reload and a shared
  link return to the same rows (code).
- Sign-in returns to the page that sent the person there, so an emailed link
  lands where it points (code).

### Lists and tables

- Tabular data is a `<table>` with `<th scope="col">`.
- Fixed layout: each short column as wide as its widest possible value
  (Ground it); the text column takes the rest and wraps. Tried and dropped:
  auto layout, which moves columns on every page and filter.
- A list pages with a count ("1–15 of 4,320"), and shows no pager when one
  page holds it all. Tried and dropped: Show all (buries what follows), Load
  older (Back loses what it appended).
- A page past the end, after rows go, opens the last page.
- A list shows a record's state in a pill; a detail page shows it in a
  banner.

### Filters

- Each filter is a menu of checkboxes with counts; on small one Filter button
  opens them in a sheet. A menu lists the values in range plus any selected
  value, at 0 if it has none.
- Values in one filter combine with or; filters combine with and. A filter
  change returns to the first page.
  Every value selected is no filter.
- A filter in use reads in the selected colour as its name, first value and
  a count of the rest ("Status: Open +1"). A first value longer than 200 px
  ends in an ellipsis. The row wraps rather than scrolls.
- "Clear filters" follows the buttons while any filter is in use. On small
  the Filter button reads in the selected colour with a count ("Filter · 2"),
  and Clear filters sits at the bar's other end, the one button styled as a
  link, so the Filter button stands alone. The sheet applies with "Show 24
  results" and empties with Clear.
- Nothing matching: "No results match", "Nothing matches these filters."
  and Clear filters.
- Tried and dropped: chips with counts (open-ended values, small width).

### States

- Empty says what is missing and offers the action that fills it ("No
  projects yet", Create project). An empty result names no cause the app
  cannot know.
- A list loading for the first time shows its card, heading and column
  headers at once, with neutral placeholder rows at the real column widths
  and no motion. A detail page shows every card and heading at once with
  placeholders where values land, and leaves out headers that depend on data
  still loading.
- Paging dims the current rows, spins the pressed button, and disables the
  other until the page arrives.
- Parts of a page load apart. A failed request is a system error, not a
  record's state: a neutral block inside the card it was filling (a retry
  icon above "Couldn't load X", then Try again), never a status colour. The
  other cards keep their data. When every request fails, one block replaces
  the cards.
- A missing record shows the shared not-found state: nothing about a missing
  record needs its own words.

### Forms

- One form page, for the first item and every one after.
- No invented section headings.
- Edit is the form filled in, holding only what can change, with Cancel and
  Save changes back to the record. No delete section under it: it reads as part of editing (Danger
  zone).
- A field error from the server shows on its field and takes focus (code).

### Copy

- Headings state; they never ask. A form's heading is a noun ("New project").
- Headings and labels use the product's own terms (its API's, where it has
  one); hints carry the plain language.
- One set of state words, everywhere, emails included.
- Internal codes appear as data, never in prose.
- A limit is stated as the viewer's own value ("up to 3 members"), never by
  naming their plan. Copy that cannot know the viewer's value names no
  number ("Older items are past retention.").

### Charts

- Each series or stage has one distinct hue on every screen. Status colours
  never colour anything but status. Tried and dropped: grey shades (five
  greys read as one).
- Rows of one chart share one scale: 0 to the next 1, 2 or 5 × 10ⁿ at or
  above the highest value, labelled at its top and half in a gutter outside
  the plot; on small the top value only. Tried and dropped: labels inside the
  plot (covered the data).
- The subtitle names the aggregate ("Median per hour").
- Time buckets align to clock boundaries in the zone times show in; a span
  off a boundary takes a partial first and last bucket.
- The axis takes the smallest clock-aligned step that keeps each label 8 px
  clear of the next at its laid-out width, so small shows fewer ticks rather
  than overlapping ones. No label after now. The date shows at the first
  label and at each day change.
- A line breaks over a gap rather than bridging it, and the gap is marked
  with why.
- A mark narrower than 44 px links nowhere; a link beside the chart opens
  the same span as a list.

### Email

Litmus, caniemail, Google and Yahoo sender guidelines, Home Office and NSW
email design systems, read 2026-11-07.

- One column, 600 px max, fitting 320.
- System fonts only: Gmail loads no web fonts.
- Nothing is said only by an image: classic Outlook blocks images by default.
  The wordmark carries alt text or is text.
- A notification email has one button, at least 44 px tall, named for where
  it goes, linking to a URL that holds still.
- Every area sets its own background, and state fills hold 3:1 on
  near-black: Gmail and Outlook invert. Text relies on the client recolouring
  it.
- Text 4.5:1, links underlined, state never by colour alone.
- Preview text under 90 characters, and a subject that reads alone: Apple
  Mail can replace the preview with a summary.
- Plain copy, links only to the app's domain, nothing hidden.
- An email about one account's record names the account at the end of the
  subject: a person in two accounts can have two records of one name. The
  sender stays the product.
- Every notification email ends with "Choose which emails you get", a 44 px
  tap area. Without it a recipient has only Report spam, which costs every
  recipient's delivery.
- An email to someone outside the account (an invitation) keeps text another
  user wrote out of the subject, caps it at entry and shows it whole beside
  its writer's address: it carries scam text through trusted mail.
- A one-time code is large monospace on its own line, one unbroken string so
  a double-tap selects it, with its expiry beside it. No links, and never in
  the subject, which shows on a lock screen. Each send carries a unique
  `X-Entity-Ref-ID`, or Gmail threads repeated codes and folds the expiry
  away; the text part keeps the HTML's order, so the code is never its first
  line (code).
- Times read "Oct 12, 13:54 UTC", in UTC because an email cannot know the
  reader's zone. The head carries the format-detection meta and the
  data-detector reset, so no time turns into a link (code).

## Review

A screen is reviewed by playing it out against its job, the data at its
limits and the rules.

### 1. States

Every card that shows data has these states (Scott Hurff's "UI stack"), each
designed per card, not per page:

- **Empty:** none ever; none right now; none after a filter.
- **Loading:** first load and each later fetch.
- **Partial:** one item; a few.
- **Ideal:** a typical page.
- **Too many:** more than one page; the maximum from Ground it.
- **Error:** each request failing; each input the user can get wrong.
- **Changed underneath:** items gone or added while the user is on a later
  page.

A list that can exceed one page, without its paging and empty states, is not
ready for review.

### 2. Controls

For every control from Ground it, play the click out at the maximum: the
screen after the click, and the next click. A dropdown with hundreds of
options fails here.

### 3. Heuristics

Jakob Nielsen's ten usability heuristics (nngroup.com), as questions:

1. **Visibility of system status.** Can the user tell at a glance what needs
   action now? Something broken must not look like past data; state is
   shown by more than colour alone (WCAG 1.4.1).
2. **Match with the real world.** Do hints use the user's words, and labels
   the product's terms? (Values, Copy.)
3. **User control and freedom.** Can every action be cancelled before it
   commits? (Buttons and links, Forms.)
4. **Consistency and standards.** Does the same job use the same control,
   label and wording everywhere? Do columns line up across stacked tables?
5. **Error prevention.** Does the design make the error impossible rather
   than reporting it? An input the backend refuses is better removed than
   validated.
6. **Recognition rather than recall.** Is the context on screen: which item,
   which filter is active?
7. **Flexibility and efficiency.** Controls and Proposals cover it.
8. **Aesthetic and minimalist design.** Does emphasis go only to what needs
   action? (Values, Layout.)
9. **Recover from errors.** Does each error say what happened and what to
   do, next to where it happened?
10. **Help and documentation.** Is anything unclear without a manual? Fix the
    screen rather than adding an explanation.

Then go element by element: list every column, value and control, and check
each against the Rules. Page-level answers miss the one column that fails.

### 4. Look

Render each changed screen and read the image, at full size and zoomed in.
Check for rows of uneven height, columns that wrap, text under the wrong
header, clipped content, and contrast below 4.5:1.

### Report

A numbered list of what to look at, then one line per pass saying what was
checked and anything not designed yet.

## Proposals

When suggesting a feature or control:

- Derive it from Ground it. Drop anything that repeats another field,
  control or path, or computes a number that means nothing (a total summed
  across unrelated items).
- Name what it costs the backend. For every write it adds, find what else
  already writes that record (an automatic process that would undo a manual
  change).
- Cite how established products solve the problem, after the data check,
  not instead of it.
- Lead with anything the change removes. Give one recommendation and its
  tradeoff.
