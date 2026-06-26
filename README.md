# Portfolio

Personal portfolio built with **Elm Land**, **Deno** and **SCSS**.

The project is a simple landing page focused on presenting selected projects, technical skills and contact information.

## Stack

* [Elm Land](https://elm.land) — frontend framework
* [Elm](https://elm-lang.org) — UI and application logic
* [SCSS](https://sass-lang.com) — styling
* [Deno](https://deno.com) — server/runtime

## Requirements

* Node.js 18+
* Deno
* Elm Land

## Local development

Install dependencies:

```bash
npm install
```

Run the Elm Land development server:

```bash
elm-land server
```

If the Deno server is being used locally:

```bash
deno task dev
```

## Build

Build the frontend:

```bash
elm-land build
```

Compile SCSS if needed:

```bash
npx sass src/scss/main.scss static/styles.css
```

## Production

The production version is served by a Deno server, which delivers the built static files and can also expose backend routes when needed.

Start the server:

```bash
deno task start
```

## Project structure

```bash
.
├── src/          # Elm Land pages and application code
├── static/       # Static assets and production build
├── server.ts     # Deno server
├── deno.json     # Deno tasks and configuration
└── README.md
```

## Author

João Costa

* GitHub: [@jotamath](https://github.com/jotamath)
* LinkedIn: [jotamath](https://linkedin.com/in/jotamath)

```
```
