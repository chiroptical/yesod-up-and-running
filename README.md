## November Goals

- [x] Add `/about` to the nav-bar
- [x] Build a REST API that conforms to `swagger.yaml`
  - Idea borrowed from https://medium.com/swlh/restful-api-documentation-made-easy-with-swagger-and-openapi-6df7f26dcad
  - Goal: Start from a specification and implement it
  - Someday:
    - Maybe use https://hackage.haskell.org/package/aeson-better-errors
- [ ] Continue Yesod book next section: https://www.yesodweb.com/book/shakespearean-templates
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
