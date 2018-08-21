### Ruby Bowling

```bash
┌─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┐
│  9 /│  1 3│  9 /│  X  │  8 /│  7 -│  2 1│  8 1│  1 5│  4 1│     │
│   11│   15│   35│   55│   72│   79│   82│   91│   97│  102│  102│
└─────┴─────┴─────┴─────┴─────┴─────┴─────┴─────┴─────┴─────┴─────┘
```
Simulates a simplified game of bowling.

This is an exercise in learning Ruby and methodically refactoring code. After initially using a naive/one-file approach, the code was refactored into a class-based system.

Check out the [before](https://github.com/steviekaye/bowling/blob/6d5d4dcd454b280f391cb4da664504e62094b8de/bowling.rb) and [after](https://github.com/steviekaye/bowling/lib).

To run locally, assuming you have Ruby installed:  
```bash
git clone git@github.com:steviekaye/bowling.git  
cd bowling/  
ruby lib/bowling.rb
```

To run tests:
```bash
bundle install
rspec
```
