#!/bin/sh

git filter-branch --env-filter '

an="$GIT_AUTHOR_NAME"
am="$GIT_AUTHOR_EMAIL"
cn="$GIT_COMMITTER_NAME"
cm="$GIT_COMMITTER_EMAIL"

if [ "$GIT_COMMITTER_EMAIL" = "旧的邮箱" ]
then
    cn="新的用户名"
    cm="新的邮箱"
fi
if [ "$GIT_AUTHOR_EMAIL" = "旧的邮箱" ]
then
    an="新的用户名"
    am="新的邮箱"
fi

export GIT_AUTHOR_NAME="$an"
export GIT_AUTHOR_EMAIL="$am"
export GIT_COMMITTER_NAME="$cn"
export GIT_COMMITTER_EMAIL="$cm"

' HEAD

