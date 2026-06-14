# Darktrace Top Navigation Bar Automated Test

This project contains a Robot Framework automated test suite for the Darktrace website top navigation bar.

The feature under test is the desktop top navigation bar on:

```text
https://darktrace.com/
```

The automated tests focus on the areas requested in the work sample:

* Logo image
* Dropdown menus
* Hyperlinks
* Buttons / CTA-style navigation actions

The tests are written using Robot Framework and SeleniumLibrary, and are designed to run in a CI/CD pipeline using GitHub Actions and Docker. This was a choice due to limitations of my machine.

---

## Scope

The tests target the current live Darktrace desktop navigation bar.

After clarification from Darktrace, the live website navigation was used as the source of truth where it differed from the original requirements document.

The in-scope navigation areas are:

* Logo
* Platform
* Solutions
* Why Darktrace
* Resources
* Get a Demo

Partners is visible in the current live navigation bar, but has been excluded from this test scope because the original requirements specifically exclude Partners.

The `Get a demo` form itself is not tested in detail because the feature under test is the top navigation bar. The automation checks that the topbar button exists, has a valid destination, and navigates correctly when clicked.

---

## Project structure

```text
.
├── .github/
│   └── workflows/
│       └── robot-tests.yml
├── resources/
│   └── navigation_links.resource
├── tests/
│   └── darktrace-test-file.robot
├── test-plan.md
└── README.md
```

---

## Test data

Expected navigation destinations are stored separately in:

```text
resources/navigation_links.resource
```

This file contains the expected link text and URL destinations for the navigation menus.

Keeping this data separate makes the main Robot test file easier to read and makes it simpler to update expected links if the live navigation changes.

---

## Automated test coverage

The implemented Robot Framework tests cover the following areas.

### Logo

The logo test checks that:

* the logo is visible;
* the logo loads within one second;
* the expected logo element is present;
* the logo has a valid hyperlink;
* clicking the logo navigates to the Darktrace homepage.

### Dropdown menus

The dropdown menu tests check that:

* the in-scope menu item is visible;
* hovering over the menu opens the dropdown;
* expected links are present;
* required dropdown content is available.

The following dropdowns are covered:

* Platform
* Solutions
* Why Darktrace
* Resources

### Hyperlinks and buttons

The navigation link tests check that:

* expected links have non-empty href values;
* links do not use placeholder values such as `#`;
* links do not use `javascript:void(0)`;
* links point to the expected destination;
* clicking the link or button navigates to the expected page.

The link destination tests use loops to validate multiple menu items from the navigation data file. If one link fails, Robot Framework continues checking the remaining links and records the failure in the report.

### Get a Demo

The Get a Demo test checks that:

* the topbar CTA exists;
* it has a valid href;
* it is clickable;
* clicking it navigates to the expected demo page.

### Load timing

A basic load timing test checks that required navigation content is available within one second, based on the performance requirement in the work sample.

---

## Running the tests in GitHub Actions

The test suite runs automatically using GitHub Actions when changes are pushed to the repository.

The workflow uses Docker to run Robot Framework in a consistent environment.

The workflow file is located at:

```text
.github/workflows/robot-tests.yml
```

The Robot reports are uploaded as a GitHub Actions artifact after each run.

---

## Notes on Docker

A section on running through docker locally is not included, as my PC that I used to work on this project is unable to have docker running on it for several reasons.

With that in mind, I used github actions, as can be seen with the .github/workflows folder.

---

## Notes and assumptions

* The tests are designed for a desktop viewport.
* The live site contains duplicate hidden/mobile navigation elements, so the locators avoid mobile navigation elements where needed.
* JavaScript click is used for some navigation actions because standard Selenium clicks can be unreliable with animated dropdown content in a headless browser.
* The automation validates the top navigation bar, not the full destination pages.
* The destination check confirms that the browser reaches the expected URL after clicking a navigation link or button.
* CAPTCHA and form submission are not tested because they are outside the top navigation bar scope and should not be submitted against the live production site.

---

## Tools used

* Robot Framework
* SeleniumLibrary
* Docker
* GitHub Actions
* Firefox / geckodriver through the Docker test image

---

## Output

Robot Framework generates the standard report files:

```text
output.xml
log.html
report.html
```

These are available from the GitHub Actions artifact after the workflow completes.
