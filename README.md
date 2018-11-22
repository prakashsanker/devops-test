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

### Start a new project

Do NOT use this repository. This is a BOILERPLATE that you use for future backend repositories.

1. Create a new repository (you should call it `project_name_goes_here-api`)
2. `git clone git@github.com:XelpmocDesignandTechPvtLtd/api-express-boilerplate.git`
3. `cd api-express-boilerplate`
4. `git remote set-url origin git@github.com:XelpmocDesignandTechPvtLtd/<project_name_goes_here-api`
5. `git push origin master`
6. REMEMBER to set the url back `git remote set-url origin git@github.com:XelpmocDesignandTechPvtLtd/api-express-boilerplate.git`. (THIS IS CRUCIAL DO NOT FORGET THIS)

### Install dependencies

You will need to either use yarn or npm. I strongly suggest using yarn, it is much faster than NPM.

You can install it here https://yarnpkg.com/en/

You can find the list of dependencies for any Node project in its `package.json` file. To install them, simply
run:

```
yarn install
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
yarn test
```

### lint

Uses [Prettier](https://github.com/prettier/prettier) and
[ESLint](https://eslint.org/)
to standardize coding style and check imports.

```
yarn run lint # shows lint errors
yarn run fix-lint # fixes lint errors, shows any remaining
```

### ... the development server

Run this command (which is defined in the `scripts` section of `package.json`):

```
yarn run dev-server
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

####  Development environment

You should all be using VSCode - https://code.visualstudio.com/

After you have installed it, go to the extensions button on the left. In the search bar, search for these extensions and install them. You need to refresh your workspace for these to take effect.

```
dbaeumer.vscode-eslint
esbenp.prettier-vscode
```

Then go to your vscode settings and add these -

```
"eslint.autoFixOnSave": true,
"prettier.eslintIntegration": true
```

### Pull Request Workflow

For every feature this is how you should work -

1. You are on master
2. `git pull`
3. `git checkout -b <branch_name>`
4. Make your changes
5. `git add -A`
6. `git commit -m "put in a commit message"`
7. The first time that you push a branch, you need to run `git push -u origin <branch_name>`
   For ALL OTHER TIMES, you just need to do `git push`
8. In Github, OPEN A NEW PULL REQUEST.
9. Get somebody (your team lead) to REVIEW THE CODE.


### ... the production server

Ensure all the proper environment variables are present, and then run:

```
yarn start
```

#### Required environment variables

Until you add more, these ones are *necessary* for a production deploy:

* `PRIVKEY_CERT_LOC` and `FULLCHAIN_CERT_LOC`: Location of
  SSL certificate files, as produced by LetsEncrypt's `autocert`
  script
* `JWT_SECRET`: The secret used to produce JSON Web Tokens

## Deploying

This comes with a default circle.yml configuration for circleci.

It's not perfect and it requires some setup with circle.

You can find instructions here, and these are up to date as of November 2018.

https://medium.com/@admm/ci-cd-using-circleci-and-google-kubernetes-engine-gke-7ed3a5ad57e

## Rollback

In order to achieve rollbacks you need to do two things

First is run this script

```
./setup-kube-config --cloudprovider=<"gcloud" | "aws">
```
All the information you need to fill out this file is in `circle.yml`

IF you are working on multiple projects, then you need to run the above script everytime you switch.

You can then run this in order to get the history of deployments

```
kubectl rollout history deployment.v1.apps/<PROJECT_NAME>
```

You then run this in order to rollback to an earlier version

```
kubectl rollout undo deployment.v1.apps/<PROJECT_NAME> --to-revision=<REVISION_NUMBER>
```

`PROJECT_NAME` can be found in the `circle.yml` file.





