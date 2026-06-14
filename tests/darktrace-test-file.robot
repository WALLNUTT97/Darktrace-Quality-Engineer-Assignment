*** Settings ***
Documentation       A test suite to test the current live top navigation bar of https://darktrace.com
...
...                 This suite follows the current live website structure, following clarification
...                 that the live navigation should be tested flexibly against the original brief.
...
...                 The site contains duplicate hidden/mobile navigation elements, so the locators
...                 avoid elements with mobile classes where possible.

Library             SeleniumLibrary
Resource            ../resources/navigation_links.resource

Test Teardown       Teardown Actions


*** Variables ***
${browser}                  headlessfirefox
${website_url}              https://darktrace.com/

${platform_text}            Platform
${solutions_text}           Solutions
${why_darktrace_text}       Why Darktrace
${resources_text}           Resources
${demo_text}                Get a demo

${fast_timeout}             1s
${default_timeout}          10s

*** Keywords ***
Prepare Test
    Open Browser    ${website_url}    ${browser}       # remote_url=http://firefox:4444
    Set Selenium Timeout    ${default_timeout}
    Set Window Size    1440    1000
    Accept Cookies If Present
    Wait Until Page Contains    ${platform_text}    ${default_timeout}

Accept Cookies If Present
    Run Keyword And Ignore Error
    ...    Click Element
    ...    xpath=//button[contains(normalize-space(.), "Accept Cookies") or contains(normalize-space(.), "Accept All Cookies") or contains(normalize-space(.), "Accept")]

Teardown Actions
    Run Keyword If Test Failed    Capture Page Screenshot
    Close All Browsers

