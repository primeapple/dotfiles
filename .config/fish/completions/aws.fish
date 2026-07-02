function __aws_complete
    set --local --export COMP_SHELL fish
    set --local --export COMP_LINE (commandline -pc)

    if string match -q -- - (commandline -pt)
        set COMP_LINE "$COMP_LINE-"
    end

    aws_completer | command sed 's/ $//'
end

# Enable AWS CLI autocompletion: github.com/aws/aws-cli/issues/1079
complete --command aws --no-files --arguments '(__aws_complete)'
