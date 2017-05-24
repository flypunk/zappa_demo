#!/bin/bash

# Run `zappa update` and ensure that domain specified in its configuration
# returns non-error response

zappa update

domain=`cat zappa_settings.yml | grep domain | cut -d: -f2 | tr -d ' '`
url=https://${domain}

if ! curl -sfo /dev/null $url;
    then echo "Failed getting response from server $url after deployment!"
fi
