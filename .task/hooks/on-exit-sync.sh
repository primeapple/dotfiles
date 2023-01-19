#!/bin/sh
# This hooks script syncs task warrior to the configured task server.
# The on-exit event is triggered once, after all processing is complete.

# Make sure hooks are enabled

check_for_internet() {
    # check for internet connectivity
    nc --zero --wait=1 8.8.8.8 53  >/dev/null 2>&1
    if [ $? != 0 ]; then
        exit 0
    fi
}

# Count the number of tasks modified
n=0
while read modified_task
do
    n=$(($n + 1))
done

if (($n > 0)); then
    check_for_internet
    date >> ~/.task/sync_hook.log
    task rc.verbose:nothing sync >> ~/.task/sync_hook.log &
fi

exit 0
