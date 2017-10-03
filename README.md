# express-api-boilerplate

Boilerplate for an API written in Express, based on some previous projects. It includes:

* Documentation and examples on how to use this boilerplate
  effectively
* Full ES6/ES7 support via Babel/Babel Polyfill.
* Code to force using SSL on production servers (your job to get
  the proper certs, I suggest getting free ones using
  [LetsEncrypt](https://letsencrypt.org/))
* Some basic code for creating and validating JSON web tokens
* Jest testing, and Prettier/ESLint linting already set up, with
  NPM scripts to invoke them.
* Automatic code reloading when code changes
* Debugger configuration

## Installation

### Install node

* OSX: `brew install node`
* Ubuntu: `apt-get install nodejs`

### Clone the repository

1. Pull the repository: `git clone git@github.com:osdiab/express-api-boilerplate.git`
1. Enter the directory: `cd express-api-boilerplate`

### Install dependencies

The Node Package Manager (`npm`) manages library dependencies for you in Node projects. You can find
the list of dependencies for any Node project in its `package.json` file. To install them, simply
run:

```
npm install
```

This will download all the Node libraries you need, and place them into the `node_modules/`
directory at the base of the project. `node` can access them so long as you run it in somewhere in
the project dir; if you want to see for yourself, open the Node REPL by running `node` with no
arguments while in the project directory, and try running `const l = require('lodash')`—it will
place the `lodash` library in the `l` variable.

## Running...

### tests

Uses the [Jest test runner](https://facebook.github.io/jest/) to
run tests.

```
npm test
```

### lint

Uses [Prettier](https://github.com/prettier/prettier) and
[ESLint](https://eslint.org/)
to standardize coding style and check imports.

```
npm run-script lint # shows lint errors
npm run-script fix-lint # fixes lint errors, shows any remaining
```

### ... the development server

Run this command (which is defined in the `scripts` section of `package.json`):

```
npm run-script dev-server
```

Et voilà! Visit [localhost:3000](http://localhost:3000) to see everything in action.

#### Debugger

If you are using VSCode, after running the dev server in your
terminal, you can attach the VSCode debugger by clicking the
debug panel and then hitting the play button using the
"Attach debugger" configuration.

Otherwise, you can figure out how to attach your own debugger to
Node's built-in inspector, which should work on port 9229. I hear
you can use Chrome to do this, but I haven't researched how.

To insert a breakpoint, just add the line `debugger` to your code.

#### Suggested development environment

I believe it is very useful to lint your code as you write it.
So, whatever editor you use, make sure to set up ESLint and
Prettier to run automatically and preferably automatically
fix your code.

In VSCode, you can do that by installing the ESLint and Prettier
add-ons. Then, add these values to your preferences:

```
"eslint.autoFixOnSave": true,
"prettier.eslintIntegration": true
```

### ... the production server

Ensure all the proper environment variables are present, and then run:

```
npm start
```

#### Required environment variables

Until you add more, these ones are necessary for a production deploy:

* `PRIVKEY_CERT_LOC` and `FULLCHAIN_CERT_LOC`: Location of
  SSL certificate files, as produced by LetsEncrypt's `autocert`
  script
* `JWT_SECRET`: The secret used to produce JSON Web Tokens

## Deploying

This is for you to figure out for your own setup, but as a suggestion you can
use the [`pm2` npm library](https://github.com/Unitech/pm2) to manage deployments
on a dedicated server.
