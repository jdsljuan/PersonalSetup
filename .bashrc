# .bashrc

# @author Juan David Sanchez Leal


# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi


# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH


# User specific aliases and functions

#My Variables
EDITOR='micro'
VOLUME_UP="amixer set Master 2%+"
VOLUME_DOWN="amixer set Master 2%-"

#My Functions
promptMaker(){

	#Save the last command exec result.
	local LAST_STATUS="$?"

	#Some colors and Backgrounds.
	local C_P="\[\e[1;35m\]"
	local C_C="\[\e[1;36m\]"
	local C_R="\[\e[1;31m\]"
	local C_G="\[\e[1;32m\]"
	local C_Y="\[\e[1;33m\]"
	local C_W="\[\e[1;37m\]"
	local C_BCK="\[\e[1;30m\]"
	local C_B="\[\e[1;34m\]"   
	local C_BCK_N="\[\e[30m\]" 
	local C_ESC="\[\e[m\]"
	#_____________
	local B_C="\[\e[46m\]"
	local B_B="\[\e[44m\]"
	local B_W="\[\e[47m\]"
	local B_G="\[\e[42m\]"
	local B_P="\[\e[45m\]"
	local B_Y="\[\e[43m\]"
	local B_R="\[\e[41m\]"
	local B_BNK="\[\e[40m\]"
	
	#Scripts mini
	local P_SIZE="$(ls -lah | grep -m 1 '^[total]' | awk '{ print $2}')"
	local P_RAM="$(free | grep -m 1 'Mem' | awk 'a=int(($3/$2)*100.0) { print a }')"
	local P_PROCESS="$(ps xa | awk 'END{print NR-2}')"
	local P_CHECK_GIT="$(git status 2> >( echo -n '0') )"
	#____________
	local P_LS_HIDDEN="$(ls -la | awk 'END{print NR}')"
	local P_LS_NORMAL="$(ls -l | awk 'END{print NR}')"
	local P_HIDDEN=$(echo -n "${P_LS_HIDDEN} ${P_LS_NORMAL}" | awk 'a=$1-$2 {if(a == 2) print "0"; else print (a-2);}')
	#____________
	
	#PS is the Prompt Seq. WITH HIDDEN FILES - BASE STRING
	local PS="${C_BCK_N}${B_C} \T ${B_W} \W ? ${P_HIDDEN} @ ${P_SIZE} ${C_ESC}"

	#RAM AND PROCESS - ADD at the START
	local AUX_RAM="${P_RAM}% # ${P_PROCESS} ${C_ESC}${PS}"
	if [[ ${P_RAM} -lt 50  ]]; then
		local PS="${C_BCK_N}${B_G} ${AUX_RAM}"
	elif [[ ${P_RAM} -ge 50 && ${P_RAM} -le 75 ]]; then
		local PS="${C_BCK_N}${B_Y} ${AUX_RAM}"
	else
		local PS="${C_BCK_N}${B_R} ${AUX_RAM}"
	fi
	
	#GIT COLOR - ADD at the END
	if [[ ${P_CHECK_GIT} != "0" ]]; then
		local P_GIT="$(git branch | grep '^[\*]' | awk '{ if( $3 != "" ) print $2 " " $3 " " $4 " " $5; else print $2; }')"
		local PS="${PS}${C_BCK_N}${B_P} ${P_GIT} ${C_ESC}"
	fi
	
	#COMMAND STATUS CHECK - ADD at the END
	local CMD_OK="${C_G} <> "
	local CMD_ERR="${C_R} >< "

	if [[ ${LAST_STATUS} == 0 ]];then
		local CMD_STATUS="${CMD_OK}${C_ESC}"
		local PS="${PS}${B_BNK}${CMD_STATUS}"
	else
		local CMD_STATUS="${CMD_ERR}${C_ESC}"
		local PS="${PS}${B_BNK}${CMD_STATUS}"
	fi
	
	#Prompt Definition, Space at the End. :)
	PS="${PS}${C_ESC} "
	PS1="${PS}"
}

PROMPT_COMMAND="promptMaker"

#My Prompts

#My Alias
alias l='ls -Xhla'
alias c='clear'
