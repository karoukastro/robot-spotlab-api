*** Settings ***	
Resource    ../../resources/services.robot

*** Test Cases ***
Delete Spot
    Set Token       carol@carol.eu

    &{my_spot}=     Create Dictionary   company=Carol Company   techs=java  price=30  user=${token}

    ${spot_id}=         Insert Unique Spot        ${my_spot}
    ${response}=        Delete Spot By Id         ${spot_id}
    ${code}             Convert To String         ${response.status_code}
    
    Should Be Equal     ${code}         204

    ${response}=        Get Spot By Id          ${spot_id}
    ${code}             Convert To String       ${response.status_code}
    
    Should Be Equal     ${code}         404



