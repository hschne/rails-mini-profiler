# Changelog

## [0.6.0](https://www.github.com/hschne/rails-mini-profiler/compare/v0.5.0...v0.6.0) (2021-10-10)


### Features

* add copy button, fixes [#69](https://www.github.com/hschne/rails-mini-profiler/issues/69) ([9a91a3f](https://www.github.com/hschne/rails-mini-profiler/commit/9a91a3f70b35bc7bc96cb3a56116aa35c0d9d8a3))


### Bug Fixes

* do not profile actioncable and asset paths ([#65](https://www.github.com/hschne/rails-mini-profiler/issues/65)) ([72a1b06](https://www.github.com/hschne/rails-mini-profiler/commit/72a1b069b4fddedc81b40ce6b9528ea7b1852279))

## [0.5.0](https://www.github.com/hschne/rails-mini-profiler/compare/v0.4.0...v0.5.0) (2021-09-12)


### Features

* add request table filters, fixes [#53](https://www.github.com/hschne/rails-mini-profiler/issues/53) ([#61](https://www.github.com/hschne/rails-mini-profiler/issues/61)) ([2e86671](https://www.github.com/hschne/rails-mini-profiler/commit/2e86671c58bf3a451c5a813495693aec782725c8))
* add sequel trace filtering ([#64](https://www.github.com/hschne/rails-mini-profiler/issues/64)) ([007716e](https://www.github.com/hschne/rails-mini-profiler/commit/007716e8279d39511b8652f05f3cbedc723d09bb))
* improve checkbox behaviour ([4ffe202](https://www.github.com/hschne/rails-mini-profiler/commit/4ffe202149f48c73b20742094c84d310157baccf))


### Bug Fixes

* handle non-sprockets apps, fixes [#55](https://www.github.com/hschne/rails-mini-profiler/issues/55) ([#57](https://www.github.com/hschne/rails-mini-profiler/issues/57)) ([a80dbad](https://www.github.com/hschne/rails-mini-profiler/commit/a80dbad6505a5ad1ae8c737f80f586a3e5a7b10e))

## [0.4.0](https://www.github.com/hschne/rails-mini-profiler/compare/v0.3.0...v0.4.0) (2021-08-28)


### Features

* add support for older ruby versions, fixes [#48](https://www.github.com/hschne/rails-mini-profiler/issues/48) ([#49](https://www.github.com/hschne/rails-mini-profiler/issues/49)) ([97061c4](https://www.github.com/hschne/rails-mini-profiler/commit/97061c478da59f02975d88e2883e4a0e3bad4ef5))
* add support for rails 6.0, fixes [#52](https://www.github.com/hschne/rails-mini-profiler/issues/52) ([#51](https://www.github.com/hschne/rails-mini-profiler/issues/51)) ([63371f6](https://www.github.com/hschne/rails-mini-profiler/commit/63371f6558cb6009ff73a56a7f0e0fa3bccc46cd))


### Bug Fixes

* badge enabled and config ([#44](https://www.github.com/hschne/rails-mini-profiler/issues/44)) ([abf9487](https://www.github.com/hschne/rails-mini-profiler/commit/abf948711dcb1d82cbc02f342c2997d4b3c2e6d4))
* improve error handling for non-webpack setups ([9541976](https://www.github.com/hschne/rails-mini-profiler/commit/954197601531bd9bd3704db2c6a463e69e5b5819))

## [0.3.0](https://www.github.com/hschne/rails-mini-profiler/compare/v0.2.1...v0.3.0) (2021-08-21)


### Features

* add webpacker support, see [#8](https://www.github.com/hschne/rails-mini-profiler/issues/8) ([#39](https://www.github.com/hschne/rails-mini-profiler/issues/39)) ([a0f17f3](https://www.github.com/hschne/rails-mini-profiler/commit/a0f17f3088307474d7428fc8487c51fb2f0746cf))


### Bug Fixes

* cast json column to text on PostgreSQL ([#37](https://www.github.com/hschne/rails-mini-profiler/issues/37)) ([76d6ec2](https://www.github.com/hschne/rails-mini-profiler/commit/76d6ec209fb1f6a04e3e46e3c7d1f3c6ed369fdf))

### [0.2.1](https://www.github.com/hschne/rails-mini-profiler/compare/v0.2.0...v0.2.1) (2021-08-12)


### Bug Fixes

* limit vendor folder, fixes [#33](https://www.github.com/hschne/rails-mini-profiler/issues/33) ([e9facf4](https://www.github.com/hschne/rails-mini-profiler/commit/e9facf4c583a4742b162b9da177d443ef11adf08))

## [0.2.0](https://www.github.com/hschne/rails-mini-profiler/compare/v0.1.3...v0.2.0) (2021-08-12)


### Features

* serve assets locally, fixes [#17](https://www.github.com/hschne/rails-mini-profiler/issues/17) ([6f62d55](https://www.github.com/hschne/rails-mini-profiler/commit/6f62d5584f934e7e61fd0735c4ab00718f1be6c3))


### Bug Fixes

* improve storage configuration and docs, fixes [#27](https://www.github.com/hschne/rails-mini-profiler/issues/27) ([#28](https://www.github.com/hschne/rails-mini-profiler/issues/28)) ([68f1869](https://www.github.com/hschne/rails-mini-profiler/commit/68f18690b4f805f6826a5cacea60cd411089bc3e))

### [0.1.3](https://www.github.com/hschne/rails-mini-profiler/compare/v0.1.2...v0.1.3) (2021-08-02)


### Bug Fixes

* revert internalize external assets ([8719c0b](https://www.github.com/hschne/rails-mini-profiler/commit/8719c0b8bcb0babd42d322969fbbd5bbcdd9abeb))

### [0.1.2](https://www.github.com/hschne/rails-mini-profiler/compare/v0.1.1...v0.1.2) (2021-08-02)


### Bug Fixes

* add better support for api-only applications, fixes [#14](https://www.github.com/hschne/rails-mini-profiler/issues/14) ([8745c57](https://www.github.com/hschne/rails-mini-profiler/commit/8745c57f37218b24e097c1b1b323b7aeb52d03af))
* no method error for flamegraph, fixes [#20](https://www.github.com/hschne/rails-mini-profiler/issues/20) ([0cfc531](https://www.github.com/hschne/rails-mini-profiler/commit/0cfc531865ffc3a0086dc4d8671c4ca766c89481))
* package flamegraph assets with the gem, fixes [#21](https://www.github.com/hschne/rails-mini-profiler/issues/21) ([a4620c2](https://www.github.com/hschne/rails-mini-profiler/commit/a4620c2d912f11fa7fefc6d2b5b36d97789479e3))

### [0.1.1](https://www.github.com/hschne/rails-mini-profiler/compare/v0.1.0...v0.1.1) (2021-07-31)


### Bug Fixes

* fixes [#1](https://www.github.com/hschne/rails-mini-profiler/issues/1) ([851148c](https://www.github.com/hschne/rails-mini-profiler/commit/851148cd445f3ebb335c350b3f9a301240cc2831))
* fixes [#6](https://www.github.com/hschne/rails-mini-profiler/issues/6) ([537a2d3](https://www.github.com/hschne/rails-mini-profiler/commit/537a2d32c991d8f1b75c4393f3d36078010e2585))
