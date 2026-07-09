function kube:context --description "Switch kubernetes context"
    kubectl config get-contexts --no-headers | grep -v '^\*' | awk '{print $1}' | zf | xargs kubectl config use-context
end
