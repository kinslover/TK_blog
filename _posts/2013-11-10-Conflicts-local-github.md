---
layout: post
title: Conflicts between viewing site on github and previewing it locally
comments: true

---

I decided to distribute a new blog on Github with Jekyll yesterday, because I really like its simple style and I can write locally and push it to github, which is really convenient. During the procedure of configuring my site and writing articles, it is quite inconvenient to commit and push, when we want to test the effect, because some changes may be very tiny. Thus to test my site more efficiently, I have the Jekyll locally installed.

However, the `baseurl` in _config.yml causes a very annoying problem that makes the site either works well on Github or locally, but cannot work at the same time without changing the codes. Here is a short description of the problem. I don't have my own domain name for my site, so I have a domain name like `username.github.io/your_blog_name/`. The problem is that if I want to have the site run on Github, I need to set

```
baseurl = /your_blog_name
```

which will make your site fail to run locally. If I set

```
baseurl = /
```

the site is ok locally but fails on Github.

The detainls of this problem is quite stated [here][github_sol]. Thanks to [**mjswensen**][mjswensen], we got a solution for this problem. I am going to make a summary and small complements, in case that someone needs it.

- First, set  `baseurl = /your_blog_name` in _config.yml
- Second, for reference to css files, 

{% highlight html%}
<link rel="stylesheet" href="{{ site.baseurl }}/css/syntax.css">
{% endhighlight %}

- Third, for reference to post files, do it like this

{% highlight html%}
<a href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a>
{% endhighlight %}

Here please DO NOT put any slash between `{{ site.baseurl }}` and `{{ post.url }}`. Actually this is because `{{ post.url }}` contains a slash at the beginning and double slashes would cause problem to the URL.

- Forth, if you want to have a home button or something similar, write it as

{% highlight html%}
<a class="extra" href="{{ site.baseurl }}/">home</a>
{% endhighlight %}

If you follow the above instructions, your site will probably run well on Github, but it still fails for local run.

The trick to do the local part is to use the following command

{% highlight bash%}
jekyll serve --baseurl ''
{% endhighlight %}

to run your site. This command assigns an empty string as the baseurl temporarily without changing _config.yml file. Problem solved. 



[github_sol]: https://github.com/mojombo/jekyll/issues/332#issuecomment-18952908

[mjswensen]: https://github.com/mjswensen