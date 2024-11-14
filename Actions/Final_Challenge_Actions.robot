*** Settings ***
Documentation    RFW Training - Final Challenge Objects File
...              This file contains the user defined keywords to run the test
Resource         ../Objects/Final_Challenge_Objects_Data.robot
Resource         ../Objects/Final_Challenge_Objects_Locators.robot

*** Keywords ***
Generate Random User Email and Username
    ${USERNAME} =           FakerLibrary.User Name
    ${EMAIL} =              FakerLibrary.Email
    Set Global Variable         ${USERNAME}
    Set Global Variable         ${EMAIL}

Generate Random Costumer Email
    ${COSTUMER_EMAIL} =     FakerLibrary.Email
    Set Global Variable     ${COSTUMER_EMAIL}

Open Browser and Load Site
    Open browser    ${URL}  ${BROWSER}  options=${BROWSER_OPTIONS}
    Wait until page contains element    ${BUTTON_SIGNUP}
    Maximize browser window

Register User
    Generate Random User Email and Username
    # Input text boxes and DOB
    Input Text          ${INPUT_USERNAME_SIGNUP}            ${USERNAME}
    Input Text          ${INPUT_EMAIL}                      ${EMAIL}
    Input password      ${INPUT_PASSWORD_SIGNUP}            ${PASSWORD}
    Input password      ${INPUT_CONFIRM_PASSWORD}           ${PASSWORD}
    Input Text          ${INPUT_DOB}                        ${DOB}
    Press Keys          ${INPUT_DOB}                        ENTER
    Input Text          ${INPUT_PHONE}                      ${PHONE}
    Input Text          ${INPUT_ADDRESS}                    ${ADDRESS}
    Input Text          ${INPUT_ZIP}                        ${ZIP}
    # Select radio buttons, dropdown lists and select checkbox
    Click Element                       ${INPUT_ADDRESS_TYPE}
    Select From List by Label           ${SELECT_GENDER}    ${GENDER}
    Select From List by Label           ${SELECT_COUNTRY}   ${COUNTRY}
    Wait Until Page Contains Element    ${OPTIONS_STATE}
    Select From List by Label           ${SELECT_STATE}     ${STATE}
    Wait Until Page Contains Element    ${OPTIONS_CITY}
    Select From List by Label           ${SELECT_CITY}      ${CITY}
    Select Checkbox     ${CHECKBOX_TERMS}
    # Finish signing up
    Click element       ${BUTTON_SIGNUP}
    Wait until page contains    User is successfully Register. Now You can Login
#    Sleep    10s

Login with Registered User
    Click element                       ${LABEL_LOGIN}
    Page should contain element         ${BUTTON_LOGIN}
    Input Text                          ${INPUT_USERNAME_LOGIN}     ${USERNAME}
    Input password                      ${INPUT_PASSWORD_LOGIN}     ${PASSWORD}
    Select Checkbox                     ${CHECKBOX_LOGIN}
    Click element                       ${BUTTON_LOGIN}
    Wait until page contains element    ${BUTTON_VIEWME}

Click View Me Message
    Click element                       ${BUTTON_VIEWME}
    Wait until element is visible       ${H3_VIEWME}
    Element text should be              ${H3_VIEWME}     Hello. ${USERNAME} !
    Wait until element is not visible   ${H3_VIEWME}    10

Check Report
    Click element                       ${A_MYACCOUNT}
    Click element                       ${A_REPORT}
    Page should contain element         ${DIV_CHART}
    Wait until element contains         ${DIV_CHART}        ${COUNTRY_TO_CHECK}
    ${report_value} =    Get text       ${TSPAN_COUNTRY_TO_CHECK}
    Log    Scraped info -> ${report_value}

Search Database
    Click element                       ${A_MYACCOUNT}
    Click element                       ${A_SEARCH}
    Page should contain element         ${TABLE_SEARCH}
    Input Text                          ${INPUT_SEARCH}             ${SEARCH_VALUE}
    Page should contain                 ${SEARCH_RESULT}
    Clear element text                  ${INPUT_SEARCH}

Add Costumer
    Click element                       ${A_MYACCOUNT}
    Click element                       ${A_ADDCOSTUMER}
    Wait until page contains element    ${BUTTON_ADDCOSTUMER}
    # Generate random costumer email
    Generate Random Costumer Email
    # Input data
    Input Text                          ${INPUT_COSTUMER_FIRST_NAME}          ${COSTUMER_FIRST_NAME}
    Input Text                          ${INPUT_COSTUMER_LAST_NAME}           ${COSTUMER_LAST_NAME}
    Input password                      ${INPUT_COSTUMER_EMAIL}               ${COSTUMER_EMAIL}
    Input password                      ${INPUT_COSTUMER_AGE}                 ${COSTUMER_AGE}
    Select From List by Label           ${SELECT_COSTUMER_COURSE}             ${COSTUMER_COURSE}
    Input Text                          ${INPUT_COSTUMER_CONTACT}             ${COSTUMER_CONTACT}
    Select From List by Label           ${SELECT_COSTUMER_COUNTRY}            ${COSTUMER_COUNTRY}
    Select From List by Label           ${SELECT_COSTUMER_STATE}              ${COSTUMER_STATE}
    Input Text                          ${INPUT_COSTUMER_CITY}                ${COSTUMER_CITY}
    # Select checkboxes and submit
    Click element                       ${BUTTON_CHECKALL}
    Checkbox should be selected         ${CHECKBOX_OPTION1}
    Checkbox should be selected         ${CHECKBOX_OPTION2}
    Checkbox should be selected         ${CHECKBOX_OPTION3}
    Checkbox should be selected         ${CHECKBOX_OPTION4}
    Element attribute value should be   ${BUTTON_CHECKALL}    value    Uncheck All
    Click element                       ${BUTTON_ADDCOSTUMER}
    Wait until page contains element    ${MSG_CUSTOMER_ADDED}
    # Check if costumer was really added
    Wait until page does not contain element    ${MSG_CUSTOMER_ADDED}   10s

Manage Costumer
    Click element                               ${A_MYACCOUNT}
    Click element                               ${A_MANAGE_COSTUMER}
    Page should contain element                 ${TABLE_COSTUMERS}
    Page should contain                         ${COSTUMER_EMAIL}

Delete Costumer
    Click element                       ${A_MYACCOUNT}
    Click element                       ${A_DELETE_COSTUMER}
    # Change to right tab
    @{window_handles} =    Get window handles
    Switch window                       ${window_handles}[1]
    Wait until page contains element    ${TABLE_COSTUMERS}
    # Define correct locator for "Delete" button
    Set global variable    ${BUTTON_DELETE_COSTUMER}  //td[text()="${COSTUMER_EMAIL}"]/following-sibling::td/following-sibling::td/following-sibling::td[@class="menu-action"]/a[@id="remove"]
    # Delete costumer
    Page should contain                 ${COSTUMER_EMAIL}
    Wait until element is visible       ${BUTTON_DELETE_COSTUMER}    10s
    Click element                       ${BUTTON_DELETE_COSTUMER}
    Handle Alert    accept
    Wait until page contains element    ${MSG_CUSTOMER_DELETED}
    # Check if costumer was really deleted
    Wait until page does not contain element        ${MSG_CUSTOMER_DELETED}    10s
    Wait until page contains element                ${TABLE_COSTUMERS}
    Page should not contain                         ${COSTUMER_EMAIL}
    # Close current tab
    Close window
    Switch window                       ${window_handles}[0]

Logout
    Click element                       ${A_LOGOUT}
    Wait until page contains element    ${BUTTON_SIGNUP}
    Close all browsers


