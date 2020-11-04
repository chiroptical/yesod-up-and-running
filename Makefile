.PHONY: build serve format test

build:
	stack build

serve:
	stack exec -- yesod devel

format:
	# Ignore Settings.hs because it contains CPP
	find src app test -name "*.hs" -not -name "Settings.hs" -exec fourmolu -i {} +

test:
	stack test --flag yesod-up-and-running:library-only --flag yesod-up-and-running:dev
