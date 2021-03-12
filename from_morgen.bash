#! /bin/bash
# Helpers courtesy of Morgen Peschke

function _auth.mint-token.raw () {
    local email="${1:-livongo.test+admin@gmail.com}"
    cd ~/development/memberportal-api-automation
    sbt -DuseJwtMinter=true \
        "testhelperscoreapis/runMain com.livongo.api.abstraction.AdminAuthApi $email"
}
function _auth.mint-token.extract () {
    _auth.mint-token.raw "$@" |
        \tee >(cat 1>&2)  |
        \grep -F 'Token for' |
        cut -d= -f2 |
        tr -d ' \n'
}
function auth.mint-token () (
    _auth.mint-token.raw "$@"
)
function auth.mint-token.copy-to-env () {
    LIVONGO_ADMIN_AUTH_TOKEN=$(_auth.mint-token.extract "$@")
    export LIVONGO_ADMIN_AUTH_TOKEN
    echo 1>&2 'Token copied to LIVONGO_ADMIN_AUTH_TOKEN'
}
function auth.mint-token.copy-to-clipboard () {
    _auth.mint-token.extract "$@" | pbcopy
    echo 1>&2 'Token copied to clipboard'
}
function auth.mint-token.load-from-clipboard-to-env () {
    LIVONGO_ADMIN_AUTH_TOKEN=$(pbpaste)
    export LIVONGO_ADMIN_AUTH_TOKEN
    echo 1>&2 'Token copied to LIVONGO_ADMIN_AUTH_TOKEN'
}
function auth.mint-token.load-from-env-to-clipboard () {
    pbcopy <<< "$LIVONGO_ADMIN_AUTH_TOKEN"
    echo 1>&2 'Token copied to clipboard'
}
