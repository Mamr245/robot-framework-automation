*** Settings ***
Documentation    RFW Training - Final Challenge Objects File.
...              This file contains the data variables needed to run the test
...              and perform the necessary assertions.
Library          SeleniumLibrary
Library          FakerLibrary

*** Variables ***
### Browser Settings ###
${BROWSER} =                chrome
&{BROWSER_PREFS} =          autofill.profile_enabled=${False}       credentials_enable_service=${False}     profile.password_manager_enabled=${False}
${BROWSER_OPTIONS} =        add_experimental_option('excludeSwitches', ['enable-logging','enable-automation']);add_experimental_option("detach", True); add_experimental_option("prefs", ${BROWSER_PREFS})

### Data to use in the test ###
${ADDRESS} =                Rua Oliveira Martins 9
${ADDRESS_TYPE} =           office
${CITY} =                   Fundao
${COSTUMER_AGE} =           45
${COSTUMER_CITY} =          Austin
${COSTUMER_CONTACT} =       (202)555-0165
${COSTUMER_COUNTRY} =       United States of America
${COSTUMER_COURSE} =        Ruby
#${COSTUMER_EMAIL} =         jc@wwe.com
${COSTUMER_FIRST_NAME} =    John
${COSTUMER_LAST_NAME} =     Cena
${COSTUMER_STATE} =         Texas
${COUNTRY} =                Portugal
${COUNTRY_TO_CHECK} =       Lithuania
${DOB} =                    9/15/1994
#${EMAIL} =                  some_email17@gmail.com
${GENDER} =                 Male
# ${H3_VIEWME_TEXT} =         Hello. ${USERNAME} !
${PASSWORD} =               abc123!
${PHONE} =                  987123456
${STATE} =                  Centro
${SEARCH_VALUE} =           433,060
${SEARCH_RESULT} =          Cedric Kelly
${URL} =                    https://thetestingworld.com/testings/
#${USERNAME} =               SomeName17
${ZIP} =                    2700-512












