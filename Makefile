# Where are your site's source files stored?
SRCDIR=src
# Where do you want your site's directory structure to be built?
BUILDDIR=build
# Where are static files that should be copied to the build directory verbatim?
STATICDIR=static

BUILDS=$(patsubst $(SRCDIR)/%.m4,$(BUILDDIR)/%.html, $(shell find $(SRCDIR) -iname "*.m4"))
STATICS=$(patsubst $(STATICDIR)/%,$(BUILDDIR)/%, $(shell find $(STATICDIR) -type f))

M4=m4
M4FLAGS=-P
INIFILE=lib/init.m4

all: $(BUILDS) $(STATICS)

# Set VERBOSE=(anything) to view the files being generated
ifdef VERBOSE
all:
	@echo "Builds: $(BUILDS)"
	@echo "Statics: $(STATICS)"
endif

$(BUILDS) $(STATICS): | $(BUILDDIR)

$(BUILDDIR):
	mkdir "$@" || true

$(BUILDS): $(BUILDDIR)/%.html: $(SRCDIR)/%.m4
	mkdir -p $$(dirname "$@")
	"$(M4)" $(M4FLAGS) -DMS_FILE="$?" "$(INIFILE)" "$^" > "$@"

$(STATICS): $(BUILDDIR)/%: $(STATICDIR)/%
	mkdir -p $$(dirname "$@")
	cp "$^" "$@"
