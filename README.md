Proxy methods: (logic and storage is separated)

1. external storage
2. transparent proxy
   upgrade function is in the proxy contract
3. universally upgradeable proxy (UUPS)
   upgrade function is in the logic/implementation contract
4. beacon proxy
   upgrade a lot of contracts at the same time
5. diamond proxy

Problems about proxy:

1. function collision
2. storage collision

Thanks Patrick Collins!
