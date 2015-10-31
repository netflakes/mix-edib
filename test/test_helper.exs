ExUnit.configure capture_log: true,
                 max_cases:   1

Pavlov.start # see: https://github.com/sproutapp/pavlov

# Important note:
# use Pavlov.Case
# ^-- do not set `async: true`, otherwise capturing of IO fails miserably
