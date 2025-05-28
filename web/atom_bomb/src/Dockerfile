FROM elixir:1.17.3

COPY . /atom_bomb/
WORKDIR /atom_bomb

RUN mix setup

CMD ["mix", "phx.server"]
