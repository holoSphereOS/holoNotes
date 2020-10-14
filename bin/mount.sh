<<<<<<< HEAD
# 


# intent: 
#  mount an encrypted git repository
#  w/ the command
#  cryfs $1 $gitdir

#
#Deriving encryption key (this can take some time)...done
#This filesystem is for CryFS 0.9.6 (or a later version with the same storage format). You're running a CryFS version using storage format 0.10. It is recommended to create a new filesystem with CryFS 0.10 and copy your files into it. If you don't want to do that, we can also attempt to migrate the existing filesystem, but that can take a long time, you won't be getting some of the performance advantages of the 0.10 release series, and if the migration fails, your data may be lost. If you decide to continue, please make sure you have a backup of your data. Do you want to attempt a migration now?
#


pwd=$(pwd -L)
toplevel=$(git rev-parse --show-toplevel)
gitdir=$(git rev-parse --git-dir)
pass=$(grep /keybase/private/$USER/etc/passwd -e '^cryfs:' | head -1 | cut -d':' -f2)

if [ "x$1" = 'x' ]; then
 if ! echo "$gitdir" | grep -q -e '/'; then
   gitdir="$pwd/$gitdir"
 fi
 echo "mount: |-"
 mount | grep "$gitdir" | fmt | sed -e 's/^/  /'
else
 if [ ! -d "$1" ]; then
   cd $toplevel
 fi
 if [ -e "$1" ]; then
   echo base: $1
   (cd $1; git checkout encrypted)
 else
   echo "warn: ! -e $1"
 fi
 if [ "x$2" != 'x' ]; then
   mountp="$2"
 else
   mountp="$gitdir"
 fi
 echo toplevel: $toplevel
 echo mountpoint: $gitdir
 export CRYFS_FRONTEND=noninteractive
 echo $pass | cryfs -c "$toplevel/.secure/config.key" --cipher aes-256-gcm --blocksize 16384 "$1" "$mountp" -o nonempty
fi

remote=$(git remote get-url --push origin)
echo remote: $remote
=======

cd $(git rev-parse --show-toplevel)
cryfs -c .secure/config.key cypher .git -- -o nonempty
>>>>>>> ceaf2850c098183d089ea8818db4bf2a78406536
