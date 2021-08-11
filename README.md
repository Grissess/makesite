# Makesite

A simple static site generator using `m4`.

_Why m4?_ Because it is a powerful metaprogramming language! You can define
your own components and routines to be run _at site compile time_ to generate
HTML for you. Similarly, `m4` is primed by the makefile to take care of
boilerplate, and you can freely extend this as needed.

_What about markdown?_ You can still use markdown, assuming you have a
processor installed! Let's pretend that `markdown` is a working command on your
system that _writes its output to stdout_; then you can do:

```
m4_esyscmd(`markdown path/to/file.md')
```

(where `path/to/file.md' is relative to this repository.) If you're doing this
regularly (say, in a macro, or the header), you could base it on the filename:

```
m4_esyscmd(`markdown 'm4_patsubst(MS_FILE, `\.m4', `.md'))
```

(`MS_FILE` is defined on the command line in the Makefile to be "the file being
read".) If you're doing this in the header, though, you may want to edit the
Makefile to tell it to consider markdown files:

```
# The binary
MARKDOWN=markdown

# Any flags (leave this for other builders!)
MDFLAGS=

# All the files to be built
MARKDOWNS=$(patsubst %.md,%.html,$(shell find $(SRCDIR) -iname "*.md"))

# Make it part of the default target
all: $(MARKDOWNS)

# These need the output directory to exist
$(MARKDOWNS): | $(BUILDDIR)

# Actually compile the output file
$(MARKDOWNS): $(BUILDDIR)/%.html: $(SRCDIR)/%.md
	mkdir -p $$(dirname "$@")
	# XXX you're responsible for your own boilerplate
	"$(MARKDOWN)" $(MDFLAGS) "$^" > "$@"
```

_Why `-P`?_ To avoid the kinds of conflicts that can happen when "bare macros"
(like `define` or `divert`) show up. It's a little more to type when you _do_
want to use the `m4` layer, but that should generally be less time than
actually designing your static site.
