.PHONY: analyze build clean dev help install lint test

define check_tuist
	if ! command -v tuist > /dev/null; then \
		echo \
			"Tuist is not installed," \
			"see https://tuist.io for how to install it."; \
		exit 1; \
	fi
endef

help:
	@echo "Welcome to vanyauhalin/dl sources."
	@echo ""
	@echo "Usage: make <subcommand>"
	@echo ""
	@echo "Subcommands:"
	@echo "  analyze     Analyze the project via SwiftLint."
	@echo "  build       Build the project via Tuist."
	@echo "  clean       Clean generated Tuist files except for dependencies."
	@echo "  dev         Generate a development workspace via Tuist."
	@echo "  help        Show this message."
	@echo "  install     Install dependencies and generate a development workspace"
	@echo "              via Tuist."
	@echo "  lint        Lint the project and Tuist directory via SwiftLint."
	@echo "  test        Test the project via Tuist."

analyze:
	@$(call check_tuist)
	@tuist generate DotLocal -n
	@xcodebuild \
		-workspace dl.xcworkspace \
		-scheme DotLocal \
		CODE_SIGN_IDENTITY="" \
		CODE_SIGNING_REQUIRED=NO \
		> xcodebuild.log
	@xcrun \
		--sdk macosx \
		swift run \
			--package-path Tuist/Dependencies/SwiftPackageManager \
			--skip-build \
				swiftlint analyze \
					--config .swiftlint.yml \
					--compiler-log-path xcodebuild.log

build:
	@$(call check_tuist)
	@tuist generate -n dl
	@tuist build dl --build-output-path .build

clean:
	@rm -f xcodebuild.log
	@rm -rf Derived
	@rm -rf dl.xcodeproj
	@rm -rf dl.xcworkspace

dev:
	@$(call check_tuist)
	@tuist generate DotLocal DotLocalTests

install:
	@$(call check_tuist)
	@tuist fetch
	@tuist generate DotLocal DotLocalTests
	@xcrun \
		--sdk macosx \
		swift build \
			--package-path Tuist/Dependencies/SwiftPackageManager \
			--product swiftlint

lint:
	@if \
		! xcrun \
			--sdk macosx \
			swift run \
				--package-path Tuist/Dependencies/SwiftPackageManager \
				--skip-build \
					swiftlint lint \
						--config .swiftlint.yml \
						. \
		2> /dev/null; \
	then \
		echo \
			"warning: SwiftLint not installed," \
			"execute \`make install\` at the root of the project."; \
	fi

test:
	@$(call check_tuist)
	@tuist test
