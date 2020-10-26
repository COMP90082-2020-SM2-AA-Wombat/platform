import io

from setuptools import find_packages
from setuptools import setup
import pkg_resources
import pathlib

with pathlib.Path('requirements.txt').open() as requirements_txt:
    install_requires = [
        str(requirement)
        for requirement
        in pkg_resources.parse_requirements(requirements_txt)
    ]
setup(
    name="flaskr",
    version="1.0.0",
    url="https://flask.palletsprojects.com/tutorial/",
    license="BSD",
    maintainer="lol",
    maintainer_email="contact@palletsprojects.com",
    description="The basic blog app built in the Flask tutorial.",
    long_description="readme",
    packages=find_packages(),
    include_package_data=True,
    zip_safe=False,
    install_requires=install_requires,
    extras_require={"test": ["pytest", "coverage"]},
)
