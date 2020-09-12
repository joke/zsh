function _autoupdate_antibody() {
    [[ -z "$(whence antibody)" ]] && return
    
    setopt extendedglob
    local home=$ANTIBODY_HOME
    local days=${AUTOUPDATE_ANTIBODY_DAYS:=7}
    [[ -z $home ]] && home="$(antibody home)"
    if [[ -n $home/*/.git/FETCH_HEAD(#qN-md+${days}) ]]; then
      antibody update
      touch $home 
      [[ $AUTOUPDATE_ANTIBODY_RESTART = true && -n $home/*/.git/objects(#qN-md-${days}) ]] && exec "$@"
    fi
}
_autoupdate_antibody
