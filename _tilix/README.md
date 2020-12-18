# Tilix Configuration

`Tilix` makes use of GNOMEs `dconf` to store configuration data.

`dconf` is required (`apt-get install dconf-cli`)

```sh
# restore / load
dconf load /com/gexperts/Tilix/ < tilix.dconf

# backup
dconf dump /com/gexperts/Tilix/ > tilix.dconf
```

see also: https://github.com/gnunn1/tilix#migrating-settings-from-terminix
