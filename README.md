<!-- <a href="http://www.tomerzaidler.com"><img src="https://avatars3.githubusercontent.com/u/50677880?s=460&u=d57cc592bedd144f97deb17f535b6e793f8cb27c&v=4" title="Tomer Zaidler" alt="Tomer Zaidler"></a>
Tomer Zaidler -->


# Find Bad Commit

> Find a bad commit using <a href="https://git-scm.com/docs/git-bisect" target="_blank">git bisect</a>

---

## Table of Contents 

- [Setup](#Setup)
- [Run](#Run)
- [Team](#team)
- [Support](#support)
- [License](#license)


---

### Setup

- Set all the environment variables that found in load-environment-variables.sh

> Example:

```bash
export PROJECT_PATH="..../projects/rapyd-search"; # Represents the project full path
export TEST_PATH="..../projects/find-bad-commit/test.sh"; # Represents test script full path
export KNOWN_BAD_COMMIT="448197801a46155f1d97738e5a7c4d55386e6da4"; # Represents the bad commit hash ID (from the given project)
export KNOWN_GOOD_COMMIT="c5367dd415b843f5d60f65554b2d44c974bf3f43"; # Represents the good commit hash ID (from the given project)
```
---

### Run

* Make sure to complete all the steps from the "Setup" stage before running.

```bash
npm start
```

---

## Team


**Tomer Zaidler**

<a href="https://github.com/tomerzaidler"><img src="https://avatars3.githubusercontent.com/u/50677880?s=460&u=d57cc592bedd144f97deb17f535b6e793f8cb27c&v=4?s=200" title="Tomer Zaidler" alt="Tomer Zaidler"></a> 


---

## Support

Reach out to me at one of the following places!

- Website at <a href="http://www.tomerzaidler.com" target="_blank">`tomerzaidler.com`</a>
- Email: tomerzaidler@gmail.com

---

## License


- **[MIT license](http://opensource.org/licenses/mit-license.php)**
- Copyright 2015 © <a href="http://www.tomerzaidler.com" target="_blank">Tomer Zaidler</a>.
