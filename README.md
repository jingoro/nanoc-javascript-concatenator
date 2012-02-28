# Nanoc JavaScript Concatenator

A simple way to concatenate JavaScript files in Nanoc.

## Installation

### 1. Install the gem

Add this line to your application's Gemfile:

    gem 'nanoc-javascript-concatenator'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nanoc-javascript-concatenator

### 2. Require the gem

Add this line to your site's `lib/default.rb`:

    require 'nanoc/filters/javascript_concatenator'

## Usage

Add a file to concatenate any JavaScript files together, e.g., `js/all.js`:

    //= require include/first.js
    //= require include/second.js
    //= require include/third.js

Compile it with the `concat_js` filter in `Rules`:

    compile '/js/all/' do
      filter :concat_js
    end

Ignore any included JavaScript in `Rules`:

    route '/js/include/*/' do
      nil
    end
