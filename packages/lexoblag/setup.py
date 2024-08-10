from setuptools import find_packages, setup

setup(
	name="lektor-lexoblag",
	packages=find_packages(),
	py_modules=["lektor_lexoblag"],
	entry_points={
		"lektor.plugins": [
			"lexoblag = lektor_lexoblag:LexoblagPlugin",
		],
	},
)
