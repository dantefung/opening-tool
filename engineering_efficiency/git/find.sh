#! /bin/bash
# @author		huhai
# @skill		linxu shell
# @message		git 日志查看脚本
 
# 命令及参数
typeset command="git log"
typeset argv=" --no-merges --date=short"
typeset pretty=" --pretty=\"%n%n%n%Cred[%cd]%Cgreen<%cn %ce>%C(yellow)[%H]%n%Creset%s\""
 
# 输出文件路径
typeset outfile="~/Desktop/lanyue.log"
 
# 入参
typeset branch
typeset username
typeset email
typeset file
typeset context
typeset message
typeset startdate
typeset enddate
typeset basepoint
typeset standpoint
# -a 代表数组
typeset -a all_branches
typeset is_detail="0"
typeset is_out="0"
typeset is_print="0"
 
 
 
# 帮助信息
showhelp(){
	echo "-h [无参]	help:帮助命令"
	echo "-d [无参]	detail:将每次提交的文件修改详细列出"
	echo "-a [无参]	about:将每次提交的文件修改行数列出"
	echo "-o [无参]	out:输出结果到桌面的 lanyue.log 文件"
	echo "-p [无参] print:将完整的命令打印而不是执行"
 
	echo "\n"
 
	echo "-b [有参] branch:匹配分支名"
	echo "-u [有参] user:匹配作者"
	echo "-e [有参] email:匹配email"
	echo "-f [有参] file:匹配提交文件"
	echo "-c [有参] context:匹配提交文件所包含的内容"
	echo "-m [有参] message:匹配提交注释"
	echo "-x [有参] (获取 分支|commit 之间的commit历史) 基点"
	echo "-y [有参] (获取 分支|commit 之间的commit历史) 变点"
	echo "-S [有参] Start:匹配开始日期"
	echo "-E [有参] End:匹配结束日期"
	exit 1
}
 
# 报错信息
errorinfo(){
	echo "出错可能是以下原因："
	echo "1. 未知参数，请使用 -h 查看帮助信息"
	echo "2. 未给有参子命令提供参数值"
	exit 1
}
 
# 入参定义
while getopts ":hadopb:u:e:f:c:m:x:y:S:E:" option
do
	case $option in
		b)
			branch=$OPTARG
			;;
		u)
			username=$OPTARG
			;;
		e)
			email=$OPTARG
			;;
		f)
			file=$OPTARG
			;;
		c)
			context=$OPTARG
			;;
		m)
			message=$OPTARG
			;;
		x)
			basepoint=$OPTARG
			;;
		y)
			standpoint=$OPTARG
			;;
		S)
			startdate=$OPTARG
			;;
		E)
			enddate=$OPTARG
			;;
		a)
			is_detail="1"
			;;
		d)
			is_detail="2"
			;;
		o)
			is_out="1"
			;;
		p)
			is_print="1"
			;;
		h)
			showhelp
			;;
		?)
			errorinfo
			;;
	esac
done
 
 
 
# 初始化分支信息
init_branch(){
	# 判断目标分支是否真实存在的标志
	typeset is_exist="0"
 
	# 如果没有输入分支，则默认当前分支为操作对象
	if [ -z "$branch" ]; then
		branch=`git symbolic-ref --short HEAD`
	fi
 
	# 判断输入分支是否合法（存在）
	all_branches=`git branch -a`
	for curr_branch in $all_branches
	do
		if [ $curr_branch == $branch ]; then
			is_exist="1"
			break
		fi
	done
 
	if [ $is_exist == "0" ]; then
		echo "目标分支 [-b 参数] 不存在，请核实后重试"
		exit 1
	fi
 
	command=$command" "$branch
}
 
