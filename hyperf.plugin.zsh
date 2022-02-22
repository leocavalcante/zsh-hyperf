#--------------------------------------------------------------------------
# Hyperf plugin for zsh
#--------------------------------------------------------------------------
#
# This plugin adds an `hyper` shell command that will find and execute
# Hyperf's bin/hyperf.php command from anywhere within the project. It also
# adds shell completions that work anywhere bin/hyperf.php can be located.

function hyperf() {
    _hyperf=`_hyperf_find`

    if [ "$_hyperf" = "" ]; then
        >&2 echo "zsh-hyperf: You seem to have upset the delicate internal balance of my housekeeper."
        return 1
    fi

    _hyperf_start_time=`date +%s`
    php $_hyperf $*
    _hyper_exit_status=$? # Store the exit status so we can return it later

    if [[ $1 = "gen:"* && $HYPERF_OPEN_ON_GEN_EDITOR != "" ]]; then
        # Find and open files created by gen commands
        _hyperf_path=`dirname $_hyperf`
        find \
            "$_hyperf_path/app" \
            "$_hyperf_path/test" \
            "$_hyperf_path/database" \
            -type f \
            -newermt "-$((`date +%s` - $_hyperf_start_time + 1)) seconds" \
            -exec $HYPERF_OPEN_ON_GEN_EDITOR {} \; 2>/dev/null
    fi

    return $_hyperf_exit_status
}

compdef _hyperf_add_completion hyperf

function _hyperf_find() {
    # Look for bin/hyperf.php up the file tree until the root directory
    dir=.
    until [ $dir -ef / ]; do
        if [ -f "$dir/bin/hyperf.php" ]; then
            echo "$dir/bin/hyperf.php"
            return 0
        fi

        dir+=/..
    done

    return 1
}

function _hyperf_add_completion() {
    if [ "`_hyperf_find`" != "" ]; then
        compadd `_hyperf_get_command_list`
    fi
}

function _hyperf_get_command_list() {
    hyperf --raw --no-ansi list | sed "s/[[:space:]].*//g"
}
