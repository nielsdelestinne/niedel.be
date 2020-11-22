---
layout: post
title:  "Build a static website with a custom theme using Jekyll"
date:   2020-09-20
author: "Niels Delestinne"
categories: website jekyll
comments: true
---

Jekyll is a blog-enabled static site generator that cleanly separates content from mark-up. 
It renders these source files into static pages ready for deployment. Sounds good? Great, I'll help you set it up.

## Installation 

Jekyll is written in Ruby and requires Ruby to be installed on your local development environment.
1. Download & install [Ruby](https://www.ruby-lang.org/en/downloads/), The version used for this tutorial was 2.7.1
2. Validate the installation by checking its version: `ruby -v`
2. Ruby will come packaged with RubyGem, validate the installation by checking its version: `gem -v`

Jekyll is a so-called Gem, which is a 'distribution' or 'artifact' in Ruby's ecosystem. 
It contains the code and documentation of an application or library.
Once installed, we can install the Jekyll & [Bundler](https://rubygems.org/gems/bundler) Gems: 
{% highlight text %}
gem install jekyll bundler
{% endhighlight %}

## Initialization

The next step is to generate the technical skeleton for the new website we want to create.

Create a new Jekyll website by using the Jekyll Gem:
{% highlight text %}
jekyll new your-new-website
{% endhighlight %}

A new directoy `./your-new-website` is created.

When executing a command, it's always interesting to inspect the output. 
For the `new` command of `jekyll`, we detect all the (transitive) dependencies that are downloaded and installed:
- 35 gems (dependencies) are installed
- The version of Jekyll we are depending on is 4.1.1. 

{% highlight text %}
Running bundle install in path:/your-new-website...
  Bundler: Fetching gem metadata from https://rubygems.org/..........
  Bundler: Fetching gem metadata from https://rubygems.org/.
  Bundler: Resolving dependencies...
  Bundler: Using public_suffix 4.0.6
  Bundler: Using addressable 2.7.0
  Bundler: Using bundler 2.1.4
  Bundler: Using colorator 1.1.0
  Bundler: Using concurrent-ruby 1.1.7
  Bundler: Using eventmachine 1.2.7 (x64-mingw32)
  Bundler: Using http_parser.rb 0.6.0
  Bundler: Using em-websocket 0.5.1
  Bundler: Using ffi 1.13.1 (x64-mingw32)
  Bundler: Using forwardable-extended 2.6.0
  Bundler: Using i18n 1.8.5
  Bundler: Using sassc 2.4.0 (x64-mingw32)
  Bundler: Using jekyll-sass-converter 2.1.0
  Bundler: Using rb-fsevent 0.10.4
  Bundler: Using rb-inotify 0.10.1
  Bundler: Using listen 3.2.1
  Bundler: Using jekyll-watch 2.2.1
  Bundler: Using rexml 3.2.4
  Bundler: Using kramdown 2.3.0
  Bundler: Using kramdown-parser-gfm 1.1.0
  Bundler: Using liquid 4.0.3
  Bundler: Using mercenary 0.4.0
  Bundler: Using pathutil 0.16.2
  Bundler: Fetching rouge 3.23.0
  Bundler: Installing rouge 3.23.0
  Bundler: Using safe_yaml 1.0.5
  Bundler: Using unicode-display_width 1.7.0
  Bundler: Using terminal-table 1.8.0
  Bundler: Using jekyll 4.1.1
  Bundler: Using jekyll-feed 0.15.0
  Bundler: Using jekyll-seo-tag 2.6.1
  Bundler: Using minima 2.5.1
  Bundler: Using thread_safe 0.3.6
  Bundler: Using tzinfo 1.2.7
  Bundler: Using tzinfo-data 1.2020.1
  Bundler: Using wdm 0.1.1
  Bundler: Bundle complete! 6 Gemfile dependencies, 35 gems now installed.
  Bundler: Use `bundle info [gemname]` to see where a bundled gem is installed.
New jekyll site installed in path:/your-new-website.
{% endhighlight %}

Navigate inside the newly created directory using `cd your-new-website`. 
The directory structure looks as follows:
{% highlight text %}
your-new-website/
|--- _posts/
    |--- 2020-09-14-welcome-to-jekyll.markdown
|--- 404.html
|--- _config.yml
|--- Gemfile
|--- Gemfile.lock
|--- index.markdown
{% endhighlight %} 

So, let's provide a brief overview on what's what:

**_posts/** directory 
- Contains the blog posts. 
- A single markdown file represents a single blog post.
- The name of the markdown file follows the following naming convention: `yyyy-MM-dd-title.md` (or use extension `.markdown`, be consistent though).
- The markdown file contains some meta information for the blog post (title, tags, publishing date,...) and its actual content. 

**404.html**:
- Is returned as the response whenever the provided page-url could not be resolved (not found).
- Can be customized; some inspiration can be found on the [GitHub 404](https://github.com/i-am-lost-404-me) page.

**Gemfile**(.lock) 
- Contains the dependencies (gems & their specific version) required for building & running the Jekyll website. Although not entirely the same, it's relatively similar to NPM's `package.json` file.

**index.markdown**
- Represents the index (home) page and contains its content.

**_config.yml** 
- Contains the configuration of your website (settings, variables, activated plugins, meta information,...)

> Besides configuration and content, there is no actual HTML or (S)CSS contained in the project directory. This demonstrates Jekyll's clean separation of content and mark-up.
 
Render the website and take a peek at what it looks like on [http://127.0.0.1:4000/](http://127.0.0.1:4000/):

![Default Theme](/assets/img/2020-09-20/default-theme.jpg)

Closely look at your project directory, a new directory `_site` will have emerged. It contains your generated website, 
which consists of static files only (html, css & images). These will be the files you eventually deploy and the files that will 
be served and downloaded by browsers when they make a request to your web-server. 

## Version Control

If you have been following along, now is the ideal time to put the project under version control and commit the generated scaffolding.
I am using Git and thus will use command `git init`, in the project's root directory, to initialize a local repository. 

Before committing your changes, make sure to create a `.gitignore` file to exclude the `_site` directory and any `cache` directories.
It should look something like this:
 
{% highlight text %}
/_site
/.jekyll-cache
/.sass-cache
/.idea
**/*.iml
{% endhighlight %}

After having added the `.gitignore` file:
1. Add all the files to the stage using `git add .`
2. Commit the changes using `git commit -m "a descriptive message"`
 
## Custom Theme

The website is looking the way it looks due to the Minima template, it's the default template of Jekyll.
It's a so called gem-based theme, and your current website references it.

Themes always consist of (s)css files, layouts, includes (a header, a footer and a sidebar among others) and other assets. 
A gem-based theme hides these files inside of the gem itself. When building your website, 
these theme files will be processed and included in your `_site` directory.

The major advantage of these themes is that you can update to a newer version or switch to a different theme very easily.
It's ideal for content-writers who don't want to worry too much about the website itself.

Although it is possible to override parts of a gem-based theme, we are going to convert the gem-based theme minima into 
a custom theme encapsulated within our project.

In order to do so, we will have to...
1. Copy the minima theme files to our project's root directory
2. Perform some clean-up by removing the references to the minima theme in our `Gemfile` and `_config.yml` file. 

### Copy theme files

In order to copy the minima theme files, we need to locate the installation directory of the minima gem.
Execute the following command in order to locate the installation directory:

{% highlight text %}
bundle info --path minima
{% endhighlight %}

> The minima theme is open source and available under the [MIT license](https://opensource.org/licenses/MIT), so we can freely copy and modify it. 
> Do include the LICENSE.txt file though.

The installation directory (e.g. _PATH/gems/minima-2.5.1_), should be returned by the command.
Navigate to the found directory and copy all files (excluding the `README.md`) to your own project's root directory.
Your project's root directory should now contain the following files and directories:

{% highlight text %}
your-new-website/
|--- _includes/
|--- _layouts/
|--- _posts/
|--- _sass/
|--- assets/
|--- 404.html
|--- _config.yml
|--- Gemfile
|--- Gemfile.lock
|--- index.markdown
|--- LICENSE.txt
{% endhighlight %}

Although we excluded the `README.md` file it actually contains useful information on the overall structure and usage 
of the minima theme.

Let's provide a brief overview on the directories you included in your project:

**_layouts** directory:
- Contains the markup for a specific web page. E.g. the `post.html` layout is the layout for your posts.

**_includes** directory:
- Contains sections that can be inserted and re-used in the different layouts. E.g. `footer.html` contains the footer and can be created once, to be referenced everywhere.

**_sass** directory:
- Contains the .scss files that define the actual style of your website. 

**Assets** directory:
- Contains all the assets of your theme (such as images) and the main entry-point of the scss.

### Clean-up references

Before tweaking or completely overhauling the minima theme, it's best to clean up the references to it:
1. In the `Gemfile` file, remove line `gem "minima", "~> 2.5"` (and the comment above it)
2. In the `_config.yml` file, remove line `theme: minima`

Lastly, we need to reference the plugins the minima theme was referencing.

In the `Gemfile` file, update the `jekyll-plugins` section to include plugin `jekyll-seo-tag`:
{% highlight text %}
group :jekyll_plugins do
  gem "jekyll-feed", "~> 0.12"
  gem "jekyll-seo-tag", "~> 2.6"
end
{% endhighlight %}

In the `_config.yml` file, update the `plugins` property to include plugin `jekyll-seo-tag`:
{% highlight text %}
plugins:
  - jekyll-feed
  - jekyll-seo-tag
{% endhighlight %}

Almost there:
1. Re-serve your website using `bundle exec jekyll serve` (stop & start). 
2. Navigate to [http://127.0.0.1:4000/](http://127.0.0.1:4000/) and validate your website still looks exactly like before.
3. Commit your changes.

You are now able to customize the theme to your own needs, as have full control over it.

## Continuous Deployment

Using GitHub Actions, we can easily automate the process of building the Jekyll website and deploying it to a web server 
after each push to the remote repository. For an example, see the [source code of this blog](https://github.com/nielsdelestinne/niedel.be/blob/master/.github/workflows/build-and-publish.yml).

## Resources

You can find the entire source code of this website & blog on [github.com](https://github.com/nielsdelestinne/niedel.be).

The following official resources contain more information on the discussed topics above:
- [Installation](https://jekyllrb.com/docs/installation/) 
- [Quickstart](https://jekyllrb.com/docs/) 
- [Step by step tutorial](https://jekyllrb.com/docs/step-by-step/01-setup/) 
- [Themes](https://jekyllrb.com/docs/themes/) 
