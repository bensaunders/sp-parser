# Log Parser exercise

The main file, `parser.rb`, can be called as a script, using
the syntax specified in the instructions.

`./parser.rb webserver.log`

It then calls out to a separate file which contains the classes
for the logic, and which is tested by `spec/log_parser_spec.rb`.

I've taken the approach recommended by Katrina Owen and Sandi Metz
in "99 Bottles of OOP": first, solving the problem in the simplest
way that will pass the tests, then refactoring towards a more
maintainable solution.
