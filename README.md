## November Goals

- [ ] Add `/about` to the nav-bar
- [ ] Build a REST API on `/person`
  - `GET /person?name=...&age=...&address=...`
  - `POST /person` with
  ```json
  {
    "name": "chiroptical",
    "age": 32,
    "address": "somewhere"
  }
  ```
  - `PUT /person` with
  ```json
  {
    "id": 1,
    "name": "chiroptical",
    "age": 32,
    "address": "somewhere else"
  }
  ```
  - `DELETE /person` with
  ```
  {
    "id": 1,
    "name": "chiroptical",
    "age": 32,
    "address": "somewhere else"
  }
  ```
- [ ] Something with cryponite
- [ ] Something with megaparsec
- [ ] Something with unliftio

## Database Setup

After installing Postgres, run:

```
createuser yesod --pwprompt --superuser
# Enter password yesod when prompted
createdb yesod_uar
createdb yesod_uar-test
```

## Haskell Setup

1. If you haven't already, [install Stack](https://haskell-lang.org/get-started)
	* On POSIX systems, this is usually `curl -sSL https://get.haskellstack.org/ | sh`
2. Install the `yesod` command line tool: `stack install yesod-bin --install-ghc`
3. Build libraries: `stack build`

If you have trouble, refer to the [Yesod Quickstart guide](https://www.yesodweb.com/page/quickstart) for additional detail.

## Development

Start a development server with:

```
stack exec -- yesod devel
```

As your code changes, your site will be automatically recompiled and redeployed to localhost.

## Tests

```
stack test --flag yesod-up-and-running:library-only --flag yesod-up-and-running:dev
```

(Because `yesod devel` passes the `library-only` and `dev` flags, matching those flags means you don't need to recompile between tests and development, and it disables optimization to speed up your test compile times).