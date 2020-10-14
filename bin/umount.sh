#
gitdir=$(git rev-parse --git-dir)
cd $(git rev-parse --show-toplevel)
#fusermount -u $gitdir
cryfs-unmount $gitdir

