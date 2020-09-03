---
layout: post
title:  "Build a static website with a custom theme using Jekyll"
date:   2020-08-31 19:45:00 +0200
author: "Niels Delestinne"
categories: jekyll website theme
---

1. Installation steps from official Jekyll tutorial
2. Explore initial setup & breakdown of file structure (what is generate, what not, git ignores,...)
3. Custom theme steps (as in website: https://jekyllrb.com/docs/themes/)

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
