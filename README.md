# Interface
Interface pattern implementation for Ruby

# Example
You have to include `interface.rb` to your project and then...

```
class Food
  include Interface

  needs_implementation :taste
end

class Donut < Food
end
```

```
$> Donut.new.taste
Interface::NotImplementedError: Donut needs to implement taste for Food
```
