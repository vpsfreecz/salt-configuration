cz_vpsfree_www:
  root_authorized_keys: ['snajpa', 'aither', 'medved', 'jarin']
  nginx_vhosts:
    'vpsfree.cz':
      ssl: True
      crt: 'bundle.crt'
      crt_key: 'vpsfree.cz.key.nopass'
    'kb.vpsfree.cz':
      ssl: True
      crt: 'bundle.crt'
      crt_key: 'vpsfree.cz.key.nopass'
