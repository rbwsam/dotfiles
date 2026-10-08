---
name: ebay-listing
description: Generate eBay listing data (plain-text title + HTML description) for a product from
  its brand and model. Specs are verified against manufacturer sources; anything unverified
  is omitted rather than guessed, and optionally collects the manufacturer's marketing photos.
  Use when asked to write, draft, or generate an eBay
  listing, product listing, or sale description.
argument-hint: "<brand> <model> [other identifiers]"
---

# eBay listing

The title is plain text. The description is HTML for the HTML tab of eBay's description
editor — pasting rich text from a terminal arrives unformatted, and HTML survives any line
wrapping on the way. No markdown, no emoji, no CSS, no tags beyond `<p>`, `<b>`, `<br>`.

Scope is the product, not the individual item: title, blurb, specifications. Condition,
defects, test status, box contents, and history are the user's to give. Never ask for them,
prompt for them, or mention their absence. When the user supplies them, use their words and
nothing more — no embellishing "tested" into "fully tested", no inferring wear from photos.

The listing is a statement of fact about an item someone will pay for. A wrong spec is a
return, a defect case, or a false-advertising claim. Omitting a spec costs nothing.

## 1. Pin down the exact product

You need one unambiguous SKU, not a product family. Before writing anything, resolve:

- Full model / part number as printed on the item, including suffix letters and region codes
- Variant axes that change the specs: capacity, colour, RAM, region, model year, revision,
  generation, trim, connectivity (Wi-Fi vs cellular), motor/voltage

If the user's input matches more than one variant, or the identifier looks partial, stop and
ask. Use AskUserQuestion with the candidate variants as options, and say what distinguishes
them. Never pick the most likely one.

Ask the user to read the label, base plate, or About screen when the model number is the
blocker. That is faster and more reliable than inference.

## 2. Verify every spec

Search for the manufacturer's own spec sheet, support page, or manual for that exact model
number. Retailer listings, marketplace listings, and aggregator sites are not sources — they
copy each other and they copy errors.

Rules:

- A spec goes in the listing only if you read it on a source you can name for that exact
  model number.
- A spec that only appears for a neighbouring model does not transfer. Not for the 128GB when
  you sourced the 256GB, not for the 2023 when you sourced the 2024.
- Do not compute, convert, or infer specs the source did not state.
- Do not carry a spec forward from your own prior knowledge without checking it.
- If sources disagree, the spec is unresolved: leave it out.

Tell the user which specs you dropped and why. That list is part of the deliverable.

## 3. Manufacturer photos (optional)

Only when the user asks for photos. Skip silently otherwise.

Collect only from the manufacturer's own product, press, or media-kit pages for that exact
model number. A photo of a neighbouring variant is the same error as a borrowed spec: do not
use the black one for the white one, or the 15-inch for the 13-inch.

Save each image under `photos/` in the working directory, named
`<model>-<index>-<what-it-shows>.<ext>`, and record its source URL. Prefer the largest
resolution offered. Do not crop, upscale, or composite them.

Tell the user, once, that eBay requires at least one photo of the actual item for used goods
and that stock imagery alone can get a listing removed — manufacturer shots supplement their
own photos, they do not replace them. State it and move on; it is their listing.

## 4. Write the title

Max 80 characters, hard limit. Count it and print the count.

Order: Brand, Model / part number, defining specs the buyer searches on. Front-load the terms
a search would use. Condition stays out of the title — eBay shows it as its own field. The
one exception: end with "Tested" when the user says the item was tested.

- Title Case or sentence case. Never ALL CAPS.
- No filler: L@@K, WOW, RARE, FAST SHIP, punctuation runs, star or arrow characters.
- No unverified superlatives and no brand names of products this is merely compatible with,
  unless compatibility was verified and is stated as compatibility.

## 5. Write the description

In this order: blurb, condition (only if the user gave it), specifications.

**Blurb** — two to four sentences that sell the thing. Lead with what it does for the buyer
and what it is good at; name a spec only where it is the reason a claim is true. The
specifications section already lists the numbers, and a blurb that restates them in sentences
has sold nothing.

Write to a buyer deciding, not to a database. "Fast enough for 4K timelines without proxies"
sells; "8-core CPU, 32GB RAM, 1TB SSD" does not — that is the section below.

The constraint is truth, not dryness: every claim must be traceable to a verified spec, and a
spec you dropped as unverified cannot be smuggled back in as an adjective. Enthusiasm is fine;
unsupported claims are not. Say nothing about the state of this particular unit — not its age,
wear, or how much use it has had — that belongs in the condition section.

**Condition** — only when the user supplied condition, test status, defects, contents, or
history. A `Condition` heading followed by their facts as sentences or `Label: Value` lines.
Omit the section entirely otherwise.

**Specifications** — one `Label: Value` per line, label in bold, no bullets or symbols. Group logically. Use
the manufacturer's own wording and units. Include the exact model / part number.

RAM: list only brand, series, part number, capacity and module configuration, memory type,
speed (MHz and PC rating), XMP/EXPO profile, form factor (UDIMM/SODIMM/RDIMM, ECC), pin count,
and colour where it varies. No timings, voltages, SPD values, label revisions, or compatibility
lists. PC rating and pin count may come from the JEDEC standard for the verified type, speed,
and form factor (DDR4-2666 is PC4-21300; DDR4 UDIMM/RDIMM is 288-pin, SODIMM 260-pin) when no
manufacturer source states them; cite JEDEC as the source.

Do not invent a returns, warranty, shipping, or payment policy. Those are account settings and
a fabricated one is a binding term.

End the description after the specifications. Never leave an empty "Condition" or "Included"
heading for the user to fill in — an empty heading in a pasted listing reads as an omission.

## 6. Review before delivering

Second pass against the sources, not against your memory of them. Apply the edits, print
nothing about the pass itself.

- Recount the title with a tool (`printf '%s' "$title" | wc -m`), not by eye.
- Re-open the source for every `Label: Value` line and confirm value, unit, and model number
  against the source text. Any line you cannot re-confirm is deleted and listed as omitted.
- Point every blurb sentence at the spec line that makes it true. No spec line, cut the
  sentence.
- Check the model / part number is identical in the title, the spec line, and every source URL.
- Check for markdown, emoji, tags outside `<p>` `<b>` `<br>`, and trailing empty headings.

## 7. Deliver

Print in chat, never in a code block: the terminal indents and pads code blocks, which corrupts
a paste. Shape:

Title (76/80)

<title as a plain line>

Description (paste into eBay's HTML tab)

<description as one line of HTML>

The description is a single line so markdown rendering cannot reflow it:
`<p>blurb</p><p><b>Condition</b><br>Used. Tested.</p><p><b>Specifications</b><br><b>Brand:</b>
Corsair<br><b>Model:</b> ...</p>`. Escape `&`, `<`, `>` in text as entities.

After the listing, list separately:

- Sources used, one URL per spec group
- Photos saved, if any: file path and source URL for each
- Specs omitted as unverified
- Anything you still need from the user to pin down the product (never condition)

Never fill a gap with a plausible value to make the listing look complete.
