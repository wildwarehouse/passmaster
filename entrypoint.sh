#!/bin/sh
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

gpg --batch --import /srv/secret1.key &&
    gpg --batch --import-ownertrust /srv/owner1.trust &&
    gpg2 --batch --import /srv/secret2.key &&
    gpg2 --batch --import-ownertrust /srv/owner2.trust &&
    pass init ${GPG_KEY_ID} &&
    pass git init &&
    pass git config user.name "${GIT_USER_NAME}" &&
    pass git config user.email "${GIT_USER_EMAIL}" &&
    pass git remote add origin git@github.com:desertedscorpion/passwordstore.git &&
    ssh-keygen -f /root/.ssh/id_rsa -P "" -C "" &&
    (cat <<EOF
{
    "title": "generated",
    "key": "$(cat /root/.ssh/id_rsa.pub)"
}
EOF
    ) | curl --data @- "https://api.github.com/user/keys?access_token=${GPG_PRIVATE_TOKEN}" &&
    cp /opt/docker/config /root/.ssh &&
    chmod 0600 /root/.ssh/config &&
    cp /opt/docker/known_hosts /root/.ssh &&
    chmod 0600 /root/.ssh/known_hosts &&
    pass git fetch origin master &&
    pass git checkout master &&
    cp /opt/docker/post-commit.sh ${HOME}/.password-store/.git/hooks/post-commit &&
    chmod 0500 ${HOME}/.password-store/.git/hooks/post-commit &&
    bash