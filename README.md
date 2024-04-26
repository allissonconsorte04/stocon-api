run 
docker compose up

In another terminal, run:
docker compose run web rake db:create
docker compose run web rake db:migrate