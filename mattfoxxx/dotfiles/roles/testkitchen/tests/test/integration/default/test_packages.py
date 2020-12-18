import pytest


@pytest.mark.parametrize("package_name", [
    "zsh",
    "ruby",
    "go",
    "go-tools",
    "terraform",
    "terragrunt",
])
def test_packages_installed(host, package_name):
    pkg = host.package(package_name)
    assert pkg.is_installed
