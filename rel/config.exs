# Import all plugins from `rel/plugins`
# They can then be used by adding `plugin MyPlugin` to
# either an environment, or release definition, where
# `MyPlugin` is the name of the plugin module.
~w(rel plugins *.exs)
|> Path.join()
|> Path.wildcard()
|> Enum.map(&Code.eval_file(&1))

use Mix.Releases.Config,
    # This sets the default release built by `mix release`
    default_release: :default,
    # This sets the default environment used by `mix release`
    default_environment: Mix.env()

# For a full list of config options for both releases
# and environments, visit https://hexdocs.pm/distillery/config/distillery.html


# You may define one or more environments in this file,
# an environment's settings will override those of a release
# when building in that environment, this combination of release
# and environment configuration is called a profile

environment :dev do
  # If you are running Phoenix, you should make sure that
  # server: true is set and the code reloader is disabled,
  # even in dev mode.
  # It is recommended that you build with MIX_ENV=prod and pass
  # the --env flag to Distillery explicitly if you want to use
  # dev mode.
  set dev_mode: true
  set include_erts: false
  set cookie: :"7z>MXzl!PzpU6XV<D|SB,UWL>QQd{@(/=O1WF=jnM8<B{_3Ub7&BHM2;21|VV4*y"
end

environment :prod do
  set include_erts: true
  set include_src: false
  set cookie: :"diy7,@9[~V7:2]ALlC)$a0>,^,R3]t8`T}6/h1~>;WN(u<T0(?5yw4uF3g%VF{;s"

  set config_providers: [
    {Mix.Releases.Config.Providers.Elixir, ["${RELEASE_ROOT_DIR}/etc/config.exs"]}
  ]
  set overlays: [
    {:copy, "rel/config/config.exs", "etc/config.exs"}
  ]
end

# You may define one or more releases in this file.
# If you have not set a default release, or selected one
# when running `mix release`, the first release in the file
# will be used by default

release :olivetree_umbrella do
  set version: current_version(:olivetree)
  set applications: [
    :runtime_tools,
    db: :permanent,
    olivetree: :permanent,
    olivetree_jobs: :permanent,
    olivetree_api: :permanent
  ]
  set commands: [
    generate_hash_ids: "rel/commands/generate_hash_ids.sh",
    migrate: "rel/commands/migrate.sh",
    seed: "rel/commands/seed.sh"
  ]
end

