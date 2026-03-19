# AI Coding Kata - Legacy Checkout Refactoring v1.0.0

## Scenario

You inherited a legacy checkout/pricing module.
It works, but it is hard to understand, hard to change, and risky to extend.

The code currently handles:
- customer types
- discounts
- shipping
- taxes
- occasional promotions

The implementation is intentionally poor:
- long conditional chains
- duplicated business rules
- mixed responsibilities
- hidden quirks
- low readability
- poor extensibility

## Objective

Refactor the pricing module so that:
- current behavior is preserved
- the design becomes easier to extend
- a new customer type and a new promotion can be added safely
- the solution remains simple and understandable

## New requirement

Add support for a new customer type: `partner`

Partner rules:
- base discount: 12%
- free shipping when discounted subtotal is at least 15000 cents
- coupon `PARTNER5` adds an extra 5% discount only for partner customers and only when subtotal is at least 12000 cents
- on Black Friday, partner customers get an extra 3% discount instead of the usual 5%

## Constraints

- Preserve existing behavior unless the new requirement explicitly changes it
- Do not rewrite everything from scratch
- Do not add new external libraries
- Do not change the input/output contract
- Do not add more conditional complexity to the main legacy flow
- Add a safety net before making structural changes
- Introduce structure only when justified by the problem

## Work rules

- Everyone works on their own branch
- AI may be used to understand, design, test, refactor, and implement
- AI output must not be accepted blindly
- Every significant change must be understood by the person committing it
- Before introducing a new structure, create a safety net of tests
- The design pattern is not the goal by itself
- At least one AI proposal must be rejected and documented
- The requirement must not be reinterpreted to fit the current code

## Prompt rules

Prompts must be committed to the repo.

They must be:
- readable
- intentional
- specific enough to explain what was asked and why

At least:
- one prompt must explicitly ask to preserve behavior
- one prompt must ask for alternatives and tradeoffs
- one prompt must be test-oriented

## Deliverables

Commit all of the following:

- refactored code
- tests
- `prompts.md`
- `solution.md`

`prompts.md` must contain:
- prompt
- purpose
- outcome
- notes

`solution.md` must contain:
- what was wrong in the legacy design
- what changed
- why the new structure is easier to extend
- one AI suggestion that was rejected and why

## Completion criteria

A solution is considered complete when:
- existing behavior is preserved
- the new `partner` requirement works
- tests exist and protect behavior
- adding a new customer type or coupon no longer requires editing a large conditional block
- naming is clear and consistent
- the code is easier to explain than the starting point

## Examples

These examples are intentionally partial.

- `regular`, subtotal `10000`, country `IT`, no coupon, not Black Friday -> total `12900`
- `premium`, subtotal `10000`, country `DE`, coupon `SAVE10`, not Black Friday -> total `10420`
- `vip`, subtotal `18000`, country `IT`, coupon `VIPONLY`, not Black Friday -> total `17980`

## Discussion criteria

The final discussion is not about choosing a winner.

Use these criteria:
- correctness
- quality of safety net
- refactoring quality
- real extensibility
- simplicity
- prompt quality
- ability to explain tradeoffs