# Neon Purple Cyberpunk Bash Prompt
# Deep purple to electric purple gradient backgrounds with Arch logo

# Terminal colors
export TERM="xterm-256color"

# Function to show git branch if available
git_branch() {
    local branch=$(git branch 2>/dev/null | grep '^*' | sed 's/* //')
    if [ -n "$branch" ]; then
        # Get additional git details
        local status=$(git status --porcelain 2>/dev/null)
        local ahead=$(git rev-list --count @{upstream}..HEAD 2>/dev/null)
        local behind=$(git rev-list --count HEAD..@{upstream} 2>/dev/null)
        
        # Git status indicators
        local git_info="\[\e[38;2;187;0;255m\][\[\e[38;2;255;54;231m\]󰘬 \[\e[38;2;222;208;255m\]$branch"
        
        # Check for uncommitted changes
        if [ -n "$status" ]; then
            git_info+="\[\e[38;2;187;0;255m\]*"
        fi
        
        # Check for ahead/behind status
        if [ -n "$ahead" ] && [ -n "$behind" ] && [ "$ahead" -gt 0 ] && [ "$behind" -gt 0 ]; then
            git_info+=" \[\e[38;2;255;54;231m\]⇅${ahead}/${behind}"
        elif [ -n "$ahead" ] && [ "$ahead" -gt 0 ]; then
            git_info+=" \[\e[38;2;255;54;231m\]↑${ahead}"
        elif [ -n "$behind" ] && [ "$behind" -gt 0 ]; then
            git_info+=" \[\e[38;2;255;54;231m\]↓${behind}"
        fi
        
        git_info+="\[\e[38;2;187;0;255m\]]\[\e[0m\]"
        echo -e "$git_info"
    fi
}

# Set up the prompt
set_prompt() {
    # Get git branch
    local git_status=$(git_branch)
    
    # Define color codes for segments
    local glow="\[\e[38;2;187;0;255m\]"
    local reset="\[\e[0m\]"
    
    # Create segments with Arch logo directly in username segment (no ◈ symbol)
    local user_segment="${glow}╭─\[\e[48;2;139;92;235m\]\[\e[38;2;30;10;60m\] \[\e[38;2;255;54;231m\]󰣇\[\e[38;2;30;10;60m\] \u ${reset}${glow}─╮${reset}"
    local dir_segment="${glow}╭─\[\e[48;2;168;85;247m\]\[\e[38;2;30;10;60m\] 期 \w ${reset}${glow}─╮${reset}"
    local time_segment="${glow}╭─\[\e[48;2;107;70;193m\]\[\e[38;2;30;10;60m\] 京 \t ${reset}${glow}─╮${reset}"
    
    # Set the prompt
    PS1="\n${user_segment} ${dir_segment} ${time_segment} ${git_status}\n${glow}╰─➤ ${reset} "
}

# Set up the prompt command
PROMPT_COMMAND="set_prompt"

# Add common aliases
alias ls='ls --color=auto'
alias ll='ls -la --color=auto'
alias grep='grep --color=auto'
alias vim='nvim'
alias ..='cd ..'
alias ...='cd ../..'

# To use this file, add this line to your ~/.bashrc:
# source ~/.config/bash-prompt.sh