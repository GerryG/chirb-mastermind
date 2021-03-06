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
    Given the secret code is <code>
    When I guess <guess>
    Then the mark should be <mark>

  Scenarios: all colors correct
    | code    | guess   | mark |
    | r g y c | r g y c | bbbb |
    | r g y c | r g c y | bbww |
    | r g y c | y r g c | bwww |
    | r g y c | c r g y | wwww |
    | r r c c | r r c c | bbbb |
    | c r c c | r c c c | bbww |
    | r c c y | r c y c | bbww |
    | r r c c | r c r c | bbww |
    | r r c c | c r r c | bbww |
    | r r c c | r c c r | bbww |
    | r r c c | c c r r | wwww |

  Scenarios: 3 colors correct
    | code    | guess   | mark |
    | r g y c | w g y c | bbb  |
    | r g y c | w r y c | bbw  |
    | r g y c | w r g c | bww  |
    | r g y c | w r g y | www  |

  Scenarios: 2 colors correct
    | code    | guess   | mark |
    | r g y c | w g w c | bb   |
    | r g y c | w r w c | bw   |
    | r g y c | g w c w | ww   |
    | r r c c | r r r w | bb   |
    | r r c c | w c c c | bb   |
    | r r c c | w r r r | bw   |
    | r r c c | c c c w | bw   |

  Scenarios: 1 color correct
    | code    | guess   | mark |
    | r g y c | r w w w | b    |
    | r r c c | w y c w | b    |
    | r g y c | w w r w | w    |
    | r r c c | w c y w | w    |
    | r r c c | w y r w | w    |
    | r r c c | w c y w | w    |
