# Change Log

All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning].

This change log follows the recommendations of [keepachangelog].

## [Unreleased]

(no changes yet)

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
[Unreleased]: https://github.com/edib-tool/mix-edib/compare/v0.8.0...HEAD
[0.8.0]: https://github.com/edib-tool/mix-edib/compare/v0.8.0...v0.7.0
