#! /bin/bash
 
 # 为分支添加注释信息
typeset all_branches=`git branch -a`
typeset obj_branch=$1
typeset obj_desc=$2
typeset is_exist="0"
 
init_arg(){
	echo "$obj_branch------->$obj_desc"
	if [ -z "$obj_branch" ] || [ -z "$obj_desc" ]; then
		echo "分支名、分支注释内容不可为空"
		exit 1
	fi     
	# >$all_branchesxxxxx"

	if [[ ${all_branches[$obj_branch]} ]]; then
		is_exist="1"
	fi

 
	if [ "$is_exist" == "0" ]; then
		echo "目标分支不存在, 核实后重试"
		exit 1
	fi
 
	if [ ${#obj_desc} -le 0 ] || [ ${#obj_desc} -ge 51 ]; then
		echo "注释内容长度（1-50）不合适，请重新配置"
		exit 1
	fi
}
 
 
add_desc(){	
	git config branch."$obj_branch".description $obj_desc
}
 
init_arg
add_desc