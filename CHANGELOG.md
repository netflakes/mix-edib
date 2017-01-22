# Change Log

All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning].

This change log follows the recommendations of [keepachangelog].

## [Unreleased]

(no changes yet)

## [0.10.0] - 2017-01-22

### Notes

- This version requires Elixir v1.4 or newer.
- This version requires Distillery v1.1 or newer.

### Changed

- Update edib-tool to version 1.6.0.
- Update outdated dependencies.
- Cleanups and documentation fixes.

## [0.9.0] - 2016-10-04

### Changed

- Update edib-tool to version 1.4.0, this replaces `exrm` with `distillery`.
- Update outdated dependencies.

## [0.8.3] - 2016-09-20

### Fixed

- Documentation, no code changes

## [0.8.2] - 2016-09-20

(Not released as hex package! Use 0.8.3 instead.)

### Added

- Support for building with the provided environment
  (instead of defaulting to `prod` only) - PR #14 (thanks @migore)

## [0.8.1] - 2016-06-29

### Fixed

- Update edib-tool to version 1.3.2 to fix an issue with the hex
  registry data within the running container.

## [0.8.0] - 2016-06-29

### Changed

- Update the edib-tool image version to 1.3.1, which uses Elixir 1.3.

  Currently this image is (still) based on Erlang/OTP 18.3, since the package
  for Alpine was not updated yet.

- Enforce minimum version for Elixir: ~> 1.3

  Since the edib-tool is using 1.3 only, we also enforce this version on the
  host level where this tool will be running.
  This will act as a guard for potential build errors, where the project might
  not succeed because of old requirements.

  Also Elixir 1.2.5 is removed from the Travis CI builds.

- Update all outdated dependencies (chore).

  Specifically espec broke sometime in between, but the issues were resolved.

- Add deps badge for hexfaktor.org (thanks @rrrene)

## 0.7.0 - 2016-05-15

No history present prior this point.

PRs for updating the change log history are very welcome!


[Semantic Versioning]: http://semver.org/
[keepachangelog]: http://keepachangelog.com/
[Unreleased]: https://github.com/edib-tool/mix-edib/compare/v0.9.0...HEAD
[0.9.0]: https://github.com/edib-tool/mix-edib/compare/v0.9.0...v0.8.3
[0.8.3]: https://github.com/edib-tool/mix-edib/compare/v0.8.3...v0.8.2
[0.8.2]: https://github.com/edib-tool/mix-edib/compare/v0.8.2...v0.8.1
[0.8.1]: https://github.com/edib-tool/mix-edib/compare/v0.8.1...v0.8.0
[0.8.0]: https://github.com/edib-tool/mix-edib/compare/v0.8.0...v0.7.0
