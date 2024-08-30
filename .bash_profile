alias pf='cd $(find . -type d -print | fzf)'
alias vpf='vim -o `fzf`'
# alias gitpf='. ~/scripts/fzf-git.sh'
alias gf="git checkout \$(git for-each-ref --sort=-committerdate --format='%(refname:short)' refs/heads/ | fzf)"

alias gcm="git checkout main"
alias gp="git pull -p"
alias gpu="git push --set-upstream origin HEAD"
alias gmm="git merge main"
alias cleanup="git remote prune origin && git branch --merged main | grep -v '^[ *]*main$' | xargs git branch -d"

alias killall="taskkill -f -im node.exe"
alias killnm="(
rm -rf node_modules
rm -f yarn.lock
npm cache clean --force
)"

#### CLINICAL
## DEV
alias dev='reset; yarn dev'
alias api='reset; cd ../api && dotnet run'
alias is0='reset; cd ../imageserver && dotnet run'
alias is='reset; cd /c/src/copy-dotnet-core-services/core/src/IndicaLabs/ApplicationLayer/DeepZoom && dotnet run'
alias fm='reset; cd ~/git/dotnet-core-services/core/src/IndicaLabs/ApplicationLayer/FileMonitor && dotnet run'
alias app='reset; dotnet run'
alias migratedb='cd ../api && dotnet run update-database'
alias fixdb='cd ~/git/dotnet-core-services/clinical/src/Workflow/Workflow.Infrastructure && dotnet ef database update -s ../Workflow.Api && cd -'
alias 2.3='cd /c/src/2.3/clinical/src/HaloAP/web'
alias 2.2='cd /c/src/2.2/clinical/src/HaloAP/web'
alias 2.1='cd /c/src/2.1/clinical/src/HaloAP/web'
alias main='cd /c/src/dotnet-core-services/clinical/src/HaloAP/web'

#### HALO LINK
## DEV
alias HLwebpack='reset; npm run watch-client |bunyan --color -o short'
alias HLapp='reset; npm run start-dev |bunyan --color'
alias HLapi='reset; npm run start-dev-api |bunyan --color'
alias HLdev='reset; npm run dev | bunyan --color -o short'

## PROD
alias HLbuild='npm run build |bunyan --color -o short'
alias HLstart='npm run start |bunyan --color -o short'

alias HLis='python imageserver/indica_image_server.py'
alias HLpy35is='source activate py35 && python imageserver/indica_image_server.py'
alias migratedbProd='cd ~/../../Program\ Files/Indica\ Labs/HALO\ AP/api/ && start haloap.api.exe update-database'

## Colorize the ls output ##
# alias ls='ls --color=auto'
# ---- Eza (better ls) -----
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
## Use a long listing format ##
alias ll='ls -la'
## Show only hidden files ##
alias l.='ls -d .* --color=auto'

## a quick way to get out of current directory ##
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias ~='cd ~'
alias todo='nvim /c/Users/nlevick/Documents/Notes/Todo.txt'
alias notes='nvim /c/Users/nlevick/Documents/Notes'
alias so='source ~/.bash_profile'
alias nnvim='cd ~/AppData/Local/nvim && nvim'

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

