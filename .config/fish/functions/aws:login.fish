function aws:login
    set -l profile (string replace --all --regex '\[|\]' '' (string replace -r 'profile ' '' (grep profile ~/.aws/config)) | zf)
    echo "Login into AWS using profile $profile"
    aws sso login --profile $profile
    set -Ux AWS_PROFILE $profile
    aws sts get-caller-identity
end
