# Test Plan: Darktrace ASM – Desktop Top Navigation Bar

## 1. Overview

This test plan covers the revised desktop top navigation bar on the Darktrace homepage.

The feature allows users to navigate from the homepage to key platform, product, solution, company, resource, and demo-request areas of the website.

After clarification from Darktrace, the current live website navigation is used as the source of truth where it differs from the original functional requirements. The original requirements are still used to guide the feature areas under test: logo image, dropdown menus, hyperlinks, and buttons.

The in-scope top navigation elements are:

1. The Darktrace logo, which should be visible and link back to the homepage.
2. The `Platform` dropdown menu.
3. The `Solutions` dropdown menu.
4. The `Why Darktrace` dropdown menu.
5. The `Resources` dropdown menu.
6. The `Get a demo` button.

Partners is visible on the current live navigation bar, but is excluded from this test scope because the original requirements specifically exclude Partners.

The navigation bar should load quickly and should provide users with a reliable way to access the required pages and resources.

---

## 2. Objectives

The main objectives of this test plan are to validate that the desktop top navigation bar:

- Displays the required navigation elements clearly.
- Allows users to navigate to the correct pages.
- Opens the required dropdown menus when hovered.
- Contains the expected navigation links and CTA-style links/buttons.
- Provides a working `Get a demo` navigation path.
- Avoids invalid or placeholder destinations such as empty href values, `#`, or `javascript:void(0)`.
- Loads required navigation content within the expected performance threshold.
- Remains reliable, accessible, and usable across supported desktop browsers.

The detailed demo request form is not the focus of this test plan because the feature under test is the top navigation bar. The `Get a demo` button is tested by confirming that it is present, has a valid destination, and navigates correctly when clicked.

---

## 3. Scope

### In scope

- Desktop top navigation bar on the Darktrace homepage.
- Logo visibility and homepage link behaviour.
- `Platform` dropdown menu.
    - Link visibility.
    - Link destination validation.
    - CTA-style link/button click behaviour.
- `Solutions` dropdown menu.
    - Link visibility.
    - Link destination validation.
    - CTA-style link/button click behaviour.
- `Why Darktrace` dropdown menu.
    - Link visibility.
    - Link destination validation.
    - CTA-style link/button click behaviour.
- `Resources` dropdown menu.
    - Link visibility.
    - Link destination validation.
    - CTA-style link/button click behaviour.
- `Get a demo` button.
    - Visibility in the top navigation bar.
    - Valid href validation.
    - Navigation to the expected demo request page.
- Basic navigation and dropdown performance checks.
- Basic accessibility, usability, security, compatibility, and regression checks related to the navigation bar.

### Out of scope

- `Partners` navigation item, as this is excluded from the assignment scope.
- `Company` as a separate top-level navigation item, as it is not part of the current live topbar structure being automated.
- Detailed validation of the demo request form fields.
- Full demo form submission into production systems.
- CAPTCHA solving or bypassing.
- Full regression testing of unrelated website pages.
- Full content validation of every product, solution, company, or resource page.
- Mobile navigation behaviour unless specifically requested later.
- Pixel-perfect visual design sign-off beyond functional visibility checks.

---

## 4. Assumptions and open questions

The functional requirements are clear enough to start testing, but a few areas should be clarified with the relevant teams.

| Area | Assumption / question | Why it matters |
|---|---|---|
| In-scope menus | The automated test covers the current live desktop menus: `Platform`, `Solutions`, `Why Darktrace`, and `Resources`. | Keeps the test aligned with the current user experience. |
| Excluded menus | `Partners` is excluded because the original requirements exclude it. | Prevents accidental expansion of test scope. |
| URL expectations | The automated tests validate expected destination patterns stored in the navigation data file rather than hard-coding all link checks directly in the main test script. | Keeps the script readable and makes updates easier if live marketing URLs change. |
| Demo request page | The topbar `Get a demo` button should navigate to the expected demo request page. Detailed form validation is treated as outside the topbar automation scope. | Avoids submitting or over-testing a live production lead form. |
| Performance | The one-second requirement is interpreted as a navigation/dropdown content availability check, not a full performance audit of every linked page. | Gives the automated test a realistic and measurable pass/fail condition. |

---

## 5. Test approach

Testing should be performed at multiple levels:

- **Requirement review:** Confirm expected navigation items, hover behaviour, link destinations, topbar button behaviour, and performance expectations before implementation is signed off.
- **Exploratory testing:** Navigate through the desktop top nav as a real user and check that the menus feel usable and stable.
- **UI functional testing:** Validate logo, navigation items, hover menus, links, and buttons.
- **Automated UI testing:** Use Robot Framework with SeleniumLibrary to cover the most valuable repeatable checks in CI/CD.
- **Link validation:** Check that required links have valid destinations and do not use placeholder values.
- **Regression testing:** Confirm related website navigation and homepage behaviour has not been negatively affected.
- **Non-functional testing:** Validate performance, accessibility, usability, compatibility, and basic security concerns related to the navigation bar.

