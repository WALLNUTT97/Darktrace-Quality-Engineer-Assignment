*** Settings ***
Documentation       Darktrace desktop top navigation tests.
...                 This suite intentionally uses simple Robot Framework + SeleniumLibrary keywords.
...                 The goal is readability and maintainability rather than building a complex framework.
Library             SeleniumLibrary
Suite Setup         Open Darktrace Homepage
Suite Teardown      Close Browser
Test Teardown       Capture Page Screenshot


*** Variables ***
${BASE_URL}         https://www.darktrace.com
${BROWSER}          Chrome
${TIMEOUT}          10s
${FAST_TIMEOUT}     1s


*** Test Cases ***
Logo And Platform Navigation
    [Documentation]    Checks the logo and Platform item from the desktop navigation bar.
    Logo Should Be Visible
    Logo Should Link To Homepage
    Platform Should Be Visible
    Platform Should Open Platform Page

Products Hover Menu
    [Documentation]    Checks Products hover behaviour and required product links.
    Products Should Be Visible
    Hover Over Products
    Products Menu Should Contain Required Links

Our AI Hover Menu
    [Documentation]    Checks Our AI hover behaviour and destination.
    Our AI Should Be Visible
    Hover Over Our AI
    Our AI Menu Should Contain Link To Our AI Page

Resources Hover Menu
    [Documentation]    Checks Resources hover behaviour and required resource links.
    Resources Should Be Visible
    Hover Over Resources
    Resources Menu Should Contain Required Links

Get A Demo Form
    [Documentation]    Checks Get a Demo navigation and required form controls.
    Get A Demo Button Should Be Visible
    Click Get A Demo Button
    Demo Form Should Contain Required Fields
    Demo Form Should Contain Required Dropdowns
    Demo Form Should Contain Required Controls

Navigation Resources Load Quickly
    [Documentation]    Basic check for the requirement that resources load under one second.
    Go To    ${BASE_URL}
    Wait Until Page Contains Element    xpath=//a[contains(normalize-space(.), "Products")]    ${FAST_TIMEOUT}
    Mouse Over    xpath=//a[contains(normalize-space(.), "Products")]
    Wait Until Page Contains Element    xpath=//a[contains(normalize-space(.), "Attack Surface Management")]    ${FAST_TIMEOUT}
    Mouse Over    xpath=//a[contains(normalize-space(.), "Resources")]
    Wait Until Page Contains Element    xpath=//a[contains(normalize-space(.), "Blog")]    ${FAST_TIMEOUT}


