*** Settings ***
Documentation       A test suite to test the current live top navigation bar of https://darktrace.com
...
...                 This suite follows the current live website structure, following clarification
...                 that the live navigation should be tested flexibly against the original brief.
...
...                 The site contains duplicate hidden/mobile navigation elements, so the locators
...                 avoid elements with mobile classes where possible.

Library             SeleniumLibrary
Library             RequestsLibrary

Test Teardown       Teardown Actions


*** Variables ***
${browser}                  headlessfirefox
${website_url}              https://darktrace.com/
${demo_url}                 https://www.darktrace.com/demo

${platform_text}            Platform
${solutions_text}           Solutions
${why_darktrace_text}       Why Darktrace
${partners_text}            Partners
${resources_text}           Resources
${demo_text}                Get a demo

${fast_timeout}             1s
${default_timeout}          10s

@{platform_links}           activeai security platform
...                         network
...                         email
...                         cloud
...                         secure ai
...                         ot
...                         identity
...                         endpoint
...                         proactive exposure management
...                         adaptive human defense
...                         attack surface management
...                         forensic acquisition
...                         incident readiness
...                         cyber ai analyst
...                         services
...                         integrations

@{solutions_links}          ransomware
...                         apts
...                         phishing
...                         data loss
...                         account takeover
...                         insider threats
...                         supply chain attacks
...                         business email compromise
...                         customer stories
...                         inside the soc

@{why_darktrace_links}      our ai
...                         our customers
...                         industry recognition
...                         about us
...                         events
...                         news
...                         leadership
...                         careers
...                         contact us
...                         federal
...                         trust center

@{partners_links}           overview
...                         technology partners
...                         partner portal
...                         microsoft
...                         aws

@{resources_links}          darktrace blog
...                         inside the soc
...                         the inference
...                         resource library
...                         customer stories
...                         cyber ai glossary
...                         securing ai


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

Logo Should Be Visible
    Wait Until Element Is Visible
    ...    xpath=(//*[name()="svg" and contains(@class, "logo-svg") and not(ancestor-or-self::*[contains(@class, "mobile")])])[1]
    ...    ${default_timeout}

Logo Should Link To Homepage
    Click Element
    ...    xpath=(//*[name()="svg" and contains(@class, "logo-svg") and not(ancestor-or-self::*[contains(@class, "mobile")])]/ancestor::a)[1]
    Wait Until Location Contains    darktrace.com    ${default_timeout}

Get A Demo Should Be Visible And Valid
    Visible Topbar Text Should Exist    ${demo_text}
    Link Containing Text Should Exist And Have Href    get a demo


*** Test Cases ***
Test Logo And Get A Demo
    Prepare Test

    Logo Should Be Visible
    Logo Should Link To Homepage

    Get A Demo Should Be Visible And Valid
    Go To    ${demo_url}
    Wait Until Page Contains    Get a demo    ${default_timeout}


Test Platform Menu
    Prepare Test

    Hover Over Topbar Menu    ${platform_text}
    Menu Should Contain Links    @{platform_links}


Test Solutions Menu
    Prepare Test

    Hover Over Topbar Menu    ${solutions_text}
    Menu Should Contain Links    @{solutions_links}


Test Why Darktrace Menu
    Prepare Test

    Hover Over Topbar Menu    ${why_darktrace_text}
    Menu Should Contain Links    @{why_darktrace_links}


Test Partners Menu
    Prepare Test

    Hover Over Topbar Menu    ${partners_text}
    Menu Should Contain Links    @{partners_links}


Test Resources Menu
    Prepare Test

    Hover Over Topbar Menu    ${resources_text}
    Menu Should Contain Links    @{resources_links}


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