The automated suite should focus on stable, high-value checks rather than trying to verify every visual design detail. The expected link destinations are stored in a separate navigation data file so that the main Robot Framework test file remains readable and easier to maintain.

---

## 6. Test environments

| Environment | Purpose |
|---|---|
| Local | Initial development and debugging of automated tests. |
| Test/QA | Main functional and automated validation before release, if available. |
| Staging/pre-production | Final validation against production-like content and configuration, if available. |
| Production smoke test | Limited post-release validation of critical navigation paths only. |

---

## 7. Test data

| Data type | Examples |
|---|---|
| Navigation text | `Platform`, `Solutions`, `Why Darktrace`, `Resources`, `Get a demo`. |
| Platform links |  Expected Platform links are maintained in `resources/navigation_links.resource`. ||
| Solutions links | Expected Solutions links are maintained in `resources/navigation_links.resource`. |
| Why Darktrace links | Expected Why Darktrace links are maintained in `resources/navigation_links.resource`. |
| Resources links | Expected Resources links are maintained in `resources/navigation_links.resource`. |
| Topbar CTA | `Get a demo`. |
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

- ActiveAI Security Platform
- Network
- Email
- Cloud
- Secure AI
- OT
- Identity
- Endpoint
- Proactive Exposure Management
- Adaptive Human Defense
- Attack Surface Management
- Forensic Acquisition and Investigation
- Incident Readiness and Recovery
- Cyber AI Analyst
- Services
- Integrations

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
- Confirm required navigation links do not point to placeholder destinations.
- Confirm external links, if any, open safely and do not introduce tabnabbing risk.
- Avoid submitting or bypassing production forms/CAPTCHA from automated tests.

### 10.2 Performance

- Homepage navigation should be visible within one second under agreed test conditions.
- Hover menus should appear within one second of hover.
- Required navigation content should not noticeably delay page interaction.
- The automated test should avoid unnecessary full-page checks and should run efficiently in CI.
- Any performance failure should include environment details, browser, connection, and timing evidence.

### 10.3 Usability

- Users should be able to understand which nav item they are interacting with.
- Dropdown menus should not disappear too quickly while moving the cursor.
- Dropdown content should not overlap in a way that blocks interaction.
- Navigation labels should be clear and readable.
- `Get a demo` should be visually prominent.

### 10.4 Compatibility

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
- Existing platform/product page navigation.
- Existing solution page navigation.
- Existing resource page navigation.
- Existing demo request navigation path.
- Cookie banner behaviour.
- Header behaviour on scroll, if sticky navigation is supported.
- Footer links only where affected by shared link or routing components.
- Analytics/tracking events only if nav tracking was changed.
- Existing accessibility behaviour of the header.

---

## 12. Automated test cases implemented

The following automated test cases were implemented in Robot Framework using SeleniumLibrary. The test suite focuses on the current live desktop top navigation bar and excludes Partners, as the original requirements state that Partners is out of scope.

The expected navigation links and destinations are maintained separately in `resources/navigation_links.resource`, keeping the main Robot test file focused on test logic.

| ID | Automated test case | What is tested | Expected result |
|---|---|---|---|
| AUTO-001 | Test Logo Image And Homepage Link | Checks that the Darktrace logo loads within one second, is the expected logo element, has a valid hyperlink, and navigates back to the homepage when clicked | Logo is visible, valid, and links to the Darktrace homepage |
| AUTO-002 | Test Platform Menu | Opens the Platform dropdown and checks that the expected Platform links are present and have valid href values | Platform dropdown opens and expected links are present |
| AUTO-003 | Test Platform Menu Links Navigate Correctly | Loops through the Platform links listed in the navigation data file, checks each href, clicks each link/button, and verifies navigation to the expected destination | Each Platform link/button navigates to the expected page |
| AUTO-004 | Test Solutions Menu | Opens the Solutions dropdown and checks that the expected Solutions links are present and have valid href values | Solutions dropdown opens and expected links are present |
| AUTO-005 | Test Solutions Menu Links Navigate Correctly | Loops through the Solutions links listed in the navigation data file, checks each href, clicks each link/button, and verifies navigation to the expected destination | Each Solutions link/button navigates to the expected page |
| AUTO-006 | Test Why Darktrace Menu | Opens the Why Darktrace dropdown and checks that the expected Why Darktrace links are present and have valid href values | Why Darktrace dropdown opens and expected links are present |
| AUTO-007 | Test Why Darktrace Menu Links Navigate Correctly | Loops through the Why Darktrace links listed in the navigation data file, checks each href, clicks each link/button, and verifies navigation to the expected destination | Each Why Darktrace link/button navigates to the expected page |
| AUTO-008 | Test Resources Menu | Opens the Resources dropdown and checks that the expected Resources links are present and have valid href values | Resources dropdown opens and expected links are present |
| AUTO-009 | Test Resource Menu Links Navigate Correctly | Loops through the Resources links listed in the navigation data file, checks each href, clicks each link/button, and verifies navigation to the expected destination | Each Resources link/button navigates to the expected page |
| AUTO-010 | Test Get A Demo Hyperlink | Checks that the Get a Demo topbar button has a valid href, is not a placeholder link, can be clicked, and navigates to the expected demo page | Get a Demo button navigates to the demo page |
| AUTO-011 | Test Navigation Resources Load Under A Second | Checks that the main navigation and selected dropdown content are available within one second | Required navigation content loads within the expected time |

