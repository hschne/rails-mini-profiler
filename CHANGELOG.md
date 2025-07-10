# Changelog

## [0.8.0](https://github.com/hschne/rails-mini-profiler/compare/v0.7.3...v0.8.0) (2025-07-10)


### ⚠ BREAKING CHANGES

* move to importmaps ([#251](https://github.com/hschne/rails-mini-profiler/issues/251))
* update for Rails 8 ([#242](https://github.com/hschne/rails-mini-profiler/issues/242))

### Features

* update for Rails 8 ([#242](https://github.com/hschne/rails-mini-profiler/issues/242)) ([8722ae2](https://github.com/hschne/rails-mini-profiler/commit/8722ae2fa4276f263be671ce6bbdfdde6a9a3b13))


### Bug Fixes

* sanitize response body with null bytes ([#178](https://github.com/hschne/rails-mini-profiler/issues/178)) ([98ee2e3](https://github.com/hschne/rails-mini-profiler/commit/98ee2e3608562f0628b4653cc9f4b1b489544bc8))


### Miscellaneous

* allow up-to-date pagy versions ([b6d7c62](https://github.com/hschne/rails-mini-profiler/commit/b6d7c62459d6b95add831464ad3fefc997b8c239))
* change coverage path ([eeb1891](https://github.com/hschne/rails-mini-profiler/commit/eeb18914302763003fbc8c3bd0fae55d036e9215))
* move to importmaps ([#251](https://github.com/hschne/rails-mini-profiler/issues/251)) ([b9c3798](https://github.com/hschne/rails-mini-profiler/commit/b9c3798c77a8ca210e757550edc51b01204b3736))
* post-release 0.7.3 ([482b2b0](https://github.com/hschne/rails-mini-profiler/commit/482b2b0f7cb24dc178283d62fcd266222af48c53))
* remove inline svg dependency ([#243](https://github.com/hschne/rails-mini-profiler/issues/243)) ([f41de05](https://github.com/hschne/rails-mini-profiler/commit/f41de05be94a3e7ada5c6776c0e6c921f759b822))
* remove pagy dependency ([#244](https://github.com/hschne/rails-mini-profiler/issues/244)) ([7e90b56](https://github.com/hschne/rails-mini-profiler/commit/7e90b566f9795d63e8a625831f8e8bb1d8951334))
* update codelimate action ([6a86568](https://github.com/hschne/rails-mini-profiler/commit/6a86568ed7edb4cda4126e36d93af44d71712cf0))

## [0.7.3](https://github.com/hschne/rails-mini-profiler/compare/v0.7.2...v0.7.3) (2022-10-23)


### Bug Fixes

* sanitize null bytes in request body ([#173](https://github.com/hschne/rails-mini-profiler/issues/173)) ([12c8358](https://github.com/hschne/rails-mini-profiler/commit/12c8358c2ced76084d38e750d750732417070e01))


### Miscellaneous

* post-release 0.7.2 ([7a34f5d](https://github.com/hschne/rails-mini-profiler/commit/7a34f5de1567bd63f984e7e9a962422bd29c7f0b))
* update speedscope ([#174](https://github.com/hschne/rails-mini-profiler/issues/174)) ([3352624](https://github.com/hschne/rails-mini-profiler/commit/3352624668dd5e914c44c91971a29dd8b5b7f9b9))

## [0.7.2](https://github.com/hschne/rails-mini-profiler/compare/v0.7.1...v0.7.2) (2022-06-13)


### Bug Fixes

* add charset to table definitions ([#150](https://github.com/hschne/rails-mini-profiler/issues/150)) ([1dab8a8](https://github.com/hschne/rails-mini-profiler/commit/1dab8a873ce2908af5f87039d300d85765a9cd29))
* display milliseconds, matching given labels ([#127](https://github.com/hschne/rails-mini-profiler/issues/127)) ([6f4e7b7](https://github.com/hschne/rails-mini-profiler/commit/6f4e7b762e30a11b027cd3fcdbb799ae9707b4ec))
* use event.duration directly ([7968965](https://github.com/hschne/rails-mini-profiler/commit/7968965d3c234746d0de2c2b407fecfb524aa05d))


### Miscellaneous

* add bundler binstubs to remove bundle exec ([1c4178c](https://github.com/hschne/rails-mini-profiler/commit/1c4178c76e94fa764e0f4d2bad81348a719f5d68))
* make Rails 7 default development version ([#129](https://github.com/hschne/rails-mini-profiler/issues/129)) ([5e78c83](https://github.com/hschne/rails-mini-profiler/commit/5e78c83cf6941d9f2ed9ccf7951a8ccea2c62510))
* post-release 0.7.1 ([82ecb6b](https://github.com/hschne/rails-mini-profiler/commit/82ecb6b429f9b944dbc48596dc19578998149d9b))
* remove built-in gemfile helper ([0e888c2](https://github.com/hschne/rails-mini-profiler/commit/0e888c25ce8d2a5c048a85ddda35f49d3e1045bc))
* update commitlint config ([7e45bba](https://github.com/hschne/rails-mini-profiler/commit/7e45bba5b60a579822445025000ae9625c41e053))

### [0.7.1](https://github.com/hschne/rails-mini-profiler/compare/v0.7.0...v0.7.1) (2022-01-30)


### Bug Fixes

* deprecated autoloading, fixes [#110](https://github.com/hschne/rails-mini-profiler/issues/110) ([253a6e9](https://github.com/hschne/rails-mini-profiler/commit/253a6e9384047b06910f5b439c4b1a7354bfcfaa))
* improve robustness when saving profiled requests, fixes [#86](https://github.com/hschne/rails-mini-profiler/issues/86) ([#118](https://github.com/hschne/rails-mini-profiler/issues/118)) ([8781898](https://github.com/hschne/rails-mini-profiler/commit/87818981d6af08c56729695def04d7232c00bfcd))
* response without body, see [#115](https://github.com/hschne/rails-mini-profiler/issues/115) ([#116](https://github.com/hschne/rails-mini-profiler/issues/116)) ([baad01f](https://github.com/hschne/rails-mini-profiler/commit/baad01f4009a91353577c09c48a2a64b8e2b3227))


### Miscellaneous

* fix contributing ([da83e62](https://github.com/hschne/rails-mini-profiler/commit/da83e62d7e44fab998b13f2682a070081731c7c3))
* fix updating version file ([c70002c](https://github.com/hschne/rails-mini-profiler/commit/c70002cb8bfe63259430053fcb0463a97be19223))
* fix version ([9452a87](https://github.com/hschne/rails-mini-profiler/commit/9452a87b0143c2ce7d0e0c1320f1d17e847c3547))
* modularize tracers ([#112](https://github.com/hschne/rails-mini-profiler/issues/112)) ([add2ec4](https://github.com/hschne/rails-mini-profiler/commit/add2ec4647609f442bc4c78b68524bfacf617738))
* post-release 0.7.0 ([da80f06](https://github.com/hschne/rails-mini-profiler/commit/da80f06509303e12a9ea74e5befadd1274893302))
* request/response wrappers ([#117](https://github.com/hschne/rails-mini-profiler/issues/117)) ([28def20](https://github.com/hschne/rails-mini-profiler/commit/28def20213bbb534493b69ee4c8baeeb907354ff))
* update release info ([2a12afd](https://github.com/hschne/rails-mini-profiler/commit/2a12afd3d65183c9f90037279ae59464e3ef201c))

## [0.7.0](https://www.github.com/hschne/rails-mini-profiler/compare/v0.6.0...v0.7.0) (2021-11-27)


### Features

* add trace filtering, closes [#67](https://www.github.com/hschne/rails-mini-profiler/issues/67) ([2722f92](https://www.github.com/hschne/rails-mini-profiler/commit/2722f92b8c7dad14b89a64716b28dc6a960b0992))


### Bug Fixes

* authentication thread issue, fixes [#99](https://www.github.com/hschne/rails-mini-profiler/issues/99) ([db62984](https://www.github.com/hschne/rails-mini-profiler/commit/db62984cf306b94db4c97808f303b0d3959b4afd))
* production profiling authentication, fixes [#93](https://www.github.com/hschne/rails-mini-profiler/issues/93) ([#98](https://www.github.com/hschne/rails-mini-profiler/issues/98)) ([98f515b](https://www.github.com/hschne/rails-mini-profiler/commit/98f515b8519b88cb2383b22e5cd5762ccf831cdb))

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
