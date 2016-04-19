#!/bin/bash
set -o nounset
set -o errexit

if [[ $# != 2 ]] ; then
    echo "Usages: $0 SOURCE_ROOT TARGET_ROOT"
    echo "        $0 TARGET_ROOT"
    echo "        $0 --auto"
    echo
    echo "where "
    echo "  SOURCE_ROOT is where "
    exit 1
fi

sourceRoot="$1"
targetRoot="$2"

echo "=== Syncing '$sourceRoot' to '$targetRoot' ..."
rsync --recursive                       \
      --update                          \
      --inplace                         \
      --links                           \
      --keep-dirlinks                   \
      --whole-file                      \
      --protect-args                    \
      --progress                        \
      --exclude="/etc/[^a]*"            \
      --exclude="/lib/ufw/*"            \
      --exclude="/usr/lib/cups/*"       \
      --exclude="/usr/bin/"             \
      --exclude="/usr/src/"             \
      -- "$sourceRoot"/etc              \
         "$sourceRoot"/lib              \
         "$sourceRoot"/usr              \
         "$targetRoot"

echo "=== Fixing broken symlinks in '$targetRoot' ..."
find "$targetRoot" -type l | while IFS="" read symlink ; do

    #tgtrelSymlink="$(realpath --canonicalize-missing      \
    #                          --no-symlinks               \
    #                          --relative-to "$targetRoot" \
    #                          -- "$symlink")"

    destination="$(readlink --no-newline -- "$symlink")"
    if [[ $destination == /* ]] ; then
        symlinkDir="$(dirname "$symlink")"
        relDestination="$(realpath --canonicalize-missing   \
                                   --no-symlinks            \
                                   --relative-to "$symlinkDir" \
                                   -- "$targetRoot/$destination")"

        echo "$symlink:"
        echo "  from: $destination"
        echo "  to:   $relDestination"
        echo

        rm -- "$symlink"
        ln --symbolic -- "$relDestination" "$symlink"
    fi
done

