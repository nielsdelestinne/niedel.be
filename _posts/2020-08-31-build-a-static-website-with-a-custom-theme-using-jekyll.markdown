---
layout: post
title:  "Build a static website with a custom theme using Jekyll"
date:   2020-08-31
author: "Niels Delestinne"
categories: website
comments: true
---

Jekyll is a blog-enabled static site generator that cleanly separates content from mark-up and renders static pages for deployment. Sounds good? Great, I'll guide you to the fundamentals of setting up a website yourself using Jekyll.   

## Installation 

Jekyll is written in Ruby and requires Ruby to be installed on your local development environment.
1. Download & install [Ruby](https://www.ruby-lang.org/en/downloads/), The version used for this tutorial was 2.7.1
2. Validate the installation by checking its version: `ruby -v`
2. Ruby will come packaged with RubyGem, validate the installation by checking its version: `gem -v`

Jekyll is a so-called Gem, which is a 'distribution' or 'artifact' in Ruby's ecosystem. It contains the code and documentation of an application or library.
Once Ruby is installed, we can install the Jekyll & [Bundler](https://rubygems.org/gems/bundler) Gems: 
{% highlight bash %}
gem install jekyll bundler
{% endhighlight %}

## Initialization

The next step is to generate the entire technical skeleton of the new website we want to create.

Create a new Jekyll website by using the Jekyll Gem:
{% highlight bash %}
jekyll new your-new-website
{% endhighlight %}

A new directoy `./your-new-website` is created.

when executing a command, it's always interesting to inspect the output. For the `new` command of `jekyll`, we detect all the (transative) dependencies that are downloaded and installed.
- 35 gems (dependencies) are installed
- The version of Jekyll we are depending on is 4.1.1. 

{% highlight bash %}
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
Inside, we discover the following structure:
{% highlight cmd %}
your-new-website/
|--- _posts/
    |--- 2020-09-14-welcome-to-jekyll.markdown
|--- 404.html
|--- _config.yml
|--- Gemfile
|--- Gemfile.lock
|--- index.markdown
{% endhighlight %} 

A short description on what's what:

**_posts/** directory 
- Contains the blog posts, each markdown file represents a single blog post and contains purely the content.

**404.html**:
- Is returned as the response whenever the provided page-url could not be resolved (not found).

**Gemfile**(.lock) 
- Contains the dependencies (gems & their specific version) required for building & running the Jekyll website. Although not entirely the same, it's relatively similar to NPM's `package.json` file.

**index.markdown**
- Represents the index (home) page and contains its content.

**_config.yml** 
- Contains the configuration of your website (settings, variables, activated plugins, meta information,...)

> Besides configuration and content, there is no actual HTML or (S)CSS contained in the project directory. This is only possible when there's a clean separation between content and mark-up.
 
Render the website and take a peek at what it looks like on [http://127.0.0.1:4000/](http://127.0.0.1:4000/):

1. Git & gitignore!
2. Template erin trekken en customizen
2. `bundle info --path minima`
3. Clean up gem & config
1. Installation steps from official Jekyll tutorial
2. Git Actions opt einde
3. provide official resources



{% highlight bash %}
bundle exec jekyll serve
{% endhighlight %}

{% highlight cmd %}
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
{% endhighlight %} 



2. `bundle info --path minima`
3. Clean up gem & config
1. Installation steps from official Jekyll tutorial
2. Explore initial setup & breakdown of file structure (what is generate, what not, git ignores,...)
3. Custom theme steps (as in website: https://jekyllrb.com/docs/themes/)

and some more

1. Installation steps from official Jekyll tutorial
2. Explore initial setup & breakdown of file structure (what is generate, what not, git ignores,...)
3. Custom theme steps (as in website: https://jekyllrb.com/docs/themes/)

and some more

- wxcwxc
- wxcwxcwxc

{% highlight java %}
@Named
public class CommandBusConfiguration {

    private final CommandBus commandBus;
    private final BotRepository botRepository;

    public CommandBusConfiguration(
            CommandBus commandBus,
            BotRepository botRepository) {
        this.commandBus = commandBus;
        this.botRepository = botRepository;
        this.registerCommandHandlers();

    }

    private void registerCommandHandlers() {
        var yo = "hello";
        commandBus.registerHandler(new CreateBotCommandHandler(botRepository), CreateBotCommand.class);
    }
}

{% endhighlight %}

Check out the [Jekyll docs][jekyll-docs] for more info on how to get the most out of Jekyll. File all bugs/feature requests at [Jekyll’s GitHub repo][jekyll-gh]. If you have questions, you can ask them on [Jekyll Talk][jekyll-talk].

[jekyll-docs]: https://jekyllrb.com/docs/home
[jekyll-gh]:   https://github.com/jekyll/jekyll
[jekyll-talk]: https://talk.jekyllrb.com/
