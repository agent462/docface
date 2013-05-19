DocFace
=========
DocFace turns your markdown files into html and makes them easy to view via a web page.

I mainly created DocFace because I use Opscode Chef and you end up with tons of README and CHANGELOG files.  I wanted to view these is some sane way.

<img src="https://raw.github.com/agent462/docface/downloads/screenshot.png" title="docface screenshot" />
Installation
-----------------------
~~~~
gem install docface
~~~~

From Source:
~~~~
gem build docface.gemspec
~~~~

Usage
-----------------------
~~~~
docface -d ~/git/chef -o ~/my_docs
~~~~

* For multiple directories include them seperated by a space

~~~~
docface -d ~/git/chef/cookbooks ~/git/chef/site-cookbooks 
~~~~

Table of Contents
-----------------
Want a table of contents on your pages?  Include the following snippet in your markdown file wherever you want the TOC.
~~~~
* This will be replaced with the ToC
{:toc}
~~~~

Contributions
-------------
Provide a pull request.  We're inheriting most styling from twitter bootstrap.  Visual/Design help appreciated.

License and Author
==================

Author:: Bryan Brandau <agent462@gmail.com>   
Author:: Andrew Painter <anpainte@gmail.com>

Copyright:: 2013, Bryan Brandau

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