*** Keywords ***
Open Darktrace Homepage
    Open Browser    ${BASE_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Timeout    ${TIMEOUT}
    Accept Cookies If Present
    Wait Until Page Contains Element    xpath=//header | //nav    ${TIMEOUT}

Accept Cookies If Present
    ${cookie_button_found}=    Run Keyword And Return Status
    ...    Page Should Contain Element
    ...    xpath=//button[contains(translate(normalize-space(.), "ABCDEFGHIJKLMNOPQRSTUVWXYZ", "abcdefghijklmnopqrstuvwxyz"), "accept")]
    IF    ${cookie_button_found}
        Click Button    xpath=//button[contains(translate(normalize-space(.), "ABCDEFGHIJKLMNOPQRSTUVWXYZ", "abcdefghijklmnopqrstuvwxyz"), "accept")]
    END

Logo Should Be Visible
    Wait Until Page Contains Element    xpath=//a[contains(@href, "darktrace.com") or @href="/"]    ${FAST_TIMEOUT}

Logo Should Link To Homepage
    Click Element    xpath=(//a[contains(@href, "darktrace.com") or @href="/"])[1]
    Location Should Contain    darktrace.com

Platform Should Be Visible
    Wait Until Page Contains Element    xpath=//a[contains(normalize-space(.), "Platform")]    ${FAST_TIMEOUT}

Platform Should Open Platform Page
    Click Element    xpath=//a[contains(normalize-space(.), "Platform")]
    Location Should Contain    platform

Products Should Be Visible
    Wait Until Page Contains Element    xpath=//a[contains(normalize-space(.), "Products")]    ${FAST_TIMEOUT}

Hover Over Products
    Mouse Over    xpath=//a[contains(normalize-space(.), "Products")]

Products Menu Should Contain Required Links
    Link Should Be Visible And Valid    Network
    Link Should Be Visible And Valid    Cloud
    Link Should Be Visible And Valid    Identity
    Link Should Be Visible And Valid    Email
    Link Should Be Visible And Valid    OT
    Link Should Be Visible And Valid    Endpoint
    Link Should Be Visible And Valid    Proactive Exposure Management
    Link Should Be Visible And Valid    Attack Surface Management
    Link Should Be Visible And Valid    Incident Readiness
    Link Should Be Visible And Valid    Cyber AI Analyst
    Link Should Be Visible And Valid    Services

Our AI Should Be Visible
    Wait Until Page Contains Element    xpath=//a[contains(normalize-space(.), "Our AI")]    ${FAST_TIMEOUT}

Hover Over Our AI
    Mouse Over    xpath=//a[contains(normalize-space(.), "Our AI")]

Our AI Menu Should Contain Link To Our AI Page
    Link Should Be Visible And Valid    Our AI

Resources Should Be Visible
    Wait Until Page Contains Element    xpath=//a[contains(normalize-space(.), "Resources")]    ${FAST_TIMEOUT}

Hover Over Resources
    Mouse Over    xpath=//a[contains(normalize-space(.), "Resources")]

Resources Menu Should Contain Required Links
    Link Should Be Visible And Valid    Customers
    Link Should Be Visible And Valid    Events
    Link Should Be Visible And Valid    The Inference
    Link Should Be Visible And Valid    Blog
    Link Should Be Visible And Valid    Inside the SOC
    Link Should Be Visible And Valid    Glossary
    Link Should Be Visible And Valid    All resources
    Link Should Be Visible And Valid    white paper

Get A Demo Button Should Be Visible
    Wait Until Page Contains Element    xpath=//a[contains(translate(normalize-space(.), "ABCDEFGHIJKLMNOPQRSTUVWXYZ", "abcdefghijklmnopqrstuvwxyz"), "get a demo")]    ${FAST_TIMEOUT}

Click Get A Demo Button
    Click Element    xpath=//a[contains(translate(normalize-space(.), "ABCDEFGHIJKLMNOPQRSTUVWXYZ", "abcdefghijklmnopqrstuvwxyz"), "get a demo")]
    Wait Until Location Contains    demo    ${TIMEOUT}

Demo Form Should Contain Required Fields
    Page Should Contain    Name
    Page Should Contain    Email
    Page Should Contain    Organization
    Page Should Contain    Job Title
    Page Should Contain    Phone Number

Demo Form Should Contain Required Dropdowns
    Page Should Contain    Country
    Page Should Contain    Organization Size

Demo Form Should Contain Required Controls
    Page Should Contain Element    xpath=//input[@type="checkbox"]
    Page Should Contain Element    xpath=//*[contains(translate(@class, "ABCDEFGHIJKLMNOPQRSTUVWXYZ", "abcdefghijklmnopqrstuvwxyz"), "captcha") or contains(translate(@src, "ABCDEFGHIJKLMNOPQRSTUVWXYZ", "abcdefghijklmnopqrstuvwxyz"), "captcha") or contains(translate(@title, "ABCDEFGHIJKLMNOPQRSTUVWXYZ", "abcdefghijklmnopqrstuvwxyz"), "captcha")]
    Page Should Contain Element    xpath=//button[contains(translate(normalize-space(.), "ABCDEFGHIJKLMNOPQRSTUVWXYZ", "abcdefghijklmnopqrstuvwxyz"), "get a demo")] | //input[contains(translate(@value, "ABCDEFGHIJKLMNOPQRSTUVWXYZ", "abcdefghijklmnopqrstuvwxyz"), "get a demo")]

Link Should Be Visible And Valid
    [Arguments]    ${link_text}
    Wait Until Page Contains Element    xpath=//a[contains(translate(normalize-space(.), "ABCDEFGHIJKLMNOPQRSTUVWXYZ", "abcdefghijklmnopqrstuvwxyz"), "${link_text.lower()}")]    ${TIMEOUT}
    ${href}=    Get Element Attribute    xpath=//a[contains(translate(normalize-space(.), "ABCDEFGHIJKLMNOPQRSTUVWXYZ", "abcdefghijklmnopqrstuvwxyz"), "${link_text.lower()}")]    href
    Should Not Be Empty    ${href}
    Should Not Be Equal    ${href}    #
    Should Not Contain    ${href}    javascript
