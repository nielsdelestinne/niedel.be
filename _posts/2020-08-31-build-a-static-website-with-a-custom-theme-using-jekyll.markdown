---
layout: post
title:  "Build a static website with a custom theme using Jekyll"
date:   2020-08-31 19:45:00 +0200
author: "Niels Delestinne"
categories: jekyll website theme
---

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus consectetur finibus tortor, et hendrerit velit ultrices ac. Etiam vestibulum mollis felis, ac pellentesque dui fringilla ut. Nunc nec ex sit amet nisl interdum fringilla.

Afamet, consectetur adipiscing elit. Phasellus consectetur finibus tortor, et hendrerit velit ultrices ac. Etiam vestibulum mollis felis, ac pellentesque dui fringilla ut. Nunc nec ex sit amet nisl interdum fringilla. Duis egestas pretium purus cursus dapibus. In suscipit a libero eu vehicula. Aliquam ac nisi nibh. Integer aliquet felis eros, ullamcorper lacinia arcu suscipit sed. Nullam pellentesque elementum ultrices. Aenean elementum efficitur mauris non mattis. Vivamus rhoncus ex sit amet lobortis pretium.

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