Visible Topbar Text Should Exist
    [Arguments]    ${menu_text}
    Wait Until Element Is Visible
    ...    xpath=(//*[self::a or self::div or self::span][normalize-space(.)="${menu_text}" and not(ancestor-or-self::*[contains(@class, "mobile")])])[1]
    ...    ${default_timeout}

Hover Over Topbar Menu
    [Arguments]    ${menu_text}
    Visible Topbar Text Should Exist    ${menu_text}
    Mouse Over
    ...    xpath=(//*[self::a or self::div or self::span][normalize-space(.)="${menu_text}" and not(ancestor-or-self::*[contains(@class, "mobile")])])[1]
    Sleep    1s

Link Containing Text Should Exist And Have Href
    [Arguments]    ${link_text_lowercase}
    Page Should Contain Element
    ...    xpath=//a[contains(translate(normalize-space(.), "ABCDEFGHIJKLMNOPQRSTUVWXYZ", "abcdefghijklmnopqrstuvwxyz"), "${link_text_lowercase}")]
    ${href}=    Get Element Attribute
    ...    xpath=(//a[contains(translate(normalize-space(.), "ABCDEFGHIJKLMNOPQRSTUVWXYZ", "abcdefghijklmnopqrstuvwxyz"), "${link_text_lowercase}")])[1]
    ...    href
    Should Not Be Empty    ${href}
    Should Not Be Equal As Strings    ${href}    \#
    Should Not Contain    ${href}    javascript

Menu Should Contain Links
    [Arguments]    @{expected_links}
    FOR    ${link_text}    IN    @{expected_links}
        Link Containing Text Should Exist And Have Href    ${link_text}
    END

Logo Image Should Load Under One Second
    Wait Until Element Is Visible
    ...    xpath=(//*[name()="svg" and contains(@class, "logo-svg") and not(ancestor-or-self::*[contains(@class, "mobile")])])[1]
    ...    ${fast_timeout}


Logo Image Should Be Correct
    Page Should Contain Element
    ...    xpath=(//*[name()="svg" and contains(@class, "logo-svg") and not(ancestor-or-self::*[contains(@class, "mobile")])])[1]


Logo Hyperlink Should Be Valid
    ${href}=    Get Element Attribute
    ...    xpath=(//*[name()="svg" and contains(@class, "logo-svg") and not(ancestor-or-self::*[contains(@class, "mobile")])]/ancestor::a)[1]
    ...    href

    Should Not Be Empty    ${href}
    Should Not Be Equal As Strings    ${href}    \#
    Should Not Contain    ${href}    javascript
    Should Contain    ${href}    darktrace.com


Logo Should Navigate To Homepage
    ${logo_link}=    Get WebElement
    ...    xpath=(//*[name()="svg" and contains(@class, "logo-svg") and not(ancestor-or-self::*[contains(@class, "mobile")])]/ancestor::a)[1]

    Execute Javascript    arguments[0].click();    ARGUMENTS    ${logo_link}

    Wait Until Location Contains    darktrace.com    ${default_timeout}

Menu Link Should Have Correct Href And Navigate
    [Arguments]    ${menu_text}    ${link_text_lowercase}    ${expected_url_part}

    Go To    ${website_url}
    Accept Cookies If Present
    Wait Until Page Contains    ${menu_text}    ${default_timeout}

    Hover Over Topbar Menu    ${menu_text}

    ${link_locator}=    Set Variable
    ...    xpath=(//a[contains(@href, "${expected_url_part}") and not(ancestor-or-self::*[contains(@class, "mobile")])])[1]

    Page Should Contain Element    ${link_locator}

    ${href}=    Get Element Attribute    ${link_locator}    href

    Should Not Be Empty    ${href}
    Should Not Be Equal As Strings    ${href}    \#
    Should Not Contain    ${href}    javascript
    Should Contain    ${href}    ${expected_url_part}

    ${element}=    Get WebElement    ${link_locator}
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${element}

    Wait Until Location Contains    ${expected_url_part}    ${default_timeout}

Topbar Link Should Have Correct Href And Navigate
    [Arguments]    ${link_text_lowercase}    ${expected_url_part}

    ${link_locator}=    Set Variable
    ...    xpath=(//a[contains(translate(normalize-space(.), "ABCDEFGHIJKLMNOPQRSTUVWXYZ", "abcdefghijklmnopqrstuvwxyz"), "${link_text_lowercase}") and not(ancestor-or-self::*[contains(@class, "mobile")])])[1]

    Page Should Contain Element    ${link_locator}

    ${href}=    Get Element Attribute    ${link_locator}    href

    Should Not Be Empty    ${href}
    Should Not Be Equal As Strings    ${href}    \#
    Should Not Contain    ${href}    javascript
    Should Contain    ${href}    ${expected_url_part}

    ${element}=    Get WebElement    ${link_locator}
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${element}

    Wait Until Location Contains    ${expected_url_part}    ${default_timeout}

*** Test Cases ***
Test Logo Image And Homepage Link
    Prepare Test

    Logo Image Should Load Under One Second
    Logo Image Should Be Correct
    Logo Hyperlink Should Be Valid
    Logo Should Navigate To Homepage


Test Platform Menu
    Prepare Test

    Hover Over Topbar Menu    ${platform_text}
    Menu Should Contain Links    @{platform_links}


Test Platform Menu Links Navigate Correctly
    Prepare Test

    FOR    ${link_text}    ${expected_url_part}    IN    &{platform_links}
        Log    Testing Platform link: ${link_text} -> ${expected_url_part}
        Run Keyword And Continue On Failure
        ...    Menu Link Should Have Correct Href And Navigate
        ...    ${platform_text}
        ...    ${link_text}
        ...    ${expected_url_part}
    END


Test Solutions Menu
    Prepare Test

    Hover Over Topbar Menu    ${solutions_text}
    Menu Should Contain Links    @{solutions_links}


Test Solutions Menu Links Navigate Correctly
    Prepare Test

    FOR    ${link_text}    ${expected_url_part}    IN    &{solutions_links}
        Log    Testing Solutions link: ${link_text} -> ${expected_url_part}
        Run Keyword And Continue On Failure
        ...    Menu Link Should Have Correct Href And Navigate
        ...    ${solutions_text}
        ...    ${link_text}
        ...    ${expected_url_part}
    END


Test Why Darktrace Menu
    Prepare Test

    Hover Over Topbar Menu    ${why_darktrace_text}
    Menu Should Contain Links    @{why_darktrace_links}


Test Why Darktrace Menu Links Navigate Correctly
    Prepare Test

    FOR    ${link_text}    ${expected_url_part}    IN    &{why_darktrace_links}
        Log    Testing Why Darktrace link: ${link_text} -> ${expected_url_part}
        Run Keyword And Continue On Failure
        ...    Menu Link Should Have Correct Href And Navigate
        ...    ${why_darktrace_text}
        ...    ${link_text}
        ...    ${expected_url_part}
    END


Test Resources Menu
    Prepare Test

    Hover Over Topbar Menu    ${resources_text}
    Menu Should Contain Links    @{resources_links}


Test Resources Menu Links Navigate Correctly
    Prepare Test

    FOR    ${link_text}    ${expected_url_part}    IN    &{resources_links}
        Log    Testing Resource link: ${link_text} -> ${expected_url_part}
        Run Keyword And Continue On Failure
        ...    Menu Link Should Have Correct Href And Navigate
        ...    ${resources_text}
        ...    ${link_text}
        ...    ${expected_url_part}
    END


Test Get A Demo Hyperlink
    Prepare Test

    Topbar Link Should Have Correct Href And Navigate    get a demo    /demo


Test Navigation Resources Load Under A Second
    Prepare Test

    Wait Until Page Contains    ${platform_text}    ${fast_timeout}

    Hover Over Topbar Menu    ${platform_text}
    Wait Until Page Contains Element
    ...    xpath=//a[contains(translate(normalize-space(.), "ABCDEFGHIJKLMNOPQRSTUVWXYZ", "abcdefghijklmnopqrstuvwxyz"), "attack surface management")]
    ...    ${fast_timeout}

    Hover Over Topbar Menu    ${resources_text}
    Wait Until Page Contains Element
    ...    xpath=//a[contains(translate(normalize-space(.), "ABCDEFGHIJKLMNOPQRSTUVWXYZ", "abcdefghijklmnopqrstuvwxyz"), "darktrace blog")]
    ...    ${fast_timeout}
