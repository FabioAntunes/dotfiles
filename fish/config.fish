# misc vars
set -gx DOTFILES (string replace /fish '' (dirname (readlink (status --current-filename))))
set -gx AWS_VAULT_BACKEND pass
set -gx color_scheme 1
set -gx KEYID 5FA46F5D9283889A5DEA82559A22C137957B5A47
set -gx fish_emoji_width 2
set -gx fish_greeting ''
# use ag to pipe the results to fzf, ag respects the gitignore
set -gx FZF_DEFAULT_COMMAND 'ag --hidden --ignore .git -g ""'
set paths_to_add $HOME/platform-tools $HOME/.krew/bin $HOME/google-cloud-sdk/bin /opt/homebrew/bin $HOME/bin
# stupid gcloud
set -gx CLOUDSDK_PYTHON /opt/homebrew/bin/python3.12
set -gx KUBE_EDITOR nvim
set -gx nvm_alias_output $HOME/bin

#create abbreviations
abbr -a gout git checkout
abbr -a g git
abbr -a k kubectl
abbr -a me cd $HOME/playground
abbr -a dot cd $DOTFILES
abbr -a work cd $HOME/work
abbr -a snyk cd $HOME/work/snyk

if type -q go
    set -gx GOPATH (go env GOPATH)
    set -a paths_to_add $GOPATH/bin
end

for path_to_add in $paths_to_add
    if test -d $path_to_add
        fish_add_path $path_to_add
    end
end

if status --is-interactive
    set -x GPG_TTY (tty)
    set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
    gpgconf --launch gpg-agent

    # add aws completions
    type -q aws_completer
    and complete --command aws --no-files --arguments \
        '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'

    # The next line updates PATH for the Google Cloud SDK.
    if [ -f '$HOME/google-cloud-sdk/path.fish.inc' ]
        source '$HOME/google-cloud-sdk/path.fish.inc'
    end
    source ~/.config/fish/functions/__dot_brew_post_install.fish
    starship init fish | source
end
