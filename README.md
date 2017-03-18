<!--
# Copyright © (C) 2017 Emory Merryman <emory.merryman@deciphernow.com>
#   This file is part of passmaster.
#
#   passmaster is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   passmaster is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with passmaster.  If not, see <http://www.gnu.org/licenses/>.
-->

# passmaster

## Usage

```
export GPG_KEY_VOLUME &&
    export GPG_KEY_ID &&
    export GIT_USER_NAME &&
    export GIT_USER_EMAIL &&
    export GPG_PRIVATE_TOKEN &&
    docker \
        run \
        --interactive \
        --tty \
        --rm \
        --volume ${GPG_KEY_VOLUME}:/srv:ro \
        --env GPG_KEY_ID \
        --env GIT_USER_NAME \
        --env GIT_USER_EMAIL \
        --env GPG_PRIVATE_TOKEN \
        wildwarehouse/passmaster:0.0.0
```

where

1. GPG_KEY_VOLUME is a docker volume with the following files:  secret1.key, secret2.key, owner1.trust, and owner2.trust.
   1. secret1.key is the result of `gpg --export-secret-keys --output secret1.key`
   2. secret2.key is the result of `gpg2 --export-secret-keys --output secret2.key`
   3. owner1.trust is the result of `gpg --export-ownertrust -output owner1.trust`
   4. owner2.trust is the result of `gpg2 --export-ownertrust ---output owner2.trust`
   5. it is believe that owner1.trust is the same as owner2.trust
2. GPG_KEY_ID is the result of `gpg --list-keys`
3. GIT_USER_NAME is just your name / or whatever you want to use for git.
4. GIT_USER_EMAIL is just your email / or whatever you want to use for git.
5. GPG_PRIVATE_TOKEN should be github private token.
   1. Login in to github.
   2. Visit https://github.com/settings/tokens
   3. Generate a new token.  Be sure it has enough privileges.  (I just grant them all.)
   4. Copy the token.  If you forget the token you must regenerate it.
