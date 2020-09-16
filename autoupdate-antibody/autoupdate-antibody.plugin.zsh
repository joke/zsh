function _autoupdate_antibody() {
    [[ -z "$(whence antibody)" ]] && return
    
    setopt extendedglob
    local home=$ANTIBODY_HOME
    local days=${AUTOUPDATE_ANTIBODY_DAYS:=7}
    [[ -z $home ]] && home="$(antibody home)"
    if [[ -n $home/*/.git/FETCH_HEAD(#qY1N-md+${days}) ]]; then
      antibody update
      touch $home 
      [[ $AUTOUPDATE_ANTIBODY_RESTART = true && -n $home/*/.git/objects(#qN-mh-$((days*24))) ]] && exec "$@"
    fi
}
_autoupdate_antibody
