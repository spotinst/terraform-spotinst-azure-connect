from setuptools import setup, find_packages

setup(
    name='spot-account-azure',
    version='0.1',
    packages=find_packages(),
    include_package_data=True,
    install_requires=[
        'Click',
        'spotinst-sdk2>=2.1.10'
    ],
    entry_points={
        'console_scripts': [
            'spot-account-azure=spot_account_azure:cli'
        ],
    },
)
