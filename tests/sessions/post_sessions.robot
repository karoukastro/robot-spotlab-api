*** Settings ***
Resource        ../../resources/services.robot

*** Test Cases ***
New Session
    [tags]              smoke
    &{payload}=         Create Dictionary         email=carol@carol.ahh
   
    ${response}=        Post Session              ${payload}
    ${code}=            Convert To String         ${response.status_code}
    Should Be Equal     ${code}                   200

Wrong email
    Create Session      spotapi     http://spotlab-api.herokuapp.com

    &{headers}=         Create Dictionary   Content-Type=application/json
    &{payload}=         Create Dictionary   email=carol&carol.ahh
   
    ${response}=        Post Request              spotapi     /sessions   data=${payload}     headers=${headers}
    ${code}=            Convert To String         ${response.status_code}
    Should Be Equal     ${code}                   409


Empty email
    Create Session      spotapi     http://spotlab-api.herokuapp.com

    &{headers}=         Create Dictionary   Content-Type=application/json
    &{payload}=         Create Dictionary   email=${EMPTY}
   
    ${response}=        Post Request              spotapi     /sessions   data=${payload}     headers=${headers}
    ${code}=            Convert To String         ${response.status_code}
    Should Be Equal     ${code}                   412

Without Data
    Create Session      spotapi     http://spotlab-api.herokuapp.com

    &{headers}=         Create Dictionary   Content-Type=application/json
   
    ${response}=        Post Request              spotapi     /sessions   headers=${headers}
    ${code}=            Convert To String         ${response.status_code}
    Should Be Equal     ${code}                   412



