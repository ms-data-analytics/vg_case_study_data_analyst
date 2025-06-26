# set timezone
export TZ="America/Chicago"

# env
export PYTHONIOENCODING=utf-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=C

# set terminal theme
export PS1='\e[0;34m ┌───┤ \W$(__git_ps1 " (%s)") \n │ \n └───▷ $ '

# auto-complete
source ~/.git-completion.bash
source ~/.git-prompt.sh
export PATH='/root/.duckdb/cli/latest':$PATH

# alias

# file system
alias ll='ls -al'
alias set='source ~/.bashrc'
# git
alias gf='git fetch'
alias gs='git status'
alias gc='git commit -am'
alias gp='git push'
alias gnb='git checkout -b'
# dbt
alias compile='dbt compile'
alias parse='dbt parse'
# terraform 
alias init='terraform init'
alias plan='terraform plan -no-color >> tfplan.txt'