### Notes on automated coverage

The automation validates the four main areas requested in the brief:

- **Logo image**: the logo is checked for visibility, correctness, load time, hyperlink validity, and navigation to the homepage.
- **Dropdown menus**: the Platform, Solutions, Why Darktrace, and Resources dropdowns are opened and checked.
- **Hyperlinks**: expected links are checked for non-empty href values and invalid placeholder values such as `#` or `javascript`.
- **Buttons**: navigation buttons and CTA-style links are clicked and checked to confirm that they navigate to the expected destination.

The test suite uses loops for the menu link navigation tests. If one link fails, the test continues checking the remaining links and records the failed item in the Robot Framework report.

---

## 13. Risks and mitigations

| Risk | Impact | Mitigation |
|---|---|---|
| Live site content changes often | Automated tests become flaky or fail for non-functional reasons | Store expected destinations in a separate navigation data file and update it when the live nav changes. |
| Exact URLs change for marketing reasons | Tests fail even though user journey still works | Validate meaningful destination patterns and keep expected URLs easy to maintain. |
| Hover menus are difficult to automate reliably | CI failures may become flaky | Use explicit waits, desktop viewport, and repeatable hover actions. |
| Cookie banner interferes with navigation | Tests fail before feature is reached | Add a safe cookie-accept helper in automation. |
| CAPTCHA blocks automation | Automated form submission is not possible | Do not attempt production form submission; validate only the topbar navigation path. |
| Performance target is too broad | Unclear pass/fail criteria | Treat the automated one-second check as a navigation content availability check rather than a full performance audit. |
| Generated CSS selectors change | Tests become brittle | Avoid class-based selectors where possible and prefer text/href-based checks. |
| Hidden mobile navigation duplicates are present | Tests may interact with hidden or incorrect elements | Exclude mobile navigation elements in locators where needed. |
| Accessibility not considered in hover-only menus | Keyboard and screen-reader users may be blocked | Include accessibility checks manually or expand automation later if required. |

---

## 14. Entry and exit criteria

### Entry criteria

- Functional requirements are reviewed.
- Scope exclusions are confirmed, especially `Partners`.
- Expected navigation menus and link destinations are agreed or captured in the navigation data file.
- Performance expectation is interpreted for navigation and dropdown availability.
- Test environment is available.
- Supported browsers are confirmed.
- Automation framework and CI execution approach are agreed.

### Exit criteria

- All critical and high-priority navigation tests pass.
- Required navigation items are visible and usable.
- Required hover menus open reliably.
- Required navigation links are present and valid.
- Required navigation links/buttons navigate to the expected destinations.
- The logo links back to the homepage.
- The `Get a demo` button navigates to the expected demo request page.
- No open critical or high-severity defects remain.
- Non-functional checks for accessibility, usability, compatibility, security, and performance are complete or risk-accepted.
- Automated checks are added to CI or prepared for CI integration.
- PO/BA/design/development have reviewed and accepted any behaviour that differs from the original assumptions.

---

## 15. Collaboration throughout the sprint

I would approach this as a shared quality responsibility across the sprint, rather than only testing the navigation bar at the end.

### Design/refinement phase

During refinement, I would review the supplied requirements with the PO, BA, Designer, and Developers. The main areas I would clarify are the exact expected navigation items, whether additional live-site items should be ignored, what the correct link destinations are, and what behaviour is expected from the topbar `Get a demo` button.

I would also ask the team to clarify the one-second performance requirement, because it could mean homepage navigation visibility, dropdown loading, linked page loading, or all resources. Without this clarification, the test result could be interpreted differently by different people.

### Development phase

During development, I would work with the developers to make the navigation easier to test and maintain. For example, stable accessible labels or data attributes would make the automated tests more reliable than depending on generated CSS classes.

I would also prepare the Robot Framework/SeleniumLibrary test structure early, so the tests can be added to the CI/CD pipeline as soon as the first testable version of the navigation bar is available.

### Testing phase

As the feature becomes available, I would test it in small increments. I would first confirm that the homepage and core nav elements are visible, then test the hover menus, then validate the links and buttons.

Any defects would be raised with clear reproduction steps, expected vs actual behaviour, browser details, screenshots or video where useful, and a severity based on user impact.

### Sprint completion

Before sign-off, I would review the completed navigation bar with the PO/BA and confirm that all clarified rules have been covered. I would also confirm which checks are automated, which are manual, and which should be added to the backlog as future improvements.

This approach helps keep the feature testable, avoids late surprises, and protects the user journey through one of the most important parts of the website.
