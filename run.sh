container_name=$(basename $PWD)

podman run --rm -it \
    --name agentainer-${container_name} \
    -v $PWD:/mnt/${container_name} \
    -v $HOME/.pi:/root/.pi \
    $@ \
    agentainer
