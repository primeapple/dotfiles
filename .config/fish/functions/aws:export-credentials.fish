function aws:export-credentials
    set -l profile (string replace --all --regex '\[|\]' '' (string replace -r 'profile ' '' (grep profile ~/.aws/config)) | zf)
    echo "Exporting credentials for profile $profile"
    set -l credentials (aws configure export-credentials --profile $profile)
    set -gx AWS_ACCESS_KEY_ID (echo $credentials | jq -r '.AccessKeyId')
    set -gx AWS_SECRET_ACCESS_KEY (echo $credentials | jq -r '.SecretAccessKey')
    set -gx AWS_SESSION_TOKEN (echo $credentials | jq -r '.SessionToken')
end
