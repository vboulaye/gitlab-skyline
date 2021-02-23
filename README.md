This is a fork of the gitlab-skyline project to allow generating a skyline from a git repo (my gitlab instance does not give me access to the contribution api)

To get the "contributions" file, use one of ` git log` scripts inside a repo:

either get the commits count:
```
GIT_DIR=/path/to/git/repo/.git ./git-changed-count.sh "author" year >repo.log
```

or the number of changed lines:
```
GIT_DIR=/path/to/git/repo/.git ./git-changed-count.sh "author" year >repo.log
```

then run the generation script with the --gitlog parameter set to the repo log file:

```
./gitlab-skyline vbo 2020 --gitlog repo.log -
```

![git_vbo_2020.png](images/sample_repo_file.png)

You can also use additional flags to make the file "prettier".
- --max_height defines a max height for the talles buildings
- --applyLog apply a logarithm function to the counter

```
./gitlab-skyline vbo 2020 --gitlog repo.log --max_height 40 --applyLog true
```

![model generated from a commmit count + log() + normalized to 40](images/sample_repo_file_normalized.png)


# Your Gitlab's contributions in a 3D Skyline

`gitlab-skyline` is a Python command to generate a skyline figure from Gitlab contributions as Github did at https://skyline.github.com/

```
~ usage: gitlab-skyline [-h] [--domain [DOMAIN]] [--max_requests [MAX_REQUESTS]] username [year]

Create STL from Gitlab contributions

positional arguments:
  username              Gitlab username (without @)
  year                  Year of contributions to fetch

optional arguments:
  -h, --help            show this help message and exit
  --domain [DOMAIN]     GitlabEE/CE custom domain
  --max_requests [MAX_REQUESTS]
                        Max. simultaneous requests to Gitlab. Don't mess with their server!

Enjoy!

```
View a sample result of the preview at [samples/gitlab_felixgomez_2020.stl](samples/gitlab_felixgomez_2020.stl) and OpenSCAD generated code at [samples/gitlab_felixgomez_2020.scad](samples/gitlab_felixgomez_2020.scad).

<img src="images/cura_sample.png" width="800">

# Requirements and installation

`gitlab-skyline` requires python3 and OpenSCAD.


Create your virtual environment as usual and install dependencies with
```
pip install -r requirements.txt
```

Install OpenSCAD from https://www.openscad.org/downloads.html and ensure that openSCAD executable is working with
```
openscad --version
```

<img src="images/openscad_sample.png" width="800">

# Quickstart
```
python gitlab-skyline felixgomez 2020
```
or
```
./gitlab-skyline felixgomez 2020
```

if file has execution permissions.

If you want to get contributions from a custom installation you can use

```
./gitlab-skyline felixgomez 2020 --domain="https://customdomain.dev:8080"
```

# Using it in private/custom Gitlab installations

As said before, you can use it in custom installations through the `--domain` modifier.

**Don't forget to make your contributions public in your user profile settings.**

![](images/profile_settings.png)
![](images/gitlab_profile_info.png)

# Motivation

A few days ago I came across the Github skyline web application and it seemed like a good idea to be able to export the activity in skyline format to STL.

It quickly became viral among my friends, but in my daily work I use Gitlab more. That's when I came up with the idea to replicate it for Gitlab: I **needed** to have my own contribution skyline!

# Some details 

> The project was developed on a Friday afternoon, although I had consulted some information previously, so do not expect quality code and wonders. As always **pull requests are welcome!** 😍

At first I was thinking to use the well known Gitlab endpoint `https://gitlab.com/users/username/calendar.json` but the information it provides is for one year back from now.

As far as I know Gitlab does not provide an endpoint to obtain contribution information by year but digging a bit I found that a call to `https://gitlab.com/users/username/calendar_activities?date=2021-02-01` returns an HTML response easy to scrape.

I made use of classic [`BeautifulSoup`](https://www.crummy.com/software/BeautifulSoup/) for scraping, [`aiohttp`](https://docs.aiohttp.org/en/stable/) and [`asyncio`](https://docs.python.org/3/library/asyncio.html) to go asynchronous and speed up the scraping process.

There is an extra option (`--max-requests`) to the `gitlab-skyline` command to control concurrent requests to Github to avoid the *"Too many requests"* message from their server.

[`SolidPython`](https://github.com/SolidCode/SolidPython) is a beautiful piece of code allowing to generate OpenSCAD code from Python.

[`Numpy`](https://numpy.org/) wasn't really necessary, but it makes matrix calculations (like ordering) much easier.

[`Inkscape`](https://inkscape.org/) was used to vectorize the Gitlab logo for extrusion (pending to correct the Viewbox due to lack of time).

# Mesh optimization

I love openSCAD for a long time but there are some old well known issues related with errors in the generated geometry. If you detect some on the final STL you could use https://www.meshlab.net/ to correct them.

# Thanks!

I hope you like it!
