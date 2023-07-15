#! /bin/bash
 # 查看当前分支的注释信息
typeset curr_branch=`git rev-parse --abbrev-ref HEAD`
typeset curr_desc=`git config branch."$curr_branch".description`
 
show_desc(){
	echo "$curr_branch ------> $curr_desc"
}
 
typeset all_branches=$(git for-each-ref --format='%(refname)' refs/heads/ | sed 's|refs/heads/||')
 
show_descs(){
	for curr_branch in $all_branches
	do
		typeset curr_desc=`git config branch."$curr_branch".description`
		echo "$curr_branch ------> $curr_desc"
	done
} 
 
show_descs