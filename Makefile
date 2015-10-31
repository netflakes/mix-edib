all:
	@echo Use publish, archive or gitio

publish:
	@mix hex.publish && \
	MIX_ENV=docs mix hex.docs

archive:
	@mix compile && mix archive.build

gitio:
	@[ -n "$(VERSION)" ] && \
	curl -i http://git.io \
		-F "url=https://github.com/asaaki/mix-edip/releases/download/v$(VERSION)/edip-$(VERSION).ez" \
		-F "code=edip-$(VERSION).ez" || \
	echo "No version set. (VERSION=x.y.z)"

todos:
	@find `pwd` \
		-type f \
		\( -name "*.ex" -o -name "*.exs" \) \
		-exec \
			grep -H -n -A1 --color=always -E "FIXME|NOTE|TODO|WIP|WTF|XXX" {} +
