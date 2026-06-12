# Test Plan: Darktrace ASM – Desktop Top Navigation Bar

## 1. Overview

This test plan covers the revised desktop top navigation bar on the Darktrace homepage.

The feature allows users to navigate from the homepage to key product, platform, AI, resource, and demo-request areas of the website.

The navigation bar includes the following main elements:

1. The Darktrace logo, which should be visible and link back to the homepage.
2. The `Platform` navigation item.
3. The `Products` hover menu.
4. The `Our AI` hover menu.
5. The `Resources` hover menu.
6. The `Get a Demo` button and demo request form.

The navigation bar should load quickly and should provide users with a reliable way to access the required pages and resources.

---

## 2. Objectives

The main objectives of this test plan are to validate that the desktop top navigation bar:

- Displays the required navigation elements clearly.
- Allows users to navigate to the correct pages.
- Opens the required hover menus when expected.
- Contains the correct product and resource links.
- Provides a working `Get a Demo` path.
- Displays the required demo request form fields.
- Includes required form controls such as marketing consent, CAPTCHA, and submit button.
- Loads required navigation resources within the expected performance threshold.
- Remains reliable, accessible, and usable across supported desktop browsers.

---

## 3. Scope

### In scope

- Desktop top navigation bar on the Darktrace homepage.
- Logo visibility and homepage link behaviour.
- `Platform` navigation item.
- `Products` hover menu.
    - Product link visibility.
    - Product link destination validation.
- `Our AI` hover menu.
    - Our AI button/link visibility.
    - Our AI destination validation.
- `Resources` hover menu.
    - Resource link visibility.
    - Resource link destination validation.
- `Get a Demo` button.
    - Navigation to demo request page.
    - Demo form field visibility.
    - Demo form dropdown visibility.
    - Marketing opt-in checkbox presence.
    - CAPTCHA presence.
    - Submit button presence.
- Basic page-load and hover-menu performance checks.
- Basic accessibility, usability, security, compatibility, and regression checks related to the navigation bar.

### Out of scope

- `Company` and `Partners` navigation items, as these are excluded from the assignment scope.
- Full regression testing of unrelated website pages.
- Full content validation of every product or resource page.
- Full demo form submission into production systems.
- CAPTCHA solving or bypassing.
- Mobile navigation behaviour unless specifically requested later.
- Visual design sign-off beyond layout and functional visibility checks.

---

## 4. Assumptions and open questions

The functional requirements are clear enough to start testing, but a few areas should be clarified with the relevant teams.

| Area | Question | Why it matters |
|---|---|---|
| Live site differences | Should the test follow the supplied requirements only, or should it also validate new live-site navigation items? | The live website may contain more items than the work-sample requirements. The test should avoid failing because of unrelated extra items. |
| URL expectations | Are exact URLs required for each nav item, or is it acceptable to validate that each item has a valid non-placeholder destination? | Impacts how strict the automation should be. Exact URLs are more brittle if marketing URLs change. |
| Products menu | Should each listed product be a direct link, or can some be grouped under category pages? | Impacts expected results and automation selectors. |
| Our AI menu | The requirement says the dropdown contains a single button. Should the automated test fail if the live site contains more than one item? | Impacts whether the test is strict or tolerant of additional content. |
| Resources menu | Does “Link to the white paper” mean a specific named white paper, or any white-paper link? | Needed to validate the correct resource. |
| Demo form | Is the `Get a Demo` form expected to open on a separate page, modal, or embedded form area? | The requirements mention a page and also a modal. This should be clarified. |
| Form submission | Should testing stop at field validation, or should a non-production test submission be completed in a test environment? | Production form submission could create real leads or spam data. |
| Performance | Does “all resources should load under a second” apply to the homepage, dropdowns, linked pages, or every linked resource? | Needed for realistic performance testing and pass/fail criteria. |
| CAPTCHA | Which CAPTCHA provider should be expected? | Helps test the presence of anti-bot protection without trying to bypass it. |
| Accessibility standard | Should the team target WCAG 2.1 AA or another standard? | Needed for clear accessibility expectations. |

---

## 5. Test approach

Testing should be performed at multiple levels:

- **Requirement review:** Confirm expected navigation items, hover behaviour, link destinations, demo form behaviour, and performance expectations before implementation is signed off.
- **Exploratory testing:** Navigate through the desktop top nav as a real user and check that the menus feel usable and stable.
- **UI functional testing:** Validate logo, navigation items, hover menus, links, buttons, and demo form controls.
- **Automated UI testing:** Use Robot Framework with SeleniumLibrary to cover the most valuable repeatable checks in CI/CD.
- **Link validation:** Check that required links have valid destinations and do not use placeholder values.
- **Regression testing:** Confirm related website navigation and homepage behaviour has not been negatively affected.
- **Non-functional testing:** Validate performance, accessibility, usability, compatibility, and basic security concerns.

The automated suite should focus on stable, high-value checks rather than trying to verify every visual design detail. Selectors should use visible text and href validation where possible, because marketing websites often use generated CSS classes that can change frequently.

---

## 6. Test environments

| Environment | Purpose |
|---|---|
| Local | Initial development and debugging of automated tests. |
| Test/QA | Main functional and automated validation before release. |
| Staging/pre-production | Final validation against production-like content and configuration. |
| Production smoke test | Limited post-release validation of critical navigation paths only. |

Test configuration should include:

- Desktop viewport, for example `1440x1000`.
- Supported desktop browsers.
- Stable internet connection.
- Test data or staging configuration for the demo form if submission testing is required.
- Browser console and network logging available for investigation.

---

## 7. Test data

| Data type | Examples |
|---|---|
| Navigation text | `Platform`, `Products`, `Our AI`, `Resources`, `Get a Demo`. |
| Product links | `Network`, `Cloud`, `Identity`, `Email`, `OT`, `Endpoint`, `Proactive Exposure Management`, `Attack Surface Management`, `Incident Readiness & Recovery`, `Cyber AI Analyst`, `Services`. |
| Resource links | `Customers`, `Events`, `The Inference`, `Blog`, `Inside the SOC`, `Glossary`, `All resources`, `White paper`. |
| Demo text fields | `Name`, `Email`, `Organization`, `Job Title`, `Phone Number`. |
| Demo dropdowns | `Country`, `Organization Size`. |
| Demo checkbox | Marketing email consent checkbox. |
| CAPTCHA | CAPTCHA or anti-bot protection element. |
| Invalid link examples | Empty href, `#`, `javascript:void(0)`, broken 404 destination. |
| Browser data | Fresh session, existing cookie session, accepted-cookie session. |

---

## 8. Navigation bar test cases

The feature under test is the Darktrace desktop top navigation bar. The test cases focus on the navigation elements requested in the brief: the logo image, dropdown menus, hyperlinks, and buttons.

Partners is visible on the current live navigation bar, but has been excluded from this test scope because the original requirements specifically exclude Partners.

The `Get a demo` page/form itself is not tested in detail because the form is outside the top navigation bar feature. The navigation button is tested by confirming that it is present, has a valid destination, and navigates correctly when clicked.

---

### 8.1 Homepage and logo image

| ID      | Scenario                                          | Expected result                                       |
| ------- | ------------------------------------------------- | ----------------------------------------------------- |
| NAV-001 | Open the Darktrace homepage on a desktop viewport | Homepage loads and the top navigation bar is visible  |
| NAV-002 | Check the top-left logo image                     | Darktrace logo is visible within one second           |
| NAV-003 | Check the logo image                              | Logo is the expected Darktrace logo and is not broken |
| NAV-004 | Check the logo hyperlink                          | Logo has a valid non-empty href                       |
| NAV-005 | Click the Darktrace logo                          | User is taken to the Darktrace homepage               |

---

### 8.2 Platform dropdown menu

| ID      | Scenario                              | Expected result                                                        |
| ------- | ------------------------------------- | ---------------------------------------------------------------------- |
| NAV-006 | Check the top navigation bar          | `Platform` item is visible                                             |
| NAV-007 | Hover over `Platform`                 | Platform dropdown menu opens                                           |
| NAV-008 | Check Platform dropdown content       | Expected Platform menu links are present                               |
| NAV-009 | Check Platform link destinations      | Each expected Platform link has a valid non-empty href                 |
| NAV-010 | Click Platform dropdown links/buttons | Each tested Platform link/button navigates to the expected destination |
| NAV-011 | Check Platform dropdown load time     | Required Platform dropdown content is available within one second      |

Expected Platform links/buttons include:

* ActiveAI Security Platform
* Network
* Email
* Cloud
* Secure AI
* OT
* Identity
* Endpoint
* Proactive Exposure Management
* Adaptive Human Defense
* Attack Surface Management
* Forensic Acquisition and Investigation
* Incident Readiness and Recovery
* Cyber AI Analyst
* Services
* Integrations

---

### 8.3 Solutions dropdown menu

| ID      | Scenario                               | Expected result                                                         |
| ------- | -------------------------------------- | ----------------------------------------------------------------------- |
| NAV-012 | Check the top navigation bar           | `Solutions` item is visible                                             |
| NAV-013 | Hover over `Solutions`                 | Solutions dropdown menu opens                                           |
| NAV-014 | Check Solutions dropdown content       | Expected Solutions menu links are present                               |
| NAV-015 | Check Solutions link destinations      | Each expected Solutions link has a valid non-empty href                 |
| NAV-016 | Click Solutions dropdown links/buttons | Each tested Solutions link/button navigates to the expected destination |
| NAV-017 | Check Solutions dropdown load time     | Required Solutions dropdown content is available within one second      |

Expected Solutions links/buttons are maintained in the navigation data file used by the automated test.

---

### 8.4 Why Darktrace dropdown menu

| ID      | Scenario                                   | Expected result                                                             |
| ------- | ------------------------------------------ | --------------------------------------------------------------------------- |
| NAV-018 | Check the top navigation bar               | `Why Darktrace` item is visible                                             |
| NAV-019 | Hover over `Why Darktrace`                 | Why Darktrace dropdown menu opens                                           |
| NAV-020 | Check Why Darktrace dropdown content       | Expected Why Darktrace menu links are present                               |
| NAV-021 | Check Why Darktrace link destinations      | Each expected Why Darktrace link has a valid non-empty href                 |
| NAV-022 | Click Why Darktrace dropdown links/buttons | Each tested Why Darktrace link/button navigates to the expected destination |
| NAV-023 | Check Why Darktrace dropdown load time     | Required Why Darktrace dropdown content is available within one second      |

Expected Why Darktrace links/buttons are maintained in the navigation data file used by the automated test.

---

### 8.5 Resources dropdown menu

| ID      | Scenario                               | Expected result                                                         |
| ------- | -------------------------------------- | ----------------------------------------------------------------------- |
| NAV-024 | Check the top navigation bar           | `Resources` item is visible                                             |
| NAV-025 | Hover over `Resources`                 | Resources dropdown menu opens                                           |
| NAV-026 | Check Resources dropdown content       | Expected Resources menu links are present                               |
| NAV-027 | Check Resources link destinations      | Each expected Resources link has a valid non-empty href                 |
| NAV-028 | Click Resources dropdown links/buttons | Each tested Resources link/button navigates to the expected destination |
| NAV-029 | Check Resources dropdown load time     | Required Resources dropdown content is available within one second      |

Expected Resources links/buttons are maintained in the navigation data file used by the automated test.

---

### 8.6 Get a Demo button

| ID      | Scenario                                       | Expected result                                 |
| ------- | ---------------------------------------------- | ----------------------------------------------- |
| NAV-030 | Check the right side of the top navigation bar | `Get a demo` button is visible                  |
| NAV-031 | Check Get a Demo href                          | Button has a valid non-empty href               |
| NAV-032 | Click `Get a demo`                             | User is taken to the expected demo request page |

The demo request form itself is outside the scope of this navigation bar test. The test only validates that the top navigation button works correctly.

---

### 8.7 General navigation behaviour

| ID      | Scenario                                          | Expected result                                                      |
| ------- | ------------------------------------------------- | -------------------------------------------------------------------- |
| NAV-033 | Open homepage with a fresh browser session        | Navigation behaves correctly without existing cookies                |
| NAV-034 | Open homepage after accepting cookies             | Navigation remains usable                                            |
| NAV-035 | Use a desktop viewport                            | Desktop navigation is visible and usable                             |
| NAV-036 | Hover over each in-scope dropdown menu            | The correct dropdown opens                                           |
| NAV-037 | Move between in-scope dropdown menus              | Active dropdown updates correctly                                    |
| NAV-038 | Check required navigation links                   | Required links do not use empty hrefs, `#`, or `javascript:void(0)`  |
| NAV-039 | Click required navigation links/buttons           | Required links/buttons navigate to the expected destinations         |
| NAV-040 | Check hidden/mobile duplicate navigation elements | Desktop tests interact with the intended desktop navigation elements |

