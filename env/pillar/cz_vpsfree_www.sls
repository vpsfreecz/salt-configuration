cz_vpsfree_www:
  nginx_vhosts:
    'vpsfree.cz':
      ssl: True
      crt: 'bundle.crt'
      crt_key: 'vpsfree.cz.key.nopass'
    'kb.vpsfree.cz':
      ssl: True
      crt: 'bundle.crt'
      crt_key: 'vpsfree.cz.key.nopass'
