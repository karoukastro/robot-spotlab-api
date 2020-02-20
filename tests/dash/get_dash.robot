*** Settings ***	


Resource    ../../resources/services.robot

*** Test Cases ***
Get my spots on Dashboard
   Set Token       eu@carol.eu
   Save Spot List   ../../../resources/fixtures/my_spots.json

   ${response}     Get My Spots
   ${code}=        Convert To String       ${response.status_code}

    Should Be Equal         ${code}      200
    log                     ${response.text}
    Should Not Be Empty     ${response.json()}



#ctrl + ;