complete -c aws-okta --condition '__fish_seen_subcommand_from exec okta-staging okta-dev okta-prod' --argument 'aws' --wraps aws
complete -c aws-okta --condition '__fish_seen_subcommand_from exec okta-staging okta-dev okta-prod' --argument 'terraform' --wraps terraform
