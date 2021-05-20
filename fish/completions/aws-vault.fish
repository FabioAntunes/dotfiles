function __fish_aws_vault_complete_profiles
  cat ~/.aws/config | grep -e "\[[^(okta)]" | awk -F'[] []' '{print $3}'
end

function __fish_complete_aws_vault_subcommand
  set -l tokens (commandline -opc) (commandline -ct)
  set -l index (contains -i -- -- (commandline -opc))
  set -e tokens[1..$index]
  complete -C"$tokens"
end

function __fish_aws_vault_needs_command
    set cmd (commandline -opc)
    if [ (count $cmd) -eq 1 ]
        return 0
    end
    return 1
end

function __fish_aws_vault_using_command
    set cmd (commandline -opc)
    if [ (count $cmd) -gt 1 ]
        if [ $argv[1] = $cmd[2] ]
            return 0
        end
    end
    return 1
end

set -l aws_vault_commands add list rotate exec clear remove login help
complete -f -c aws-vault -n "__fish_aws_vault_needs_command" -a add -d 'Adds credentials to the secure keystore'
complete -f -c aws-vault -n "__fish_aws_vault_needs_command" -a list -d 'List profiles, along with their credentials and sessions'
complete -f -c aws-vault -n "__fish_aws_vault_needs_command" -a help -d 'Show help'
complete -f -c aws-vault -n "__fish_aws_vault_needs_command" -a exec -d 'Executes a command with AWS credentials in the environment'
complete -f -c aws-vault -n "__fish_aws_vault_needs_command" -a clear -d 'Clear temporary credentials from the secure keystore'
complete -f -c aws-vault -n "__fish_aws_vault_needs_command" -a remove -d 'Removes credentials from the secure keystore'
complete -f -c aws-vault -n "__fish_aws_vault_needs_command" -a login -d 'Generate a login link for the AWS Console'
complete -f -c aws-vault -n "__fish_aws_vault_using_command login; and not __fish_seen_subcommand_from (__fish_aws_vault_complete_profiles)" -a "(__fish_aws_vault_complete_profiles)"
complete -f -c aws-vault -n "__fish_aws_vault_using_command exec; and not __fish_seen_subcommand_from (__fish_aws_vault_complete_profiles)" -a "(__fish_aws_vault_complete_profiles)"
complete -f -c aws-vault -n "__fish_aws_vault_using_command exec; and __fish_seen_subcommand_from (__fish_aws_vault_complete_profiles); and not __fish_seen_subcommand_from --" -a "--"

complete -c aws-vault -n "__fish_aws_vault_using_command exec; and __fish_seen_subcommand_from (__fish_aws_vault_complete_profiles); and contains -- -- (commandline -opc)" -x -a "(__fish_complete_aws_vault_subcommand)"
