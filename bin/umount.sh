#
cd $(git rev-parse --show-toplevel)
fusermount -u .git/objects

