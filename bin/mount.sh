
cd $(git rev-parse --show-toplevel)
cryfs -c .secure/config.key objects .git/objects -- -o nonempty
