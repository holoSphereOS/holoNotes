
cd $(git rev-parse --show-toplevel)
cryfs -c .secure/config.key cypher .git -- -o nonempty
