'''
Fix SNI support in SaltStack
'''

# Attempt to enable urllib3's SNI support, if possible
try:
    from urllib3.contrib import pyopenssl
    pyopenssl.inject_into_urllib3()
except ImportError:
    pass
