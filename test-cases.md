## 10. Automated test cases implemented

The following automated test cases were implemented in Robot Framework using SeleniumLibrary. The test suite focuses on the current live desktop top navigation bar and excludes Partners, as the original requirements state that Partners is out of scope.

The expected navigation links and destinations are maintained separately in `resources/navigation_links.resource`, keeping the main Robot test file focused on test logic.

| ID       | Automated test case                              | What is tested                                                                                                                                                           | Expected result                                               |
| -------- | ------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------- |
| AUTO-001 | Test Logo Image And Homepage Link                | Checks that the Darktrace logo loads within one second, is the expected logo element, has a valid hyperlink, and navigates back to the homepage when clicked             | Logo is visible, valid, and links to the Darktrace homepage   |
| AUTO-002 | Test Platform Menu                               | Opens the Platform dropdown and checks that the expected Platform links are present and have valid href values                                                           | Platform dropdown opens and expected links are present        |
| AUTO-003 | Test Platform Menu Links Navigate Correctly      | Loops through the Platform links listed in the navigation data file, checks each href, clicks each link/button, and verifies navigation to the expected destination      | Each Platform link/button navigates to the expected page      |
| AUTO-004 | Test Solutions Menu                              | Opens the Solutions dropdown and checks that the expected Solutions links are present and have valid href values                                                         | Solutions dropdown opens and expected links are present       |
| AUTO-005 | Test Solutions Menu Links Navigate Correctly     | Loops through the Solutions links listed in the navigation data file, checks each href, clicks each link/button, and verifies navigation to the expected destination     | Each Solutions link/button navigates to the expected page     |
| AUTO-006 | Test Why Darktrace Menu                          | Opens the Why Darktrace dropdown and checks that the expected Why Darktrace links are present and have valid href values                                                 | Why Darktrace dropdown opens and expected links are present   |
| AUTO-007 | Test Why Darktrace Menu Links Navigate Correctly | Loops through the Why Darktrace links listed in the navigation data file, checks each href, clicks each link/button, and verifies navigation to the expected destination | Each Why Darktrace link/button navigates to the expected page |
| AUTO-008 | Test Resources Menu                              | Opens the Resources dropdown and checks that the expected Resources links are present and have valid href values                                                         | Resources dropdown opens and expected links are present       |
| AUTO-009 | Test Resource Menu Links Navigate Correctly      | Loops through the Resources links listed in the navigation data file, checks each href, clicks each link/button, and verifies navigation to the expected destination     | Each Resources link/button navigates to the expected page     |
| AUTO-010 | Test Get A Demo Hyperlink                        | Checks that the Get a Demo topbar button has a valid href, is not a placeholder link, can be clicked, and navigates to the expected demo page                            | Get a Demo button navigates to the demo page                  |
| AUTO-011 | Test Navigation Resources Load Under A Second    | Checks that the main navigation and selected dropdown content are available within one second                                                                            | Required navigation content loads within the expected time    |

### Notes on automated coverage

The automation validates the four main areas requested in the brief:

* **Logo image**: the logo is checked for visibility, correctness, load time, hyperlink validity, and navigation to the homepage.
* **Dropdown menus**: the Platform, Solutions, Why Darktrace, and Resources dropdowns are opened and checked.
* **Hyperlinks**: expected links are checked for non-empty href values and invalid placeholder values such as `#` or `javascript`.
* **Buttons**: navigation buttons and CTA-style links are clicked and checked to confirm that they navigate to the expected destination.

The test suite uses loops for the menu link navigation tests. If one link fails, the test continues checking the remaining links and records the failed item in the Robot Framework report.

