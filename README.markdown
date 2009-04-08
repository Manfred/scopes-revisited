# Scopes Revisited

Trying to find better ways to implement scopes in Active Record.

See [http://github.com/Manfred/rails/tree/scopes](http://github.com/Manfred/rails/tree/scopes) for the actual merge with Rails.

## Objectives

* Make scope stack merging more transparent (ie. not in a method with 5-level-deep nested if statements)
* Make scopes thread-safe
* Re-evaluate method and variable naming

## Ideas

* Merge scope stacks as late as possible to enable smarter merging
* Delegate and federate stack merging (ie. Scopes don't need to know how associations merge their query parameters)

---

### TODO

* Refactor existing named scope tests and make them run
- Implement default scopes (AR::Base.default_scope)
- Implement dynamic scopes (AR::Base#scoped)
- Write a whole gang of new tests for merging scope stacks
- Start adding tests for hard to merge scope stacks
- Start adding tests for smart merging stacks (see tickets below)
- Scout Lighthouse and gather tests for existing problems with scopes and fix them
  - Merge string conditions if possible, otherwise raise a sensible exception
    [http://rails.lighthouseapp.com/projects/8994/tickets/2199](http://rails.lighthouseapp.com/projects/8994/tickets/2199)
  - Merge order scope options instead of overriding them
    [http://rails.lighthouseapp.com/projects/8994/tickets/2253](http://rails.lighthouseapp.com/projects/8994/tickets/2253)
  - Make associations respect the default scope
    [http://rails.lighthouseapp.com/projects/8994/tickets/2297](http://rails.lighthouseapp.com/projects/8994/tickets/2297)
  - All scope definitions of _any_ kind should override default scopes
    [http://rails.lighthouseapp.com/projects/8994/tickets/2257](http://rails.lighthouseapp.com/projects/8994/tickets/2257)
  - Default scope should accept a proc
    [http://rails.lighthouseapp.com/projects/8994/tickets/1812](http://rails.lighthouseapp.com/projects/8994/tickets/1812)
  - Find a way to merge :select query parameters in count queries.
    [http://rails.lighthouseapp.com/projects/8994/tickets/1334](http://rails.lighthouseapp.com/projects/8994/tickets/1334)
  - Implement #many? on scopes and associations so they don't load the entire collection.
    [http://rails.lighthouseapp.com/projects/8994/tickets/1500](http://rails.lighthouseapp.com/projects/8994/tickets/1500)

### DONE

- Start merging the new scope implementation into Rails and get some simple queries running
