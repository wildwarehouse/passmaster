#!/bin/sh

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
    bash