---

## 9. Link, integration, and content validation

Because the feature is mainly navigational, integration testing focuses on whether the navigation points to the correct live content and whether the linked destinations are reachable.

| ID      | Scenario                                      | Expected result                                                                             |
| ------- | --------------------------------------------- | ------------------------------------------------------------------------------------------- |
| INT-001 | Validate required Platform hrefs              | Each required Platform item points to the expected destination                              |
| INT-002 | Validate required Solutions hrefs             | Each required Solutions item points to the expected destination                             |
| INT-003 | Validate required Why Darktrace hrefs         | Each required Why Darktrace item points to the expected destination                         |
| INT-004 | Validate required Resources hrefs             | Each required Resources item points to the expected destination                             |
| INT-005 | Validate logo href                            | Logo links to the Darktrace homepage                                                        |
| INT-006 | Validate Get a Demo href                      | Get a Demo button links to the expected demo page                                           |
| INT-007 | Check for placeholder links                   | No required item uses an empty href, `#`, or `javascript:void(0)`                           |
| INT-008 | Click required links/buttons                  | Browser navigates to the expected destination after click                                   |
| INT-009 | Check cookie banner does not block navigation | Navigation remains usable before and after cookie consent                                   |
| INT-010 | Check in-scope navigation only                | Partners is excluded from test coverage because it is excluded in the original requirements |

---

## 10. Non-functional testing

### 10.1 Security

- Confirm required links do not use unsafe `javascript:` hrefs.
- Confirm linked pages use HTTPS.
- Confirm the demo form is protected by CAPTCHA or equivalent anti-bot control.
- Do not attempt to bypass or solve CAPTCHA in automation.
- Confirm the demo form does not expose sensitive debug information in the page or console.
- Confirm form validation is handled server-side as well as client-side in non-production environments.
- Confirm external links, if any, open safely and do not introduce tabnabbing risk.

### 10.2 Performance

- Homepage navigation should be visible within one second under agreed test conditions.
- Hover menus should appear within one second of hover.
- Required nav resources should not noticeably delay page interaction.
- The automated test should avoid unnecessary full-page checks and should run efficiently in CI.
- Any performance failure should include environment details, browser, connection, and timing evidence.

### 10.3 Accessibility

- Navigation links and buttons should be reachable by keyboard.
- Dropdowns should be usable without relying only on mouse hover, if accessibility requirements demand this.
- Interactive elements should have accessible names.
- Focus should be visible when tabbing through the navigation.
- Colour should not be the only indication of hover or active state.
- Demo form fields should have accessible labels.
- Validation errors should be readable by assistive technologies.

### 10.4 Usability

- Users should be able to understand which nav item they are interacting with.
- Dropdown menus should not disappear too quickly while moving the cursor.
- Dropdown content should not overlap in a way that blocks interaction.
- Product and resource names should be clear and readable.
- `Get a Demo` should be visually prominent.
- Demo form requirements should be clear before submission.

### 10.5 Compatibility

Test on supported desktop browser combinations, for example:

- Chrome on Windows.
- Chrome on macOS.
- Firefox on Windows or macOS.
- Edge on Windows.
- Safari on macOS, if supported.

Responsive/mobile navigation can be tested separately if the feature scope is expanded beyond desktop.

---

## 11. Regression testing

The following existing areas should be regression tested:

- Homepage page load.
- Existing top-navigation styling and layout.
- Existing product page navigation.
- Existing resource page navigation.
- Existing demo request flow.
- Cookie banner behaviour.
- Header behaviour on scroll, if sticky navigation is supported.
- Footer links only where affected by shared link or routing components.
- Analytics/tracking events only if nav tracking was changed.
- Existing accessibility behaviour of the header.

---

## 12. Automation candidates

Good candidates for automation:

- Logo is visible and links to the homepage.
- Platform item is visible and has a valid destination.
- Products hover menu opens.
- Products dropdown contains all required product links.
- Product links have valid non-placeholder hrefs.
- Our AI hover menu opens.
- Our AI dropdown has a valid destination.
- Resources hover menu opens.
- Resources dropdown contains all required resource links.
- Resource links have valid non-placeholder hrefs.
- Get a Demo button is visible and opens the demo request page.
- Demo form contains required fields.
- Demo form contains required dropdowns.
- Marketing opt-in checkbox is present.
- CAPTCHA or anti-bot protection is present.
- Submit button is present.
- Key nav elements appear within one second.

