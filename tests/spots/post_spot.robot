*** Settings ***	
Library     OperatingSystem

Resource    ../../resources/services.robot

Suite Setup     Set Token  carol@karol.ahh  
#Suite Teardown Delete Session 

*** Test Cases ***
Create a new Spot
    [tags]                  smoke
    &{payload}=             Create Dictionary   company=Google  techs=java, golang  price=50
    Remove Spot By Company  ${payload['company']}

    ${response}=        Save Spot               ${payload}     google.jpg
    ${code}=            Convert To String       ${response.status_code}

    Should Be Equal     ${code}      200

Empty Company

    &{payload}=         Create Dictionary   company=${EMPTY}  techs=java, golang  price=50
    ${response}=        Save Spot               ${payload}    google.jpg
    ${code}=            Convert To String       ${response.status_code}

    Should Be Equal     ${code}      412

    ${business_code}=                   Convert To Integer  1001
    Should Be Equal                     ${response.json()['code']}  ${business_code}
    Dictionary Should Contain Value     ${response.json()}  ${business_code}
    Dictionary Should Contain Value     ${response.json()}  Company is required

Empty Technologies

    &{payload}=         Create Dictionary       company=Acme  techs=${EMPTY}  price=50
    ${response}=        Save Spot               ${payload}    acme.jpg
    ${code}=            Convert To String       ${response.status_code}

    Should Be Equal     ${code}      412

    ${business_code}=                   Convert To Integer  1002
    Should Be Equal                     ${response.json()['code']}  ${business_code}
    Dictionary Should Contain Value     ${response.json()}  ${business_code}
    Dictionary Should Contain Value     ${response.json()}  Technologies is required

Empty Thumbnail

    &{payload}=         Create Dictionary               company=Yahoo  techs=java  price=80
    ${response}=        Save Spot without image         ${payload}
    ${code}=            Convert To String               ${response.status_code}

    Should Be Equal     ${code}      412

    Dictionary Should Contain Value     ${response.json()}  Incorrect Spot data :(

