# ChristmasTree

## Still a work in progress!

This is very much a work in progress if are curious about where this project is headed check out the wrapping paper branch.

## Installation

Add this line to your application's Gemfile:

    gem 'christmas_tree'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install christmas_tree

## Usage


## Standard Decoration

```ruby
class Parent < Struct.new(:name,:email); end
parent = Parent.new(name: "Hans", email: "test@example.com")

class ParentDecorator < ChristmasTree::Decorator
  delegate :email, to: model

  def name_with_title
    "Mr." + model.name
  end
end

decorator = ParentDecorator.new(parent)

decorator.name_with_title
#=> "Mr. Hans"

decorator.email
#=> "text@example.com"
```

## Explicit delagation

## Nested Presenation

```ruby
  class ParentPresenter < ChristmasTree::WrappingPaper
    def to_html
      tag(:h1) do |h1|
        h1.tag(:span, {class: "green") { "Hello, "}
        h1.text("World!")
      end
    end

    def to_json
      model.to_json(:root => false)
    end
  end

  class ParentDecorator < ChristmasTree::Ornament
    presents :html, :json

    # under the hood looks up for ParentPresnter
    # ParentPresenter.new(self).to_html
    # ParentPresenter.new(self).to_json

  end

  ParentDecorator.new(parent).to_html
```

## Authors

Micah Woods and Jonathan Jackson

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
