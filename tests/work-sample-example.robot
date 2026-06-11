*** Settings ***
Documentation     A test suite to test the main navigation bar of https://darktrace.com
...

Library           SeleniumLibrary
Library           RequestsLibrary
Test Teardown      Teardown Actions

*** Variables ***
${browser}        headlessfirefox
${website_url}        https://darktrace.com/
${logo_url}      https://assets-global.website-files.com/626ff19cdd07d1258d49238d/62c4e24dc156cb0b0f553f00_Darktrace%20Logo%20W%3AO%20-%20Vector.svg

*** Keywords ***
Prepare test
    Open Browser    ${website_url}  ${browser}       # remote_url=http://firefox:4444
    Wait Until Keyword Succeeds  3x  2s  Click Button    id:onetrust-accept-btn-handler

Teardown Actions
    Close All Browsers

*** Test Cases ***
Test Logo
    Prepare test
    Wait Until Element Is Visible        //img[@src="${logo_url}"]
    Click Element    //a/img[@src="${logo_url}"]
    Wait Until Location Is    ${website_url}
