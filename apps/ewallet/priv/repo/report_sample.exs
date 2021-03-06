# Copyright 2018-2019 OmiseGO Pte Ltd
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

alias EWallet.CLI

# :prod environment does not have a default :base_url value and should not have one.
# But we have a fallback value here so we can generate a friendly output message for seeding.
base_url = Application.get_env(:ewallet, :base_url) || "https://example.com"

# eWallet API
ewallet_swagger_ui_url = base_url <> "/api/client/docs"
ewallet_key         = Application.get_env(:ewallet, :seed_ewallet_key)
ewallet_api_key     = Application.get_env(:ewallet, :seed_ewallet_api_key)
ewallet_auth_token  = Application.get_env(:ewallet, :seed_ewallet_auth_token)

# Admin API
admin_api_swagger_ui_url = base_url <> "/api/admin/docs"
admin_api_key         = Application.get_env(:ewallet, :seed_admin_api_key)
admin_user            = Application.get_env(:ewallet, :seed_admin_user)
admin_auth_token      = Application.get_env(:ewallet, :seed_admin_auth_token)

CLI.heading("Trying out OmiseGO eWallet Server with sample data")

CLI.print("""
  As you have just run the seed with `--sample` option, we have generated some credentails below
  for you to try the endpoints easily.

  If you would like to seed the database with the minimum amount needed to start
  a production environment, we recommend running `mix seed` instead.

  ## Try eWallet API's Server endpoints

  1. Browse to `#{ewallet_swagger_ui_url}`
  2. Click the `Authorize` button
  3. Use the value below for `ProviderAuth`:

  ```
  OMGProvider #{Base.encode64(ewallet_key.access_key <> ":" <> ewallet_key.secret_key)}
  ```

  4. Try out Server endpoints such as /login, /user.create, etc.

  ## Try eWallet API's Client endpoints

  1. Browse to `#{ewallet_swagger_ui_url}`
  2. Click the `Authorize` button
  3. Use the value below for `ClientAuth`:

  ```
  OMGClient #{Base.encode64(ewallet_api_key.key <> ":" <> ewallet_auth_token.token)}
  ```

  4. Try out Client endpoints such as /me.get, /me.list_transactions, /me.logout, etc.

  ## Try Admin API's Client endpoints

  1. Browse to `#{admin_api_swagger_ui_url}`
  2. Click the `Authorize` button
  3. Use the value below for `ClientAuth`:

  ```
  OMGAdmin #{Base.encode64(admin_api_key.id <> ":" <> admin_api_key.key)}
  ```

  4. Try out Client endpoints such as /login, /password.reset, /password.update, etc.

  ## Try Admin API's User endpoints

  1. Browse to `#{admin_api_swagger_ui_url}`
  2. Click the `Authorize` button
  3. Use the value below for `UserAuth`:

  ```
  OMGAdmin #{Base.encode64(admin_api_key.id <> ":" <> admin_api_key.key <> ":" <> admin_user.id
    <> ":" <> admin_auth_token.token)}
  ```

  4. Try out User endpoints such as /account.create, /account.assign_user, /access_key.create, etc.
  """)
