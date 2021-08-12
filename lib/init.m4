m4_divert(-1)
m4_define(`MS_NL', `
')
m4_define(`MS_HEAD', m4_include(`lib/head.m4'))

m4_dnl A path relative to the build root.
m4_define(`MS_REL_PATH', m4_substr(MS_FILE, m4_incr(m4_index(MS_FILE, `/'))))

m4_dnl A relative path that resolves to the build root. This is . when we're in
m4_dnl the root, and the correct number of (../) if we're not. Useful for
m4_dnl referencing a static file.
m4_define(`MS_ROOT', m4_ifelse(
	m4_index(MS_REL_PATH, `/'), `-1',
	`.',
	m4_pushdef(`path', m4_patsubst(m4_patsubst(MS_REL_PATH, `[^/]'), `/', `../'))m4_dnl
m4_dnl Get rid of the trailing /
m4_substr(path, 0, m4_decr(m4_len(path)))m4_dnl
m4_popdef(`path')))

m4_dnl Runs $2 with the symbol in $1 defined to each of $3, $4, $5, etc.,
m4_dnl concatenating each with an empty string.
m4_define(`MS_FOREACH', `m4_ifelse(m4_eval(`$# < 3'), `1', `',m4_dnl
`$3$#', `3', `',m4_dnl XXX Our third arg is empty at the last iteration
`m4_pushdef(`$1', `$3')m4_dnl
$2`'m4_popdef(`$1')m4_dnl
$0(`$1', `$2', m4_shift(m4_shift(m4_shift($@))))')')

m4_dnl This variable contains a comma-separated list of all the pages that will
m4_dnl be built, relative to MS_ROOT (as if each were an MS_REL_PATH).
m4_pushdef(`push_build', `m4_dnl
m4_pushdef(`buildname', m4_substr(`$1', m4_incr(m4_index(`$1', `/'))))m4_dnl
m4_ifdef(`MS_BUILDS',m4_dnl
`m4_define(`MS_BUILDS', m4_defn(`MS_BUILDS')`,'m4_defn(`buildname'))',m4_dnl
`m4_define(`MS_BUILDS', m4_defn(`buildname'))'m4_dnl
)')

m4_patsubst(m4_defn(`MS_VAR_BUILDS'), `[^ ]+', `push_build(`\&')')
m4_popdef(`push_build')
m4_ifdef(`MS_BUILDS', `', `m4_define(`MS_BUILDS', `')')

m4_dnl Holds the diversion numbers of these sections. Generally main should be
m4_dnl before footer.
m4_ifdef(`MS_FOOTER_DIVERSION', `', `m4_define(`MS_FOOTER_DIVERSION', `9')')
m4_ifdef(`MS_MAIN_DIVERSION', `', `m4_define(`MS_MAIN_DIVERSION', `5')')

m4_divert(MS_FOOTER_DIVERSION)m4_dnl
m4_include(`lib/foot.m4')
m4_divert(MS_MAIN_DIVERSION)m4_dnl Rest of the input source follows