# 初始化比较信息，用于得到 standpoint 相较于 basepoint 多了的提交历史
init_compare(){
	if [ ! -z "$basepoint" ]; then
		if [ -z "$standpoint" ]; then
			standpoint=`git symbolic-ref --short HEAD`
		fi
	fi
 
	if [ ! -z "$standpoint" ]; then
		if [ -z "$basepoint" ]; then
			basepoint=`git symbolic-ref --short HEAD`
		fi
	fi
 
	if [ ! -z "$basepoint" ] && [ ! -z "$standpoint" ]; then
		command="git log"
		command=$command" "$basepoint".."$standpoint
	fi
}
 
# 初始化开始日期信息
init_startdate(){
	if [ ! -z "$startdate" ]; then
		typeset date_type=`echo $startdate | grep -v '[^0-9]' > /dev/null && /dev/null && echo "number" || echo "string"`
 
		if [ "$date_type" == "string" ]; then
			echo "开始日期不合法，必须为数字类型"
			exit 1
		elif [ "$date_type" == "number" ]; then
			typeset date_length=`echo ${#startdate}`
			if [ "$date_length" -ne 8 ]; then
				echo "开始日期长度不合法，必须为合法8位日期"
				exit 1
			fi
		else
			echo "未知错误，异常退出"
			exit 1
		fi
		
		# 格式化日期
		typeset year=${startdate:0:4}
		typeset month=${startdate:4:2}
		typeset day=${startdate:6:2}
 
		typeset startdate_final=$year"-"$month"-"$day
 
		argv=$argv" --after=""$startdate_final"
	fi
}
 
# 初始化结束日期信息
init_enddate(){
	if [ ! -z "$enddate" ]; then
		typeset date_type=`echo $enddate | grep -v '[^0-9]' > /dev/null && /dev/null && echo "number" || echo "string"`
 
		if [ "$date_type" == "string" ]; then
			echo "结束日期不合法，必须为数字类型"
			exit 1
		elif [ "$date_type" == "number" ]; then
			typeset date_length=`echo ${#enddate}`
			if [ "$date_length" -ne 8 ]; then
				echo "结束日期长度不合法，必须为合法8位日期"
				exit 1
			fi
		else
			echo "未知错误，异常退出"
			exit 1
		fi
		
		# 格式化日期
		typeset year=${enddate:0:4}
		typeset month=${enddate:4:2}
		typeset day=${enddate:6:2}
 
		typeset enddate_final=$year"-"$month"-"$day
 
		argv=$argv" --before=""$enddate_final"
	fi
}
 
# 初始化 作者 和 email 信息
init_author_email(){
	typeset is_set="0"
 
	if [ ! -z "$username" ]; then
		argv="$argv"" --committer=""$username"
		is_set="1"
	fi
 
	if [ "$is_set" == "0" ] && [ ! -z "$email" ]; then
		argv="$argv"" --committer=""$email"
	fi
}
 
# 是否显示每次提交的详细信息
init_show_detail(){
	if [ "$is_detail" == "1" ]; then
		argv="$argv"" --numstat"
	elif [ "$is_detail" == "2" ]; then
		argv="$argv"" -p"
	else
		argv="$argv"" --name-status"
	fi
}
 
# 匹配提交文件名
init_commit_file(){
	if [ ! -z "$file" ]; then
		argv="$argv"" --*""$file""*"
	fi
}
 
# 匹配提交内容
init_commit_context(){
	if [ ! -z "$context" ]; then
		argv="$argv"" -S""\"""$context""\""
	fi
}
 
# 匹配提交注释
init_commit_message(){
	if [ ! -z "$message" ]; then
		argv="$argv"" --grep ""$message"
	fi
}
 
# 执行命令
exec_command(){
	if [ "$is_out" == "1" ]; then
		cmd="$command""$argv""$pretty"" > ""$outfile"
	else
		cmd="$command""$argv""$pretty"
	fi
 
	if [ "$is_print" == "1" ]; then
		echo "$cmd"
	else
		eval "$cmd"
	fi
}
 
 
 
# 调用函数
init_branch
init_compare
init_startdate
init_enddate
init_author_email
init_show_detail
init_commit_file
init_commit_context
init_commit_message
exec_command