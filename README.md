This is a docker image for running CLI AI agents in full access mode without
worrying as much about what it's doing.

Generally I create a separate ephemeral container for each launch of the agent
with something like this:

```
podman run --rm -it -v $HOME/.codex:/home/agent/.codex -v $PWD:/dir agentainer 
```

Once in the container you can then `cd /dir` and run `pi`, etc.

One caveat is that login wasn't working for me from inside the container,
which is why I'm binding it to $HOME/.codex. Basically I run codex on the host
machine and login, then map $HOME/.codex so I can access my credentials from
inside.

This is also useful if you have different credentials (ie personal vs work).
You can copy the credentials to a different host folder and bind different
folders for different containers.
