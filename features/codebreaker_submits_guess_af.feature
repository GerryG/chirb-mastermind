Feature: code-breaker submits guess

  The code-breaker submits a guess of four colored
  pegs. The mastermind game marks the guess with black
  and white "marker" pegs.
  
  For each peg in the guess that matches color
  and position of a peg in the secret code, the
  mark includes one black peg. For each additional
  peg in the guess that matches the color but not
  the position of a color in the secret code, a
  white peg is added to the mark.

  Scenario Outline: submit guess
    Given the symbol set is abcdef
    Given the secret code is <code>
    When I guess <guess>
    Then the mark should be <mark>

  Scenarios: all colors correct
    | code    | guess   | mark |
    | d c f b | d c f b | bbbb |
    | d c f b | d c b f | bbww |
    | d c f b | f d c b | bwww |
    | d c f b | b d c f | wwww |
    | d d b b | d d b b | bbbb |
    | b d b b | d b b b | bbww |
    | d b b f | d b f b | bbww |
    | d d b b | d b d b | bbww |
    | d d b b | b d d b | bbww |
    | d d b b | d b b d | bbww |
    | d d b b | b b d d | wwww |

  Scenarios: 3 colors correct
    | code    | guess   | mark |
    | d c f b | e c f b | bbb  |
    | d c f b | e d f b | bbw  |
    | d c f b | e d c b | bww  |
    | d c f b | e d c f | www  |

  Scenarios: 2 colors correct
    | code    | guess   | mark |
    | d c f b | e c e b | bb   |
    | d c f b | e d e b | bw   |
    | d c f b | c e b e | ww   |
    | d d b b | d d d e | bb   |
    | d d b b | e b b b | bb   |
    | d d b b | e d d d | bw   |
    | d d b b | b b b e | bw   |

  Scenarios: 1 color correct
    | code    | guess   | mark |
    | d c f b | d e e e | b    |
    | d d b b | e f b e | b    |
    | d c f b | e e d e | w    |
    | d d b b | e b f e | w    |
    | d d b b | e f d e | w    |
    | d d b b | e b f e | w    |
