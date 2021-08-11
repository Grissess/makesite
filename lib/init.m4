m4_divert(-1)
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

m4_dnl Holds the diversion numbers of these sections. Generally main should be
m4_dnl before footer.
m4_ifdef(`MS_FOOTER_DIVERSION', `', `m4_define(`MS_FOOTER_DIVERSION', `9')')
m4_ifdef(`MS_MAIN_DIVERSION', `', `m4_define(`MS_MAIN_DIVERSION', `5')')

m4_divert(MS_FOOTER_DIVERSION)m4_dnl
m4_include(`lib/foot.m4')
m4_divert(MS_MAIN_DIVERSION)m4_dnl Rest of the input source follows
