SOURCES = $(wildcard Sources/**/*.swift)
TESTS = $(wildcard Tests/**/*.swift)
BUILD = $(shell swift build --show-bin-path -c release)
DBUILD = $(shell swift build --show-bin-path -c debug)
XLINKER = $(shell pkg-config libcmark --libs | tr ' ' '\n' | xargs -I {} echo -n "-Xlinker {} ")
XCC = $(shell pkg-config libcmark --cflags | tr ' ' '\n' | xargs -I {} echo -n "-Xcc {} ")
TARGET=swift-importc-test
RELEASE_BIN = $(BUILD)/$(TARGET)
DEBUG_BIN = $(DBUILD)/$(TARGET)
PREFIX=~/.local/bin/

.PHONY: all
all: $(RELEASE_BIN)

.PHONY: debug
debug: $(DEBUG_BIN)

$(RELEASE_BIN): $(SOURCES)
	@echo $(RELEASE_BIN)
	swift build -c release $(XCC) $(XLINKER)

$(DEBUG_BIN): $(SOURCES)
	@echo $(DEBUG_BIN)
	swift build $(XCC) $(XLINKER)

.PHONY: run-debug
run-debug: $(DEBUG_BIN)
	$(DEBUG_BIN)

.PHONY: run
run: $(RELEASE_BIN)
	$(RELEASE_BIN)