Not good candidates for automation:

- CAPTCHA solving.
- Production form submission unless a safe test environment is provided.
- Pixel-perfect design comparison.
- Deep content validation of every linked product/resource page.
- Tests that rely heavily on generated CSS class names.

---

## 13. Risks and mitigations

| Risk | Impact | Mitigation |
|---|---|---|
| Live site content changes often | Automated tests become flaky or fail for non-functional reasons | Use requirement-driven checks and stable selectors based on visible text and valid hrefs. |
| Exact URLs change for marketing reasons | Tests fail even though user journey still works | Validate meaningful destination patterns or non-placeholder links unless exact URLs are required. |
| Hover menus are difficult to automate reliably | CI failures may become flaky | Use explicit waits, desktop viewport, and repeatable hover actions. |
| Cookie banner interferes with navigation | Tests fail before feature is reached | Add a safe cookie-accept helper in automation. |
| CAPTCHA blocks automation | Automated form submission is not possible | Validate CAPTCHA presence only and avoid bypass attempts. |
| Ambiguous demo form behaviour | Tests may check page when product expects modal, or the reverse | Clarify expected behaviour before final sign-off. |
| Performance target is too broad | Unclear pass/fail criteria | Agree whether one-second requirement applies to nav visibility, dropdowns, linked pages, or all resources. |
| Generated CSS selectors change | Tests become brittle | Avoid class-based selectors where possible. |
| Production form submissions create real leads | Spam or polluted CRM data | Do not submit forms in production. Use staging/test data only. |
| Accessibility not considered in hover-only menus | Keyboard and screen-reader users may be blocked | Include keyboard and accessible-name checks. |

---

## 14. Entry and exit criteria

### Entry criteria

- Functional requirements are reviewed.
- Scope exclusions are confirmed, especially `Company` and `Partners`.
- Expected product and resource lists are agreed.
- Demo form behaviour is clarified: page, modal, or embedded form.
- Performance expectation is clarified.
- Test environment is available.
- Supported browsers are confirmed.
- Automation framework and CI execution approach are agreed.

### Exit criteria

- All critical and high-priority functional tests pass.
- Required navigation items are visible and usable.
- Required hover menus open reliably.
- Required product and resource links are present and valid.
- Demo request page/form contains the required fields and controls.
- No open critical or high-severity defects remain.
- Non-functional checks for accessibility, usability, compatibility, security, and performance are complete or risk-accepted.
- Automated checks are added to CI or prepared for CI integration.
- PO/BA/design/development have reviewed and accepted any behaviour that differs from the original assumptions.

---

## 15. Collaboration throughout the sprint

I would approach this as a shared quality responsibility across the sprint, rather than only testing the navigation bar at the end.

### Design/refinement phase

During refinement, I would review the supplied requirements with the PO, BA, Designer, and Developers. The main areas I would clarify are the exact expected navigation items, whether additional live-site items should be ignored, what the correct link destinations are, and whether the `Get a Demo` form should open as a page, modal, or embedded form.

I would also ask the team to clarify the one-second performance requirement, because it could mean homepage navigation visibility, dropdown loading, linked page loading, or all resources. Without this clarification, the test result could be interpreted differently by different people.

### Development phase

During development, I would work with the developers to make the navigation easier to test and maintain. For example, stable accessible labels or data attributes would make the automated tests more reliable than depending on generated CSS classes.

I would also prepare the Robot Framework/SeleniumLibrary test structure early, so the tests can be added to the CI/CD pipeline as soon as the first testable version of the navigation bar is available.

### Testing phase

As the feature becomes available, I would test it in small increments. I would first confirm that the homepage and core nav elements are visible, then test the hover menus, then validate the links, and finally test the demo request path.

Any defects would be raised with clear reproduction steps, expected vs actual behaviour, browser details, screenshots or video where useful, and a severity based on user impact.

### Sprint completion

Before sign-off, I would review the completed navigation bar with the PO/BA and confirm that all clarified rules have been covered. I would also confirm which checks are automated, which are manual, and which should be added to the backlog as future improvements.

This approach helps keep the feature testable, avoids late surprises, and protects the user journey through one of the most important parts of the website.
