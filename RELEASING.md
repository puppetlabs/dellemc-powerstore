# Releasing the dellemc-powerstore module to the Puppet Forge

1. Verify that the module contains an updated [CHANGELOG.md] entry for the new release.
1. Make sure the latest pull requests has been approved and merged.
1. Go to [new release](https://github.com/puppetlabs/dellemc-powerstore/releases/new) on Github
1. Enter a new version tag into the `Tag version` field. The version tag should be of the form `vMAJOR.MINOR.PATCH` whereby the three numbers follow the [Semantic Versioning](https://semver.org/) scheme. Please note that although the version number consists of three numbers with dots in between, the *version tag* must start with the `v` character.
1. Choose the `main` branch as the release target.
1. Give the release a descriptive title.
1. Describe the release in the description field.
1. Press the `Publish release` button.

A Github Action [release workflow](.github/workflows/release.yml) will now start. It will do the following:

- Extract the new module version number from the tag.
- Modify the [metadata.json](metadata.json) file to contain the new version number and commit.
- Re-tag the new commit with the release tag.
- Publish the module on the forge under the `dellemc` account using the `FORGE_API_KEY` secret.
