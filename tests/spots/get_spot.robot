*** Settings ***	
Resource    ../../resources/services.robot

*** Test Cases ***
Get Unique Spot
   Set Token       carol@carol.eu

    &{my_spot}=     Create Dictionary   company=Marvel Unique   techs=java  price=15 user=${token}

    ${spot_id}=         Insert Unique Spot      ${my_spot}
    ${response}=        Get Spot By Id          ${spot_id}
    ${code}             Convert To String       ${response.status_code}
    
    Should Be Equal     ${code}         200
    Dictionary Should Contain Value     ${response.json()}      ${my_spot.company}

Spot Not Found
    ${spot_id}=         Get Mongo Id
    ${response}=        Get Spot By Id          ${spot_id}
    ${code}             Convert To String       ${response.status_code}
    
    Should Be Equal     ${code}         404

Filter Spots
    Set Token       carol@carol.eu
    
    Hard Reset         ${token} 
    Save Spot List      filter.json
    ${response}=        Get Spot By Filter      lua
    ${code}             Convert To String       ${response.status_code}
    
    Should Be Equal         ${code}         200
    Should Not Be Empty     ${response.json()}
    Dictionary Should Contain Item      ${response.json()[0]}      company     Acme X
    Dictionary Should Contain Item      ${response.json()[1]}      company     Yahoo X

    ${total}                Get Length           ${response.json()}
    ${total}=               Convert To String    ${total}
    Should Be Equal         ${total}             2

#ctrl + ;