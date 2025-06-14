docker run -d -p 3000:3000 \
  -e "MB_DB_TYPE=postgres" \
  -e "MB_DB_DBNAME=metabase" \
  -e "MB_DB_PORT=5432" \
  -e "MB_DB_USER=gengsu07" \
  -e "MB_DB_PASS='Gengsu!sh3r3'" \
  -e "MB_DB_HOST= dbstack-postgres-1" \
  --network  dbstack_default \
  --name metabase metabase/metabase


version: "3.1"
services:
    metabase:
    image: metabase/metabase
    ports:
      - 3000:3000
    environment:
      - MB_DB_TYPE=postgres
      - MB_DB_DBNAME=metabase
      - MB_DB_USER=gengsu07
      - MB_DB_PASS=Gengsu!sh3r3
      - MB_DB_HOST=postgres
    network:
      name: metabase
  
    postgres-metabase:
    image: postgres
    restart: always
    ports:
    - 5433:5432
    environment:
     -POSTGRES_USER: gengsu07
        POSTGRES_PASSWORD: Gengsu!sh3r3
        POSTGRES_DB: metabase
        network:
        name: metabase

networks:
  metabase:
    driver: bridge